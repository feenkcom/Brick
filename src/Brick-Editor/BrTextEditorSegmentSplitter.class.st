Class {
	#name : #BrTextEditorSegmentSplitter,
	#superclass : #BrTextEditorAbstractSegmentSplitter,
	#instVars : [
		'stream',
		'start',
		'text'
	],
	#category : #'Brick-Editor-Model - Segment'
}

{ #category : #accessing }
BrTextEditorSegmentSplitter >> interestingAttributesIn: attrs [
	^ attrs select: [ :each | each isAdornment or: [ each isEventHandler ] ]
]

{ #category : #accessing }
BrTextEditorSegmentSplitter >> outputAdornment: anAdornment from: from to: to virtual: aBoolean [
	((to = 0 or: [ text isEmpty ]) and: [ anAdornment shouldReplace ])
		ifTrue: [ ^ self ].
	stream
		nextPut: (BrTextEditorLineSegmentAdornmentPiece new
				initializeWith: (text from: (from max: 1) to: (to min: text size))
					from: (from max: 1) - 1 + start
					to: (to min: text size) + start
					delimiter: 0;
				adornmentAttribute: anAdornment;
				virtual: aBoolean;
				yourself)
]

{ #category : #accessing }
BrTextEditorSegmentSplitter >> outputTextFrom: from to: to [
	(from > to or: [ text isEmpty ]) ifTrue: [ ^ self ].
	stream
		nextPut: (BrTextEditorSegmentTextPiece new
				initializeWith: (text from: from to: to)
				from: from - 1 + start
				to: to + start
				delimiter: 0)
]

{ #category : #accessing }
BrTextEditorSegmentSplitter >> processText: aText [
	| current next |
	text := aText.
	current := BrTextEditorSegmentSplitterObject new
			interestingAttributes: (self interestingAttributesIn: (aText attributesAt: 0));
			intervalFirst: 0;
			intervalLast: 0;
			splitter: self;
			start: 1.
	aText
		attributeRunsDo: [ :first :last :attrs | 
			| interestingAttributes endingAttributes startingAttributes |
			interestingAttributes := self interestingAttributesIn: attrs.
			next := BrTextEditorSegmentSplitterObject new
					interestingAttributes: interestingAttributes;
					intervalFirst: first;
					intervalLast: last;
					splitter: self.
			endingAttributes := current interestingAttributes
					reject: [ :each | next interestingAttributes includes: each ].
			startingAttributes := next interestingAttributes
					reject: [ :each | current interestingAttributes includes: each ].
			(endingAttributes isEmpty and: [ startingAttributes isEmpty ])
				ifTrue: [ current intervalLast: last ]
				ifFalse: [ current endIntervalWith: endingAttributes.
					next start: current start.
					next startIntervalWith: startingAttributes.
					current := next ] ].
	current finished
]

{ #category : #accessing }
BrTextEditorSegmentSplitter >> split: aText from: aStartIndex to: anEndIndex [
	^ (Array
		streamContents: [ :aStream | 
			stream := aStream.
			start := aStartIndex.
			self processText: aText ])
		ifEmpty: [ {BrTextEditorSegmentTextPiece new
					initializeWith: (aText from: 1 to: 0)
					from: aStartIndex
					to: anEndIndex
					delimiter: 0} ]
]
