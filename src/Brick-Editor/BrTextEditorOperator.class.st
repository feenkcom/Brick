Class {
	#name : #BrTextEditorOperator,
	#superclass : #Object,
	#instVars : [
		'editor',
		'subscriptions',
		'context'
	],
	#category : #'Brick-Editor-Model - Operators'
}

{ #category : #'private - asserting' }
BrTextEditorOperator >> assertUIProcess [
	self editor assertUIProcess
]

{ #category : #'api - word movement' }
BrTextEditorOperator >> camelCaseClassifier [
	"Returns true if a word boundary occurs between c1 and c2"
	^ [ :c1 :c2 | 
	c1 isSeparator ~= c2 isSeparator
		or: [ (c1 isAlphaNumeric | (c1 = $_)) ~= (c2 isAlphaNumeric | (c2 = $_))
				or: [ c1 isUppercase not and: [ c2 isUppercase ] ] ] ]
]

{ #category : #private }
BrTextEditorOperator >> characterType: aCharacter [
	<return: #Symbol>

	(self isWordChar: aCharacter)
		ifTrue: [ ^ #word ].

	aCharacter isSeparator
		ifTrue: [ ^ #separator ].

	^ #other
]

{ #category : #accessing }
BrTextEditorOperator >> context [
	^ context
]

{ #category : #accessing }
BrTextEditorOperator >> context: anObject [
	"An object that understands #telemetry message"
	context := anObject
]

{ #category : #accessing }
BrTextEditorOperator >> cursor [
	^ self cursors
]

{ #category : #accessing }
BrTextEditorOperator >> cursors [
	^ self editor cursors
]

{ #category : #private }
BrTextEditorOperator >> delimiters [
	^{
		$' -> $' .
		$" -> $" . 
		$( -> $) .
		$[ -> $] .
		${ -> $} } asDictionary
]

{ #category : #accessing }
BrTextEditorOperator >> editor [
	^ editor
]

{ #category : #accessing }
BrTextEditorOperator >> editor: aBrTextEditor [
	editor := aBrTextEditor
]

{ #category : #private }
BrTextEditorOperator >> findDelimitedUnitAt: aTextIndex [
	<return: #Interval>
	| aTextIterator aUnitStart delims emptyInterval endingDelimiter startingDelimiter level |
	emptyInterval := 0 to: -1.
	aTextIterator := self text iterator skip: aTextIndex.
	aTextIterator hasPrevious ifFalse: [ ^ emptyInterval ].
	delims := self delimiters.
	level := 0.

	endingDelimiter := delims at: aTextIterator peer ifAbsent: [ ^ self reverseFindDelimitedUnitAt: aTextIndex ].
	startingDelimiter := aTextIterator peer.

	aUnitStart := aTextIndex.

	[ aTextIterator hasNext ]
		whileTrue: [ | ch |
			ch := aTextIterator next.
			(startingDelimiter isOpenPunctuation and: [ ch = startingDelimiter ])
				ifTrue: [ level := level + 1 ].
			ch = endingDelimiter
				ifTrue: [ level = 0
						ifTrue: [ ^ aUnitStart to: aTextIterator position - 1 ]
						ifFalse: [ level := level - 1 ] ] ].
	^ emptyInterval
]

{ #category : #'api - folding' }
BrTextEditorOperator >> findFoldEndAfter: aTextIndex [
	| aText aTextIterator foundFold |
	aText := self text.
	aTextIterator := aText iterator: aTextIndex to: aText size.

	foundFold := false.
	[ aTextIterator hasNext
		and: [ aTextIterator next.
			foundFold := aTextIterator attributes
					anySatisfy: [ :att | att isAdornment and: [ att shouldFold ] ] ] ]
		whileTrue.

	^ aTextIterator position - foundFold asBit
]

{ #category : #'api - folding' }
BrTextEditorOperator >> findFoldStartBefore: aTextIndex [
	| aText aTextIterator foundFold |
	aText := self text.

	aTextIterator := aText iterator: (1 min: aText size) to: aTextIndex.
	aTextIterator skip: (aTextIndex - 1 max: 0).

	foundFold := false.
	[ aTextIterator hasPrevious
		and: [ aTextIterator previous.
			foundFold := aTextIterator attributes
					anySatisfy: [ :att | att isAdornment and: [ att shouldFold ] ] ] ]
		whileTrue.

	^ aTextIterator position + 1
]

{ #category : #private }
BrTextEditorOperator >> findLineEndAfter: aTextIndex [
	<return: #Number>
	| aText aTextIterator foundLineBreak |

	aText := self text.
	aTextIterator := aText iterator: aTextIndex to: aText size.

	"if we have a line break after cursor - do nothing"
	(aTextIterator hasNext and: [ aTextIterator peek isLineBreak ])
		ifTrue: [ ^ aTextIndex ].

	foundLineBreak := false.
	[ aTextIterator hasNext and: [ (foundLineBreak := aTextIterator next isLineBreak) not ] ] whileTrue.

	^ aTextIterator position - foundLineBreak asBit
]

{ #category : #private }
BrTextEditorOperator >> findLineStartBefore: aTextIndex [
	"Please note, I return 0 for the first line"
	<return: #Number>
	| aText aTextIterator foundLineBreak |

	aText := self text.
	
	self
		assert: [ aTextIndex <= aText size ]
		description: [ 'Text index must not exceed text size' ].

	aTextIterator := aText iterator: (1 min: aText size) to: aTextIndex.
	aTextIterator skip: ((aTextIndex - 1) max: 0).

	"if we have a line break before aTextIndex"
	(aTextIterator hasPrevious and: [ aTextIterator peer isLineBreak ])
		ifTrue: [ ^ aTextIndex - 1 ].

	foundLineBreak := false.
	[ aTextIterator hasPrevious and: [ (foundLineBreak := aTextIterator previous isLineBreak) not ] ] whileTrue.

	^ aTextIterator position + foundLineBreak asBit
]

{ #category : #private }
BrTextEditorOperator >> findLineStartsBetween: aTextStart and: aTextEnd [
	<return: #Number>
	| aText aTextIterator |

	aText := self text.
	aTextIterator := aText iterator: aTextStart to: aTextEnd.
	
	^ Array streamContents: [ :aStream |
		[ aTextIterator hasNext ] whileTrue: [
			aTextIterator next isLineBreak
				ifTrue: [ aStream nextPut: aTextIterator position ] ] ]
]

{ #category : #'api - utility' }
BrTextEditorOperator >> findTextIndexAboveCursor: aCursor ifAbsent: anExceptionBlock [
	"Find a text index one line above the given cursor"
	<return: #Number>
	| aTransformation aGlobalTextIndex |
	
	aGlobalTextIndex := nil.

	aTransformation := BrTextEditorRelativeScreenToCursorTransformation new
		cursor: aCursor;
		beUp;
		whenTransformed: [ :aTextIndex | aGlobalTextIndex := aTextIndex ].

	self editor enqueueCommand: (BrTextEditorScreenToCursorCommand new transformation: aTransformation).
	
	^ aGlobalTextIndex
		ifNotNil: [ aGlobalTextIndex ]
		ifNil: anExceptionBlock
]

{ #category : #'api - utility' }
BrTextEditorOperator >> findTextIndexAtLineEnd: aCursor [
	"Find a text index at the end of the line where the cursor is located"
	<return: #Number>
	| aText aTextIterator foundLineBreak |
	
	aText := self text.
	aTextIterator := aText iterator: aCursor position + 1 to: aText size.

	"if we have a line break after cursor - do nothing"
	(aTextIterator hasNext and: [ aTextIterator peek isLineBreak ])
		ifTrue: [ ^ aCursor position ].

	foundLineBreak := false.
	[ aTextIterator hasNext and: [ (foundLineBreak := aTextIterator next isLineBreak) not ] ] whileTrue.

	^ aTextIterator position - foundLineBreak asBit
]

{ #category : #'api - utility' }
BrTextEditorOperator >> findTextIndexAtLineStart: aCursor [
	"Find a text index at the start of the line where the cursor is located"
	<return: #Number>
	| aText aTextIterator foundLineBreak |
	
	aText := self text.
	aTextIterator := aText iterator: 1 to: aCursor position.
	aTextIterator skip: aCursor position.

	"if we have a line break before cursor - do nothing"
	(aTextIterator hasPrevious
		and: [ (aTextIterator previous; hasPrevious)
			and: [ aTextIterator peek isLineBreak ] ])
		ifTrue: [ ^ aCursor position ].

	foundLineBreak := false.
	[ aTextIterator hasPrevious and: [ (foundLineBreak := aTextIterator previous isLineBreak) not ] ] whileTrue.

	^ aTextIterator position + foundLineBreak asBit
]

{ #category : #'api - utility' }
BrTextEditorOperator >> findTextIndexAtScreenPosition: aScreenPosition [
	"Convert screen position to a text index"
	<return: #Number>
	| aTransformation aGlobalTextIndex |
	
	aGlobalTextIndex := nil.

	aTransformation := BrTextEditorExplicitScreenToCursorTransformation new screenPosition: aScreenPosition.
	aTransformation whenTransformed: [ :aTextIndex | aGlobalTextIndex := aTextIndex ].
	
	self editor enqueueCommand: (BrTextEditorScreenToCursorCommand new transformation: aTransformation).
	
	"could not find a text index for a given screen position"
	self
		assert: [ aGlobalTextIndex isNotNil ]
		description: [ 'There must always be some text index found' ].
		
	^ aGlobalTextIndex
]

{ #category : #'api - utility' }
BrTextEditorOperator >> findTextIndexAtScreenPosition: aScreenPosition ifAbsent: anExceptionBlock [
	"Convert screen position to a text index"
	<return: #Number>
	| aTransformation aGlobalTextIndex |
	
	aGlobalTextIndex := nil.

	aTransformation := BrTextEditorExplicitScreenToCursorTransformation new screenPosition: aScreenPosition.
	aTransformation whenTransformed: [ :aTextIndex | aGlobalTextIndex := aTextIndex ].
	
	self editor enqueueCommand: (BrTextEditorScreenToCursorCommand new transformation: aTransformation).
	
	aGlobalTextIndex
		ifNotNil: [ ^ aGlobalTextIndex ]
		ifNil: [ self flag: 'Until I figure out why it can be nil'. ^ anExceptionBlock value ].
	
	"could not find a text index for a given screen position"
	self
		assert: [ aGlobalTextIndex isNotNil ]
		description: [ 'There must always be some text index found' ].
		
	^ aGlobalTextIndex
]

{ #category : #'api - utility' }
BrTextEditorOperator >> findTextIndexBelowCursor: aCursor ifAbsent: anExceptionBlock [
	"Find a text index one line below the given cursor"
	<return: #Number>
	| aTransformation aGlobalTextIndex |
	
	aGlobalTextIndex := nil.

	aTransformation := BrTextEditorRelativeScreenToCursorTransformation new
		cursor: aCursor;
		beDown;
		whenTransformed: [ :aTextIndex | aGlobalTextIndex := aTextIndex ].
	
	self editor enqueueCommand: (BrTextEditorScreenToCursorCommand new transformation: aTransformation).
	
	aGlobalTextIndex
		ifNotNil: [ ^ aGlobalTextIndex ]
		ifNil: [ self flag: 'Until I figure out why it can be nil'. ^ anExceptionBlock value ].
	
	"could not find a text index for a given screen position"
	self
		assert: [ aGlobalTextIndex isNotNil ]
		description: [ 'There must always be some text index found' ].
		
	^ aGlobalTextIndex
]

{ #category : #private }
BrTextEditorOperator >> findWhitespaceOfLineBefore: aTextIndex [
	| aLineStartIndex aText aTextIterator isFound |
	<return: #String>

	aText := self text.
	aLineStartIndex := (self findLineStartBefore: aTextIndex) + aText size isZero not asBit.

	aTextIterator := aText iterator: aLineStartIndex to: aTextIndex.

	isFound := false.
	[ aTextIterator hasNext and: [
		aTextIterator peek = Character space
			or: [ aTextIterator peek = Character tab ] ] ]
				whileTrue: [ isFound := true. aTextIterator next ].

	isFound
		ifFalse: [ ^ '' ].

	^ (aText from: (aLineStartIndex min: aTextIterator position) to: aTextIterator position) asString
]

{ #category : #'api - word movement' }
BrTextEditorOperator >> findWordAt: aTextIndex withClassifier: classifier [
	"Find a word text interval or a whitespace at a given text index"

	<return: #Interval>
	| aTextIterator |
	self assertUIProcess.
	aTextIterator := self text iterator skip: aTextIndex.
	aTextIterator nextWordWithClassifier: classifier.
	^ aTextIterator
		prevWordWithClassifier: classifier
		indicesDo: [ :start :end | start to: end ]
]

{ #category : #'api - word movement' }
BrTextEditorOperator >> findWordEndAfter: aTextIndex [
	"Find a text index of the end of the next word after a given text index"

	| textIterator newPosition aText | 
	newPosition := aTextIndex.
	aText := self text.
	textIterator := aText iterator: (newPosition max: 1) to: aText size.
	textIterator hasNext
		ifTrue: [ newPosition := textIterator
					nextWordWithClassifier: editor movementWordClassifier
					indicesDo: [ :st :nd | nd ] ].
	^ newPosition
]

{ #category : #'api - word movement' }
BrTextEditorOperator >> findWordStartBefore: aTextIndex [
	"Find a text index of the start of the previous word before a given text index"

	| textIterator newPosition aText |
	newPosition := aTextIndex.
	aText := self text.
	textIterator := aText iterator.
	textIterator position: newPosition.
	textIterator hasPrevious
		ifTrue: [ newPosition := textIterator
					prevWordWithClassifier: editor movementWordClassifier
					indicesDo: [ :st :nd | st ] ].
	^ newPosition
]

{ #category : #'api - configuration' }
BrTextEditorOperator >> hasFoldAfterCursor: aCursor [
	aCursor position = self text size ifTrue: [ ^ false ].
	^ (self text attributesAt: aCursor position + 1)
		anySatisfy: [ :att | att isAdornment and: [ att shouldFold ] ]
]

{ #category : #'api - configuration' }
BrTextEditorOperator >> hasFoldBeforeCursor: aCursor [
	aCursor position = 0 ifTrue: [ ^ false ].
	^ (self text attributesAt: aCursor position - 1)
		anySatisfy: [ :att | att isAdornment and: [ att shouldFold ] ]
]

{ #category : #private }
BrTextEditorOperator >> hasSpaceAroundCursor: aCursor [
	"Answer a boolean indicating whether the characters either side of the cursor are separators (or end of string)"
	| anIterator start end |
	
	self text isEmpty ifTrue: [ ^ true ].
	
	start := aCursor position max: 1.
	end := aCursor position + 1 max: start.

	anIterator := self text 
			iterator: (start min: self text size)
			to: (end min: self text size).
	2 timesRepeat:
		[ (anIterator hasNext and:
			[ anIterator next isSeparator not ]) ifTrue: [ ^false ] ].
	^ true
]

{ #category : #testing }
BrTextEditorOperator >> hasSpaceAroundIndex: anIndex [

	^ self hasSpaceAroundCursor: (BrTextEditorSingleCursor at: anIndex)
]

{ #category : #private }
BrTextEditorOperator >> hasString: aString afterCursor: aCursor [
	| anIterator |
	
	self
		assert: [ aString isNotEmpty ]
		description: [ 'String must not be empty' ].
	
	aCursor position = self text size
		ifTrue: [ ^ false ].
	
	anIterator := self text iterator: ((aCursor position + 1) min: self text size) to: self text size.
	aString do: [ :eachCharacter |
		anIterator hasNext
			ifFalse: [ ^ false ].
			
		anIterator next = eachCharacter
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #private }
BrTextEditorOperator >> hasString: aString beforeCursor: aCursor [
	| anIterator |
	
	self
		assert: [ aString isNotEmpty ]
		description: [ 'String must not be empty' ].
	
	aCursor position isZero
		ifTrue: [ ^ false ].
	
	anIterator := self text iterator: 1 to: ((aCursor position + 1) min: self text size).
	anIterator skip: aCursor position.
	aString reverseDo: [ :eachCharacter |
		anIterator hasPrevious
			ifFalse: [ ^ false ].
			
		anIterator previous = eachCharacter
			ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #initialization }
BrTextEditorOperator >> initialize [
	super initialize.

	subscriptions := OrderedCollection new
]

{ #category : #testing }
BrTextEditorOperator >> isCursorOnTheFirstLine: aCursor [
	<return: #Boolean>

	^ (self findLineStartBefore: (aCursor position max: self text isNotEmpty asBit)) isZero
]

{ #category : #testing }
BrTextEditorOperator >> isCursorOnTheLastLine: aCursor [
	<return: #Boolean>

	^ (self findLineEndAfter: (aCursor position + 1 max: self text isNotEmpty asBit)) = self text size
]

{ #category : #testing }
BrTextEditorOperator >> isDeleter [
	^ false
]

{ #category : #testing }
BrTextEditorOperator >> isInserter [
	^ false
]

{ #category : #private }
BrTextEditorOperator >> isWordChar: aCharacter [
	<return: #Number>

	^ aCharacter isAlphaNumeric
]

{ #category : #private }
BrTextEditorOperator >> reverseFindDelimitedUnitAt: aTextIndex [
	<return: #Interval>
	| aTextIterator aUnitEnd delims emptyInterval endingDelimiter startingDelimiter level |
	emptyInterval := 0 to: -1.
	aTextIterator := self text iterator skip: aTextIndex.
	aTextIterator hasNext ifFalse: [ ^ emptyInterval ].
	delims := self delimiters.
	level := 0.

	startingDelimiter := delims
			keyAtValue: aTextIterator peek
			ifAbsent: [ ^ emptyInterval ].
	endingDelimiter := aTextIterator peek.

	aUnitEnd := aTextIndex.

	[ aTextIterator hasPrevious ]
		whileTrue: [ | ch |
			ch := aTextIterator previous.
			(endingDelimiter isClosePunctuation and: [ ch = endingDelimiter ])
				ifTrue: [ level := level + 1 ].
			ch = startingDelimiter
				ifTrue: [ level = 0
						ifTrue: [ ^ aTextIterator position + 1 to: aUnitEnd ]
						ifFalse: [ level := level - 1 ] ] ].
	^ emptyInterval
]

{ #category : #accessing }
BrTextEditorOperator >> selection [
	^ self editor selection
]

{ #category : #'api - event' }
BrTextEditorOperator >> subscribe: anEventHandler [
	self editor addEventHandler: anEventHandler.
	subscriptions add: anEventHandler.
	^ anEventHandler
]

{ #category : #accessing }
BrTextEditorOperator >> telemetry [
	<return: #Telemetry>

	^ BlFrameTelemetry
]

{ #category : #accessing }
BrTextEditorOperator >> text [
	^ self editor text
]

{ #category : #'api - event' }
BrTextEditorOperator >> unsubscribe [
	subscriptions do: [ :anEventHandler | self editor removeEventHandler: anEventHandler ]
]

{ #category : #'api - event' }
BrTextEditorOperator >> when: anEventClass do: aBlock [
	^ self subscribe: (BlEventHandler on: anEventClass do: aBlock)
]
