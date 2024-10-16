"
I collect and cache text line segments for fast access by index.

## Internal Representation and Key Implementation Points.

### Instance Variables

	editor 				<BrTextEditor>	The editor that owns this cache
	limit 					<Integer> The (soft) maximum number of segments in the cache, see below.
	map 					<BrTextLineMap> 	The line number to character index map
	segments 				<OrderedCollection of BrTextEditorLineSegment>		The cached segments
	segmentsInterval 	<Interval> 	The interval of line numbers cached in segments
	subText 				<BlSubText>
	text      			<BlText>		The text being edited

### Implementation Points

To facilitate jumping backwards quickly the the manager builds a map of line number to charcter offset of the string being edited.  When the target line number is earlier than the cache start the map can be used as a known point to start parsing forward from.


The limit represents the maximum number of items held by the receiver when an uncached segment is requested ({{gtMethod:name=BrTextEditorSegmentCollector>>#segmentAt:}}).  If segments are added via {{gtMethod:name=BrTextEditorSegmentCollector>>#addSegments:after:}} or {{gtMethod:name=BrTextEditorSegmentCollector>>#addSegments:before:}} the limit may be safely exceeded.

"
Class {
	#name : #BrTextEditorSegmentCollector,
	#superclass : #Object,
	#instVars : [
		'text',
		'subText',
		'segments',
		'limit',
		'editor',
		'segmentsInterval',
		'map'
	],
	#category : #'Brick-Editor-Model - Segment-Text'
}

{ #category : #'api - modifications' }
BrTextEditorSegmentCollector >> addSegments: aCollectionOfSegments after: aSegment [
	"Add the supplied collection of segments to the receiver after aSegment.
	This may safely cause the number of cached segments to exceed limit."

	self
		assert: [ aCollectionOfSegments isNotEmpty ]
		description: [ 'Can not add a collection of empty segments!' ].

	self assertSegmentsIntervalConsistency.

	aCollectionOfSegments
		withIndexDo: [ :aNewSegment :anIndex | 
			aNewSegment index: anIndex + aSegment index.
			segments
				add: aNewSegment
				afterIndex: aSegment index - self firstSegmentIndex + anIndex ].

	self
		offsetSegmentIndicesBy: aCollectionOfSegments size
		after: aCollectionOfSegments last index.

	self assertSegmentsIntervalConsistency.

	self editor
		notifyItemsInserted: (aCollectionOfSegments first index to: aCollectionOfSegments last index)
]

{ #category : #'api - modifications' }
BrTextEditorSegmentCollector >> addSegments: aCollectionOfSegments before: aSegment [
	"Add the supplied collection of segments to the receiver before aSegment.
	This may safely cause the number of cached segments to exceed limit."

	self
		assert: [ aCollectionOfSegments isNotEmpty ]
		description: [ 'Can not add a collection of empty segments!' ].
	
	self
		assert: [ segments size = segmentsInterval size ]
		description: [ 'Amount of segments must correspond to the interval' ].

	self
		assert: [
			| satisfy |
			satisfy := true.
			segments with: segmentsInterval do: [ :eachSegment :anExpectedIndex |
				satisfy := satisfy and: [ eachSegment index = anExpectedIndex ]	].
			satisfy ]
		description: [ 'Segment indices must correspond to the interval' ].

	aCollectionOfSegments withIndexDo: [ :aNewSegment :anIndex |
		aNewSegment index: (aSegment index - aCollectionOfSegments size) + anIndex.
		segments
			add: aNewSegment
			afterIndex: aNewSegment index - 1 ].
	
	self offsetSegmentIndicesBy: aCollectionOfSegments size after: aCollectionOfSegments last index.

	self editor notifyItemsInserted: (aCollectionOfSegments first index to: aCollectionOfSegments last index).
	
	self
		assert: [ segments size = segmentsInterval size ]
		description: [ 'Amount of segments must correspond to the interval' ].
		
	self
		assert: [
			| satisfy |
			satisfy := true.
			segments with: segmentsInterval do: [ :eachSegment :anExpectedIndex |
				satisfy := satisfy and: [ eachSegment index = anExpectedIndex ]	].
			satisfy ]
		description: [ 'Segment indices must correspond to the interval' ].
]

{ #category : #'private - asserting' }
BrTextEditorSegmentCollector >> assertSegmentsIntervalConsistency [
	self
		assert: [ segments size = segmentsInterval size ]
		description: [ 'Amount of segments must correspond to the interval' ].

	self
		assert: [ | satisfy |
			satisfy := true.
			segments
				with: segmentsInterval
				do: [ :eachSegment :anExpectedIndex | satisfy := satisfy and: [ eachSegment index = anExpectedIndex ] ].
			satisfy ]
		description: [ 'Segment indices must correspond to the interval' ]
]

{ #category : #accessing }
BrTextEditorSegmentCollector >> cacheLimit [
	"Answer the maximum number of segments that will be loaded by #segmentAt:.
	Explicitly adding segments via #addSegments:after: or #addSegments:before: may safely exceed this limit."
	<return: #Number>
	
	^ limit
]

{ #category : #accessing }
BrTextEditorSegmentCollector >> cacheLimit: aNumber [
	"Set the soft maximum number of segments to cache.
	See the class comments for further information."

	limit := aNumber
]

{ #category : #accessing }
BrTextEditorSegmentCollector >> cachedInterval [
	"Return the interval of the indices of the currently cached segments"
	<return: #Number>

	^ segmentsInterval
]

{ #category : #'cache - accessing' }
BrTextEditorSegmentCollector >> cachedSegmentAt: anIndex [
	"Return a cached segment at an absolute index within editor
	(I must convert index from editor coordiantes to my local cache coordinates)"
	<return: #BrTextEditorSegment>
	| aCachedIndex |

	aCachedIndex := anIndex - segmentsInterval first + 1.
	^ segments at: aCachedIndex
]

{ #category : #'cache - computation' }
BrTextEditorSegmentCollector >> computeForwardAt: anIndex [
	| intervalEnd cachedInterval actualStart skip forwardText stream builder  position length |

	position := (map mapEntryFor: anIndex) key.
	length := (self cacheLimit / 2) rounded.
	[(position := position + length) < anIndex] 
		whileTrue: [self computeForwardAt: position].
	
	"the index of the last already cached segment"
	intervalEnd := segmentsInterval last.

	"indices interval of segments that we expect to cache in the end"
	cachedInterval := self computeInterval: anIndex.

	"new cached interval may overlap with existing cache, take it into account
	by computing an actual cache start index of a segment"
	actualStart := cachedInterval first max: (intervalEnd + 1).
	skip := actualStart - (intervalEnd + 1).
	forwardText := self forwardText.
	
	"the collection in which we will cache segments"
	segments := self forwardSegments: cachedInterval.

	stream := BrEditorSegmentStream new.
	stream skip: skip.
	stream limit: self cacheLimit - segments size.
	builder := self editor segmentBuilder.
	
	builder
		split: forwardText
		in: stream
		offset: ((forwardText start - text textOffset - 1) max: 0).
	
	segments addAll: stream collection.
	segmentsInterval := cachedInterval first to: cachedInterval first + segments size - 1.
	
	self privateRecomputeSegmentIndices.
	self privateRecomputeSubText.
	map addLine: segmentsInterval first offset: subText start.
]

{ #category : #'cache - computation' }
BrTextEditorSegmentCollector >> computeInterval: anIndex [
	<return: #Interval>
	| start end |
	
	start := anIndex - (self cacheLimit / 2) rounded.
	start := start max: 1.
	end := start + self cacheLimit - 1.
	
	^ start to: end
]

{ #category : #'cache - accessing' }
BrTextEditorSegmentCollector >> computedSegmentsCount [
	"Return amount of cached segments. If segments are not cached,
	try to cache them and return their amount"
	<return: #Number>
	
	self hasCached
		ifFalse: [ self computeForwardAt: 1 ].

	^ self lastSegmentIndex
]

{ #category : #accessing }
BrTextEditorSegmentCollector >> editor [
	<return: #BrTextEditorModel>

	^ editor
]

{ #category : #accessing }
BrTextEditorSegmentCollector >> editor: aBrTextEditor [
	self
		assert: [ editor isNil ]
		description: [ 'Can only be attached once' ].
	
	editor := aBrTextEditor
]

{ #category : #'cache - accessing' }
BrTextEditorSegmentCollector >> end [
	"Return the index of the last cached item in the text or 0 if nothing is cached"
	<return: #Number>
	
	^ self hasCached
		ifTrue: [ subText end ]
		ifFalse: [ 0 ]
]

{ #category : #'cache - accessing' }
BrTextEditorSegmentCollector >> findCachedSegmentForLetterAt: aTextIndex ifFound: aFoundBlock ifNotFound: aNotFoundBlock [
	| segmentIndex segment |
	segmentIndex := self privateFindCachedSegmentIndexForLetterAt: aTextIndex.
	segmentIndex = 0 ifTrue: [ ^ aNotFoundBlock cull: self ].
	segment := segments at: segmentIndex.
	^ aFoundBlock cull: segment
]

{ #category : #'cache - accessing' }
BrTextEditorSegmentCollector >> firstIndex [	
	self
		deprecated: 'Use #firstSegmentIndex'
		transformWith: '`@receiver firstIndex' -> '`@receiver firstSegmentIndex'.
	
	^ self firstSegmentIndex
]

{ #category : #'cache - accessing' }
BrTextEditorSegmentCollector >> firstSegmentIndex [
	"Return the index of the first cached segment or 0 if there are no cached segments"
	<return: #Number>
	
	^ self hasCached
		ifTrue: [ segments first index ]
		ifFalse: [ 0 ]
]

{ #category : #'cache - computation' }
BrTextEditorSegmentCollector >> forwardSegments: aNewCachedInterval [
	"Create and return a collection which will be used to collect segments for a given new cached interval.
	If existing cached interval overlaps with the new one, we should copy already cached segments to reduce amount of work"
	<return: #SequenceableCollection of: #BrTextEditorSegment>
	| startIndex |

	startIndex := aNewCachedInterval first - segmentsInterval first + 1.
	^ (self isCachedAt: aNewCachedInterval first)
		ifTrue: [ segments copyFrom: startIndex to: segments size ]
		ifFalse: [ self newSegments ]
]

{ #category : #'cache - computation' }
BrTextEditorSegmentCollector >> forwardText [
	"Return a forward text that start from the next item after the last cached one"
	<return: #BlText>
	| textStart textEnd |

	text isEmpty
		ifTrue: [ ^ BlSubText empty: text ].

	textStart := self end + 1.
	textEnd := text size.

	^ text from: textStart to: textEnd
]

{ #category : #testing }
BrTextEditorSegmentCollector >> hasCached [
	"Return true if there are cached segments, false otherwise"
	<return: #Boolean>

	^ segments isNotEmpty
]

{ #category : #initialization }
BrTextEditorSegmentCollector >> initialize [
	super initialize.	
	limit := 500.
	subText := BlSubText text: '' asRopedText from: 1 to: 0.
	self resetCache.
]

{ #category : #testing }
BrTextEditorSegmentCollector >> isCachedAt: anIndex [
	"Return true if I have a cached segment at a given index, false otherwise"
	<return: #Boolean>

	^ segmentsInterval rangeIncludes: anIndex
]

{ #category : #'cache - accessing' }
BrTextEditorSegmentCollector >> lastIndex [
	self
		deprecated: 'Use #lastSegmentIndex'
		transformWith: '`@receiver lastIndex' -> '`@receiver lastSegmentIndex'.
	
	^ self lastSegmentIndex
]

{ #category : #'cache - accessing' }
BrTextEditorSegmentCollector >> lastSegmentIndex [
	"Return the index of the last cached segment or 0 if there are no cached segments"
	<return: #Number>
	
	^ self hasCached
		ifTrue: [ segments last index ]
		ifFalse: [ 0 ]
]

{ #category : #'api - modifications' }
BrTextEditorSegmentCollector >> moveTextBy: aNumber [
	"Move all segments' subTexts start/end indices by aNumber"

	self hasCached
		ifFalse: [ ^ self ].
	
	segments do: [ :aSegment | aSegment moveTextBy: aNumber ].
	self privateRecomputeSubText
]

{ #category : #'api - modifications' }
BrTextEditorSegmentCollector >> moveTextBy: aNumber after: aSegment [
	"Move all segments after the given segment by aNumber"

	aSegment index + 1 to: self lastSegmentIndex do: [ :anIndex |
		| eachSegment |
		eachSegment := self cachedSegmentAt: anIndex.
		eachSegment moveTextBy: aNumber ].
	
	self privateRecomputeSubText
]

{ #category : #initialization }
BrTextEditorSegmentCollector >> newSegments [
	"Return a new empty collection that will be used to store segments"
	<return: #SequenceableCollection>

	^ OrderedCollection new
]

{ #category : #'api - modifications' }
BrTextEditorSegmentCollector >> offsetSegmentIndicesBy: anOffset [
	"Offset segments' #index by anOffset of all cached segments"
	
	self
		offsetSegmentIndicesBy: anOffset
		after: self firstSegmentIndex - 1
]

{ #category : #'api - modifications' }
BrTextEditorSegmentCollector >> offsetSegmentIndicesBy: anOffset after: aSegmentIndex [
	"Offset segments' #index by anOffset of all segments after a given segment index"
	
	self
		assert: [ aSegmentIndex + 1 >= self firstSegmentIndex ]
		description: [ 'Segment index must be greater or equal first segment index ' ].

	"Note: #lastSegmentIndex is not valid during execution of this method!"
	aSegmentIndex + 1 to: (segments size + self firstSegmentIndex - 1) do: [ :anIndex |
		| eachSegment |
		eachSegment := self cachedSegmentAt: anIndex.
		eachSegment index: eachSegment index + anOffset ].
	
	"actual cached interval changed, update it"
	segmentsInterval := segmentsInterval first to: segmentsInterval last + anOffset
]

{ #category : #'private - computing' }
BrTextEditorSegmentCollector >> privateComputeBackwardAt: anIndex [
	"Populate the cache at anIndex, which is prior to the start of the currently cached segments."
	| mapEntry cachedInterval stream builder newSubText newSegments overlap streamLimit |

	"Look for the map entry just earlier than anIndex
	(removing the need to parse the text from the beginning of the string to the found mapEntry"
	cachedInterval := self computeInterval: anIndex.
	mapEntry := map mapEntryFor: cachedInterval first.
	newSubText := text from: mapEntry value to: text size.
	newSegments := OrderedCollection new.

	overlap := cachedInterval last - segmentsInterval first + 1.
	streamLimit := overlap > 0
		ifTrue: [ overlap ]
		ifFalse: [ self cacheLimit ].
	stream := BrEditorSegmentStream new.
	stream skip: cachedInterval first - mapEntry key.
	stream limit: streamLimit.
	builder := self editor segmentBuilder.
	
	builder
		split: newSubText
		in: stream
		offset: ((newSubText start - text textOffset - 1) max: 0).
	
	newSegments addAll: stream collection.
	overlap > 0 ifTrue:
		[ newSegments addAll: (segments copyFrom: 1 to: overlap) ].
	segmentsInterval := cachedInterval first to: cachedInterval first + newSegments size - 1.
	segments := newSegments.

	self privateRecomputeSegmentIndices.
	self privateRecomputeSubText.
]

{ #category : #'private - computing' }
BrTextEditorSegmentCollector >> privateComputeSegmentAt: anIndex [
	<return: #BrTextEditorSegment>

	self
		assert: [ (self isCachedAt: anIndex) not ]
		description: [ 'Computing of already cached segment is wasteful' ].

	anIndex > self lastSegmentIndex
		ifTrue: [ self computeForwardAt: anIndex ]
		ifFalse: [ self privateComputeBackwardAt: anIndex ].

	self
		assert: [ self isCachedAt: anIndex ]
		description: [ 'Segment must be already cached!' ].

	^ self cachedSegmentAt: anIndex
]

{ #category : #'private - accessing' }
BrTextEditorSegmentCollector >> privateFindCachedSegmentIndexForLetterAt: aTextIndex [
	"Return an index of a segment in a collection of cached segments that contains
	a text item with a given index or return 0 if no such *cached* segment exists.
	I use binary search to find a segment, algorithmic complexity O(log n)"
	<return: #Number>

	^ segments
		findBinaryIndex: [ :aSegment |
			(aTextIndex between: aSegment textStart and: aSegment textEnd)
				ifTrue: [ 0 ]
				ifFalse: [
					aTextIndex < aSegment textStart
						ifTrue: [ -1 ]
						ifFalse: [ 1 ] ] ]
		ifNone: [ :a :b |
			| anAssoc |
			
			anAssoc := (segments
				at: a
				ifAbsent: [ nil ]) -> a.
			
			anAssoc key ifNil: [
				anAssoc := (segments
					at: b
					ifAbsent: [ nil ]) -> b. ].

			anAssoc key
				ifNil: [ 0 ]
				ifNotNil: [ :aSegment |
					(aTextIndex between: aSegment textStart and: aSegment textEndDelimited)
						ifTrue: [ anAssoc value ]
						ifFalse: [ 0 ] ] ]
]

{ #category : #'private - computing' }
BrTextEditorSegmentCollector >> privateRecomputeSegmentIndices [
	"Recompute segment indices according to currently cached inerval"
	
	self
		assert: [ self hasCached ]
		description: [ 'There must be cached segments in order to compute sub text' ].
	
	self
		assert: [ segments size = segmentsInterval size ]
		description: [ 'Cached segments interval must correspond to amount of segments' ].
		
	segments
		with: segmentsInterval
		do: [ :aSegment :anIndex | aSegment index: anIndex ]
]

{ #category : #'private - computing' }
BrTextEditorSegmentCollector >> privateRecomputeSubText [
	"Recompute subtext according to currently cached segments"
	| subTextStart subTextEnd |

	self
		assert: [ self hasCached ]
		description: [ 'There must be cached segments in order to compute sub text' ].

	subTextStart := segments first textStart + 1.
	subTextEnd := segments last textEnd + 1.
	"Allow for the fact that the last line in the string may not have a line-end character"
	subTextEnd > text size ifTrue: [ subTextEnd := subTextEnd - 1 ].
	subText := text from: subTextStart to: subTextEnd.

	"The following assertion should always be true, but is very expensive.
	Only used if a problem is suspected."
	"self assert: subText asString lines size <= segments size."
]

{ #category : #'private - accessing' }
BrTextEditorSegmentCollector >> privateSegments [
	"Never access segments directly"
	<return: #SequenceableCollection of: #BrTextEditorSegment>

	^ segments
]

{ #category : #'api - modifications' }
BrTextEditorSegmentCollector >> removeSegmentInterval: anInterval [
	"Remove all segments within index interval"
	| aFirstIndex |
	
	aFirstIndex := self firstSegmentIndex.

	anInterval reverseDo: [ :anIndex | segments removeAt: (anIndex - aFirstIndex + 1) ].
	
	segments
		withIndexDo: [ :eachSegment :anIndex | eachSegment index: (aFirstIndex + anIndex - 1) ].
	
	segmentsInterval := (segments first index to: segments last index).

	self editor notifyItemsRemoved: anInterval
]

{ #category : #initialization }
BrTextEditorSegmentCollector >> resetCache [

	segmentsInterval := 0 to: 0.
	segments := OrderedCollection new.
	map := BrTextLineMap new.
	map cacheLimit: limit.
]

{ #category : #accessing }
BrTextEditorSegmentCollector >> segmentAt: anIndex [
	"Return segment at given index"
	<return: #BrTextEditorSegment>
	
	^ (self isCachedAt: anIndex)
		ifTrue: [ self cachedSegmentAt: anIndex ]
		ifFalse: [ self privateComputeSegmentAt: anIndex ]
]

{ #category : #'private - accessing' }
BrTextEditorSegmentCollector >> segments [
	^ self privateSegments
]

{ #category : #'cache - accessing' }
BrTextEditorSegmentCollector >> start [
	"Return the index of the first cached item in the text or 0 if nothing is cached"
	<return: #Number>

	^ self hasCached
		ifTrue: [ subText start ]
		ifFalse: [ 0 ]
]

{ #category : #accessing }
BrTextEditorSegmentCollector >> text [
	<return: #BlText>

	^ text
]

{ #category : #accessing }
BrTextEditorSegmentCollector >> text: aBrText [
	text := aBrText
]
