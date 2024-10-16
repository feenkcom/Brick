Class {
	#name : #BrTextEditorSegmentCollectorExamples2,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples'
}

{ #category : #accessing }
BrTextEditorSegmentCollectorExamples2 >> cachePastEnd [
	<gtExample>
	| textModel text segmentCollector |
	text := (String
			streamContents: [ :stream | 
				1
					to: 52000
					do: [ :i | 
						i
							printOn: stream
							base: 10
							nDigits: 9.
						stream cr ] ]) asRopedText.
	textModel := BrTextEditorModel new.
	textModel text: text.
	segmentCollector := BrTextEditorSegmentCollector new.
	segmentCollector editor: textModel.
	segmentCollector text: text.
	segmentCollector computeForwardAt: 51111.
	segmentCollector computeForwardAt: 51999.
	^ segmentCollector
]

{ #category : #examples }
BrTextEditorSegmentCollectorExamples2 >> retrieveLimitPlusOne [
	<gtExample>
	| string limit editor collector |
	
	limit := 6.
	string := String streamContents: [ :stream |
		1 to: limit * 2 do: [ :i |
		 stream
		 	<< 'Line ';
		 	<< (i printPaddedWith: $0 to: 3);
		 	lf ] ].

	editor := BrTextEditorModel new.
	editor text: string asRopedText.
	collector := editor segmentCollector.
	collector cacheLimit: limit.

	self assert: (collector segmentAt: limit+1) asString
			equals: 'Line ', (limit+1 printPaddedWith: $0 to: 3).
	self assert: (collector segmentAt: 1) asString
			equals: 'Line 001'.
	self assert: (collector segmentAt: limit+1) asString
			equals: 'Line ', (limit+1 printPaddedWith: $0 to: 3).
	self assert: (collector segmentAt: limit) asString
			equals: 'Line ', (limit printPaddedWith: $0 to: 3).
			
	^ collector
]

{ #category : #examples }
BrTextEditorSegmentCollectorExamples2 >> retrieveWithinLimit [
	<gtExample>
	| string cacheLimit limit editor collector |

	cacheLimit := 6.
	
	editor := BrTextEditorModel new.

	limit := cacheLimit // 2.
	string := String streamContents: [ :stream |
		1 to: cacheLimit + 1 do: [ :i |
		 stream
		 	<< 'Line ';
		 	<< (i printPaddedWith: $0 to: 3);
		 	lf ] ].

	editor text: string asRopedText.
	collector := editor segmentCollector.
	collector cacheLimit: cacheLimit.

	self assert: (collector segmentAt: 1) asString
			equals: 'Line 001'.
	self assert: (collector segmentAt: limit) asString
			equals: 'Line ', (limit printPaddedWith: $0 to: 3).
	self assert: (collector segmentAt: limit // 2) asString
			equals: 'Line ', (limit // 2 printPaddedWith: $0 to: 3).
			
	^ collector
]
