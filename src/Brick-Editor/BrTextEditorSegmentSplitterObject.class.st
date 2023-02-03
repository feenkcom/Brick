Class {
	#name : #BrTextEditorSegmentSplitterObject,
	#superclass : #Object,
	#instVars : [
		'interestingAttributes',
		'start',
		'intervalFirst',
		'intervalLast',
		'splitter'
	],
	#category : #'Brick-Editor-Model - Segment'
}

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> endIntervalWith: endingAttributes [
	(endingAttributes
		allSatisfy: [ :each | each isAdornment and: [ each shouldOverlay ] ])
		ifTrue: [ ^ self ].
	self hasReplacement ifFalse: [ self outputTextTo: intervalLast ].
	endingAttributes
		do: [ :each | 
			(each isAdornment and: [ each shouldReplace or: [ each shouldAppend ] ])
				ifTrue: [ self
						outputAdornment: each
						from: (intervalFirst min: start)
						to: intervalLast ] ].
	start := intervalLast + 1
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> finished [
	self hasReplacement ifFalse: [ self outputTextTo: intervalLast ].
	self endIntervalWith: self interestingAttributes
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> hasReplacement [
	^ interestingAttributes
		anySatisfy: [ :each | each isAdornment and: [ each shouldReplace ] ]
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> interestingAttributes [
	^ interestingAttributes
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> interestingAttributes: anArray [
	interestingAttributes := anArray
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> intervalFirst [
	^ intervalFirst
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> intervalFirst: anInteger [
	intervalFirst := anInteger
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> intervalLast [
	^ intervalLast
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> intervalLast: anInteger [
	intervalLast := anInteger
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> outputAdornment: anAdornment from: from to: to [
	splitter
		outputAdornment: anAdornment
		from: from
		to: to
		virtual: anAdornment shouldReplace not
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> outputTextTo: last [
	splitter outputTextFrom: start to: last.
	start := last + 1
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> splitter [
	^ splitter
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> splitter: aSplitter [
	splitter := aSplitter
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> start [
	^ start
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> start: anInteger [
	start := anInteger
]

{ #category : #accessing }
BrTextEditorSegmentSplitterObject >> startIntervalWith: startingAttributes [
	| startingAttributesThatNeedSplit |
	startingAttributesThatNeedSplit := startingAttributes
			select: [ :each | 
				each isEventHandler
					or: [ each isAdornment and: [ each shouldOverlay or: [ each shouldReplace ] ] ] ].
	startingAttributesThatNeedSplit notEmpty ifFalse: [ ^ self ].
	((startingAttributesThatNeedSplit allSatisfy: [ :each | each isEventHandler ])
		and: [ interestingAttributes
				anySatisfy: [ :each | each isAdornment and: [ each shouldReplace ] ] ])
		ifTrue: [ ^ self ].
	self outputTextTo: intervalFirst - 1.
	startingAttributes
		do: [ :each | 
			(each isAdornment and: [ each shouldOverlay ])
				ifTrue: [ self
						outputAdornment: each
						from: intervalFirst
						to: intervalLast ] ]
]
