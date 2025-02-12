"
I am a simple line-based segment builder and do not take text attributes into account.

Note: I do not support embedded elements
"
Class {
	#name : #BrTextEditorLineSegmentBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'wordStencilBuilder',
		'lineSplitter'
	],
	#category : #'Brick-Editor-Model - Segment-Text'
}

{ #category : #'text - modifications' }
BrTextEditorLineSegmentBuilder >> attributesModifiedFrom: aFromIndex to: aToIndex in: aBrTextEditor affectedText: anAffectedText [
	"Is sent after attributes were added or removed in a provided text editor"

	| attributedSubText |
	"It is possible that the segment structure has changed"
	self
		assert: [ aFromIndex <= (aToIndex + 1) ]
		description: [ '`From` index must be less or equal to `to` index' ].
	BrTextEditorAttributesModifiedSignal new
		textEditor: aBrTextEditor;
		fromIndex: aFromIndex;
		toIndex: aToIndex;
		affectedText: anAffectedText;
		emit.
	attributedSubText := aBrTextEditor text from: (aFromIndex max: 1) to: aToIndex.
	(self requiresResplittingFrom: attributedSubText to: anAffectedText)
		ifTrue: [ self resetSegmentCacheAndNotify: aBrTextEditor ]
		ifFalse: [ aBrTextEditor updater
				from: aFromIndex to: aToIndex;
				update ]
]

{ #category : #'api - accessing' }
BrTextEditorLineSegmentBuilder >> beEditable [
	self wordStencil: BrTextEditableWordPieceStencilBuilder new
]

{ #category : #'api - accessing' }
BrTextEditorLineSegmentBuilder >> beReadOnly [
	self wordStencil: BrTextReadonlyWordPieceStencilBuilder new
]

{ #category : #initialization }
BrTextEditorLineSegmentBuilder >> defaultSplitter [
	^ BrTextEditorSplitter new
		segmentClass: BrTextEditorParagraphSegment;
		yourself
]

{ #category : #'private - deletion' }
BrTextEditorLineSegmentBuilder >> deleteFrom: aFromIndex segment: aFromSegment to: aToIndex segment: aToSegment in: aBrTextEditor [
	"I do the hard work of updating segment structure after deleting a piece of text within provided interval and segments"
	| shouldMergeWithPrevious aTargetSegment removedLength aNewEnd aNewStart |
	
	shouldMergeWithPrevious := self
		shouldMergeDeletingFrom: aFromIndex
		segment: aFromSegment
		in: aBrTextEditor.

	aTargetSegment := shouldMergeWithPrevious
		ifTrue: [ aBrTextEditor segmentCollector segmentAt: (aFromSegment index - 1) ]
		ifFalse: [ aFromSegment ].

	removedLength := aToIndex - aFromIndex + 1.

	"New end can be zero, in this case we should make new start zero too"
	aNewEnd := aToSegment textEnd - removedLength.
	aNewStart := aTargetSegment textStart min: aNewEnd.

	aTargetSegment
		scopeText: aNewStart
		end: aNewEnd.
		
	((aTargetSegment ~= aFromSegment) or: [ aFromSegment ~= aToSegment ])
		ifTrue: [
			| removeSegmentStart removeSegmentEnd |
			
			removeSegmentStart := (aTargetSegment ~= aFromSegment)
				ifTrue: [ aFromSegment index ]
				ifFalse: [ (aFromSegment index + 1) min: aToSegment index ].
			removeSegmentEnd := aToSegment index.

			aBrTextEditor segmentCollector removeSegmentInterval: (removeSegmentStart to: removeSegmentEnd) ].
	
	aTargetSegment moveTextPiecesBy: removedLength negated at: aFromIndex.
	aBrTextEditor segmentCollector
		moveTextBy: removedLength negated
		after: aTargetSegment.
		
	^ aTargetSegment
]

{ #category : #'text - modifications' }
BrTextEditorLineSegmentBuilder >> deletedFrom: aFromIndex to: aToIndex in: aBrTextEditor [
	| aFromSegment aToSegment aTargetSegment |
	self
		assert: [ aFromIndex <= aToIndex ]
		description: [ '`From` index must be less or equal to `to` index' ].

	aBrTextEditor segmentCollector
		findCachedSegmentForLetterAt: aFromIndex
		ifFound: [ :aSegment | aFromSegment := aSegment ]
		ifNotFound: [  ].

	aBrTextEditor segmentCollector
		findCachedSegmentForLetterAt: aToIndex
		ifFound: [ :aSegment | aToSegment := aSegment ]
		ifNotFound: [  ].

	(aFromSegment isNil or: [ aToSegment isNil ])
		ifTrue: [ ^ self resetSegmentCacheAndNotify: aBrTextEditor ].

	aTargetSegment := self
			deleteFrom: aFromIndex
			segment: aFromSegment
			to: aToIndex
			segment: aToSegment
			in: aBrTextEditor.

	aBrTextEditor updater
		from: aTargetSegment textStart to: aTargetSegment textEnd;
		update
]

{ #category : #initialization }
BrTextEditorLineSegmentBuilder >> initialize [
	super initialize.
	lineSplitter := self defaultSplitter.
	wordStencilBuilder := BrTextEditableWordPieceStencilBuilder new
]

{ #category : #'text - modifications' }
BrTextEditorLineSegmentBuilder >> insertedString: aString at: aTextIndex in: aBrTextEditor [
	"I am doing a hard work updating editor's segment cache due to inserted string.
	Note: This is an *algorithm* that should be very performant, that is why we don't see
	a point in doing it in OOP style, procedural way fits quite well"

	| aCurrentSegment aStream theNewSegments |
	self
		assert: [ aBrTextEditor text isNotEmpty ]
		description: [ 'Text can not be empty here' ].
	self assert: [ aString isNotEmpty ] description: [ 'String must not be empty' ].
	
	aStream := BrEditorSegmentStream new limit: Float infinity.
	self
		split: (aBrTextEditor text from: aTextIndex + 1 to: aTextIndex + aString size)
		in: aStream
		offset: aTextIndex.

	aBrTextEditor segmentCollector
		findCachedSegmentForLetterAt: aTextIndex
		ifFound: [ :aSegment | aCurrentSegment := aSegment ]
		ifNotFound: [ ^ self ].

	theNewSegments := aCurrentSegment insert: aStream segments.
	theNewSegments size > 1
		ifTrue: [ aBrTextEditor segmentCollector
				addSegments: theNewSegments allButFirst
				after: aCurrentSegment ].

	aCurrentSegment moveTextPiecesBy: aString size at: aTextIndex.
	aBrTextEditor segmentCollector
		moveTextBy: aString size
		after: theNewSegments last.

	aBrTextEditor updater
		from: aCurrentSegment textStart to: aCurrentSegment textEnd;
		update
]

{ #category : #'text - modifications' }
BrTextEditorLineSegmentBuilder >> requiresResplittingFrom: attributedSubText to: anAffectedText [
	| oldSegmentCount newSegmentCount |
	oldSegmentCount := self splitSegmentCountOf: anAffectedText.
	newSegmentCount := self splitSegmentCountOf: attributedSubText.
	^ oldSegmentCount ~= newSegmentCount
]

{ #category : #'text - modifications' }
BrTextEditorLineSegmentBuilder >> resetSegmentCacheAndNotify: aBrTextEditor [
	BrTextEditorResetCacheSignal new
		textEditor: aBrTextEditor;
		emit.

	aBrTextEditor segmentCollector resetCache.
	aBrTextEditor notifyChanged
]

{ #category : #'private - deletion' }
BrTextEditorLineSegmentBuilder >> shouldMergeDeletingFrom: aFromIndex segment: aFromSegment in: aBrTextEditor [
	"Return true if we should merge a given segment with the previous if we delete a piece of
	text in a given editor starting from a provided index, false otherwise"
	<return: #Boolean>
	| aPreviousSegment |

	"A given segment is already the first one, there is no previous to merge with"
	aFromSegment index = 1
		ifTrue: [ ^ false ].

	"when from index is less then segment start index it means we delete a line break symbol and therefore must merge"	
	(aFromIndex < aFromSegment textStart)
		ifTrue: [ ^ true ].

	aPreviousSegment := aBrTextEditor segmentCollector segmentAt: (aFromSegment index - 1).
	
	"if the difference between the end of the previous segment and the start of
	our deletion interval is 1 it means that we are trying to delete a line break symbol
	which is preceded by another line break"
	^ (aFromIndex - aPreviousSegment textEnd) = 1
]

{ #category : #splitting }
BrTextEditorLineSegmentBuilder >> split: aBrText in: aStream [
	self splitter split: aBrText in: aStream
]

{ #category : #splitting }
BrTextEditorLineSegmentBuilder >> split: aBrText in: aBrEditorSegmentStream offset: anOffset [
	self splitter split: aBrText in: aBrEditorSegmentStream offset: anOffset
]

{ #category : #'text - modifications' }
BrTextEditorLineSegmentBuilder >> splitSegmentCountOf: attributedSubText [
	^ (self splitSegmentsOf: attributedSubText) size
]

{ #category : #'text - modifications' }
BrTextEditorLineSegmentBuilder >> splitSegmentsOf: attributedSubText [
	| aStream |
	aStream := BrEditorSegmentStream new.
	aStream limit: Float infinity.

	self split: attributedSubText in: aStream.
	^ aStream segments
]

{ #category : #accessing }
BrTextEditorLineSegmentBuilder >> splitter [
	<return: #BrTextEditorSplitter>

	^ lineSplitter
]

{ #category : #accessing }
BrTextEditorLineSegmentBuilder >> splitter: aBrTextEditorSplitter [
	self
		assert: [ aBrTextEditorSplitter isNotNil ]
		description: [ 'Splitter must not be nil' ].

	lineSplitter := aBrTextEditorSplitter
]

{ #category : #'api - accessing' }
BrTextEditorLineSegmentBuilder >> wordStencil: aWordStencilBuilder [
	wordStencilBuilder := aWordStencilBuilder asStencilBuilder: BrTextEditableWordPieceStencilBuilder
]

{ #category : #accessing }
BrTextEditorLineSegmentBuilder >> wordStencilBuilder [
	<return: #BrTextEditableWordPieceStencilBuilder>

	^ wordStencilBuilder
]
