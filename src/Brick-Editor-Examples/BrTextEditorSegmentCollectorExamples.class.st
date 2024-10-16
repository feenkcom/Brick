Class {
	#name : #BrTextEditorSegmentCollectorExamples,
	#superclass : #Object,
	#instVars : [
		'largeFile'
	],
	#category : #'Brick-Editor-Examples'
}

{ #category : #examples }
BrTextEditorSegmentCollectorExamples >> cachedSegmentAt142 [
	"Retrieve the segment at 1.42 times the cache limit.
	This tests accessing the cache outside its initial contents.
	Assumptions:
	- The test file size has at least twice the number of lines in the cache"

	<gtExample>
	| segmentCollector segment limit |
	segmentCollector := self segmentCollector.
	limit := (segmentCollector cacheLimit * 1.42) rounded.
	segment := segmentCollector segmentAt: limit.
	^ segmentCollector
		findCachedSegmentForLetterAt: (limit - 1) * 100	"each line is 100 characters"
		ifFound: [ :seg | self assert: seg = segment ]
		ifNotFound: [ self error: 'Segment not found' ]
]

{ #category : #accessing }
BrTextEditorSegmentCollectorExamples >> largeFile [
	<gtExample>
	^ largeFile
		ifNil: [ largeFile := FileSystem memory / 'BlRopeableCollectionFileExamples'.
			largeFile
				writeStreamDo: [ :stream | 
					1
						to: 10000
						do: [ :l | 
							1 to: 9 do: [ :i | stream << ((l - 1) * 10 + i - 1 printPaddedWith: $0 to: 10) ].
							stream
								<< 'abcdefghi';
								lf ] ].
			largeFile ]
]

{ #category : #accessing }
BrTextEditorSegmentCollectorExamples >> largeFileRope [

	^ BlRunRopedText file: self largeFile
		"self largeFile contents asRopedText"
]

{ #category : #examples }
BrTextEditorSegmentCollectorExamples >> segmentAt142 [
	"Retrieve the segment at 1.42 times the cache limit.
	This tests accessing the cache outside its initial contents.
	Assumptions:
	- The test file size has at least twice the number of lines in the cache"
	<gtExample>
	| segmentCollector limit expected actual |

	segmentCollector := self segmentCollector.
	limit := (segmentCollector cacheLimit * 1.42) rounded.
	expected := ((limit - 1) * 10) printPaddedWith: $0 to: 10.
	actual := (segmentCollector segmentAt: limit) asString copyFrom: 1 to: 10.
	self assert: actual equals: expected.
]

{ #category : #examples }
BrTextEditorSegmentCollectorExamples >> segmentAt200and262 [
	"Retrieve the segment at line 200, followed by the segment at line 262.
	This tests re-using part of the previously cached items where the index of the segments collection is not the same as the line number"
	<gtExample>
	| segmentCollector expected actual limit |

	segmentCollector := self segmentCollector.

	limit := (segmentCollector cacheLimit * 2) rounded.
	expected := ((limit - 1) * 10) printPaddedWith: $0 to: 10.
	actual := (segmentCollector segmentAt: limit) asString copyFrom: 1 to: 10.
	self assert: actual equals: expected.

	limit := (segmentCollector cacheLimit * 2.62) rounded.
	expected := ((limit - 1) * 10) printPaddedWith: $0 to: 10.
	actual := (segmentCollector segmentAt: limit) asString copyFrom: 1 to: 10.
	self assert: actual equals: expected.

]

{ #category : #examples }
BrTextEditorSegmentCollectorExamples >> segmentAt242and42 [
	"Retrieve the segment at line 2.42 times the cache limit, followed by the segment at line 42.
	This tests #computeBackwardAt:."
	<gtExample>
	| expected actual segmentCollector limit |

	segmentCollector := self segmentCollector.

	"Retrieve several segments leading up to 2.42 times to populate the map entries"
	expected := '0000000410'.
	actual := (segmentCollector segmentAt: 42) asString copyFrom: 1 to: 10.
	self assert: actual equals: expected.

	limit := (segmentCollector cacheLimit * 1.42) rounded.
	expected := ((limit - 1) * 10) printPaddedWith: $0 to: 10.
	actual := (segmentCollector segmentAt: limit) asString copyFrom: 1 to: 10.
	self assert: actual equals: expected.

	limit := (segmentCollector cacheLimit * 2.42) rounded.
	expected := ((limit - 1) * 10) printPaddedWith: $0 to: 10.
	actual := (segmentCollector segmentAt: limit) asString copyFrom: 1 to: 10.
	self assert: actual equals: expected.

	limit := (segmentCollector cacheLimit * 0.42) rounded.
	expected := ((limit - 1) * 10) printPaddedWith: $0 to: 10.
	actual := (segmentCollector segmentAt: limit) asString copyFrom: 1 to: 10.
	self assert: actual equals: expected.

]

{ #category : #examples }
BrTextEditorSegmentCollectorExamples >> segmentAt42 [
	"Retrieve the segment at line 42.
	Assumes the cache limit is always greater than 42."
	<gtExample>
	| expected actual |

	expected := '0000000410'.
	actual := (self segmentCollector segmentAt: 42) asString copyFrom: 1 to: 10.
	self assert: actual equals: expected.
]

{ #category : #examples }
BrTextEditorSegmentCollectorExamples >> segmentAt80and120 [
	"Retrieve the segment at 0.8 times the cache limit, followed by the segment at 1.2 times the cache limit.
	This tests re-using part of the previously cached items"
	<gtExample>
	| segmentCollector expected actual limit |

	segmentCollector := self segmentCollector.

	limit := (segmentCollector cacheLimit * 0.8) rounded.
	expected := (limit - 1 * 10) printPaddedWith: $0 to: 10.
	actual := (segmentCollector segmentAt: limit) asString copyFrom: 1 to: 10.
	self assert: actual equals: expected.

	limit := (segmentCollector cacheLimit * 1.2) rounded.
	expected := (limit - 1 * 10) printPaddedWith: $0 to: 10.
	actual := (segmentCollector segmentAt: limit) asString copyFrom: 1 to: 10.
	self assert: actual equals: expected.

]

{ #category : #accessing }
BrTextEditorSegmentCollectorExamples >> segmentCollector [

	^ self textEditor segmentCollector
]

{ #category : #accessing }
BrTextEditorSegmentCollectorExamples >> textEditor [ 
	| aTextEditor |

	aTextEditor := BrTextEditorModel new text: self largeFileRope.
	aTextEditor segmentCollector cacheLimit: 500.
		
	^ aTextEditor
]
