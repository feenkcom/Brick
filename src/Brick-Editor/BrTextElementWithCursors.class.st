"
I am extended version of the {{gtClass:BlTextElement}} with support of multiple cursors.

"
Class {
	#name : #BrTextElementWithCursors,
	#superclass : #BlTextElement,
	#instVars : [
		'cursorElements',
		'cursorStencil',
		'segmentPiece'
	],
	#category : #'Brick-Editor-UI'
}

{ #category : #'cursor - management' }
BrTextElementWithCursors >> addCursorAt: aTextPosition [
	<return: #BrCursorElement>
	
	^ self
		cursorAt: aTextPosition
		ifFound: #yourself
		ifNone: [
			| aCursorElement |
			aCursorElement := self newCursor.
			aCursorElement textPosition: aTextPosition.
			cursorElements add: aCursorElement.
			self addChild: aCursorElement.
			aCursorElement ]
]

{ #category : #asserting }
BrTextElementWithCursors >> assertCursor: aCursorElement [
	self assertCursorPosition: aCursorElement textPosition
]

{ #category : #asserting }
BrTextElementWithCursors >> assertCursorPosition: anIndex [
	self
		assert: [ self text isNotEmpty or: [ anIndex isZero ] ]
		description: [ 'Cursor position can only be zero if text is empty' ].
	self
		assert: [ anIndex between: 0 and: self text size ]
		description: [ 'Cursor must be within text bounds (0 is allowed)' ].
]

{ #category : #private }
BrTextElementWithCursors >> cursorAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [

	^ cursorElements
		detect: [ :aCursor | aCursor textPosition = aTextPosition ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
BrTextElementWithCursors >> cursorElements [
	<return: #Collection of: #BrCursorElement>

	^ cursorElements
]

{ #category : #accessing }
BrTextElementWithCursors >> cursorStencil [
	^ cursorStencil
]

{ #category : #'geometry bounds' }
BrTextElementWithCursors >> focusedBounds: aBlBounds [
	"My focused bounds should be focused bounds of a cursor if it exists or my own otherwise"
	<return: #BlBounds>

	^ super focusedBounds: aBlBounds

	"^ (self cursorExists and: [ self hasFocus ])
		ifFalse: [ super focusedBounds: aBlBounds ]
		ifTrue: [ self cursorElement localBoundsToParent: (self cursorElement focusedBounds: aBlBounds) ]"
]

{ #category : #testing }
BrTextElementWithCursors >> hasCursorAt: aTextPosition [
	"Return true if cursor at a given position exists"
	<return: #Boolean>
		
	^ self
		cursorAt: aTextPosition
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #'cursor - management' }
BrTextElementWithCursors >> hideCursors [
	self cursorElements do: [ :aCursorElement | aCursorElement visibility: BlVisibility gone ]
]

{ #category : #initialization }
BrTextElementWithCursors >> initialize [
	super initialize.

	cursorElements := OrderedCollection new.
	cursorStencil := BrCursorStencil uniqueInstance
]

{ #category : #layout }
BrTextElementWithCursors >> layoutCursors: aBounds context: aBlElementBoundsUpdateContext [
	cursorElements do: [ :aCursorElement |
		| aCursorPosition aTextPositionX aMaxTextPositionX aMinTextPositionX aTextPosition |
		
		"we make sure that the cursor is within text bounds (we allow to add a cursor outside of the text bounds)"
		aCursorPosition := aCursorElement textPosition min: self text size max: 0.0.
		
		aMaxTextPositionX := ((self measuredWidth - (aCursorElement measuredWidth))) max: 0.0.
		aMinTextPositionX := 0.0.
		
		aTextPositionX := (self screenPositionAt: aCursorPosition) x.
		aTextPositionX := ((aTextPositionX - (aCursorElement measuredWidth // 2)) min: aMaxTextPositionX) max: aMinTextPositionX.
		aTextPosition := aTextPositionX @ self padding top.
		
		aCursorElement
			applyLayoutIn: (aTextPosition extent: (aCursorElement measuredWidth @ ((aCursorElement measuredHeight - self padding height) max: 0.0)))
			context: aBlElementBoundsUpdateContext ]
]

{ #category : #initialization }
BrTextElementWithCursors >> newCursor [
	"Create and return a new instance of a cursor element"
	<return: #BlElement>

	^ self cursorStencil asElement
		constraintsDo: [ :c | c ignoreByLayout ]
]

{ #category : #layout }
BrTextElementWithCursors >> onLayout: aBounds context: aBlElementBoundsUpdateContext [
	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	
	self layoutCursors: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #printing }
BrTextElementWithCursors >> printOn: aStream [
	segmentPiece
		ifNil: [ ^ aStream nextPutAll: 'Uknown segment' ].
	
	aStream
		nextPut: $(;
		nextPutAll: segmentPiece textStart asString;
		nextPutAll: ' - ';
		nextPutAll: segmentPiece textEnd asString;
		nextPut: $);
		print: segmentPiece text
]

{ #category : #'cursor - management' }
BrTextElementWithCursors >> removeCursorAt: aTextIndex [
	"Remove cursor at a goven position"

	^ self
		cursorAt: aTextIndex
		ifFound: [ :aCursorElement |
			cursorElements remove: aCursorElement.
			aCursorElement removeFromParent.
			aCursorElement ]
		ifNone: [ self error: 'Cursor at ', aTextIndex asString, ' does not exist' ]
]

{ #category : #'cursor - management' }
BrTextElementWithCursors >> removeCursors [
	"Remove all cursors"

	self cursorElements reverseDo: [ :eachCursorElement | eachCursorElement removeFromParent ].
	self cursorElements removeAll
]

{ #category : #accessing }
BrTextElementWithCursors >> removeSegmentPiece [
	segmentPiece := nil.	
	self text: '' asRopedText
]

{ #category : #accessing }
BrTextElementWithCursors >> segmentPiece [
	<return: #TBrTextEditorTextualPiece>

	^ segmentPiece
]

{ #category : #accessing }
BrTextElementWithCursors >> segmentPiece: aSegmentPiece [
	| isTextSame |
	segmentPiece := aSegmentPiece.
	
	BlFrameTelemetry
		timeSync: [ 'Compare text `{1}` with `{2}`' format: { self text . aSegmentPiece text } ]
		during: [ isTextSame := self text equals: aSegmentPiece text ].

	isTextSame
		ifFalse: [
			| aTextCopy |
			
			BlFrameTelemetry
				timeSync: [ 'Copy text `{1}`' format: { aSegmentPiece text } ]
				during: [ aTextCopy := aSegmentPiece text copyFrom: 1 to: aSegmentPiece text size ].

			BlFrameTelemetry
				timeSync: [ 'Set text `{1}`' format: { aTextCopy } ]
				during: [ self text: aTextCopy ] ]
]

{ #category : #'cursor - management' }
BrTextElementWithCursors >> showCursors [
	self cursorElements do: [ :aCursorElement | aCursorElement visibility: BlVisibility visible ]
]

{ #category : #'text - accessing' }
BrTextElementWithCursors >> textEnd [
	"Return an index of the last character of a subtext that I represent"
	<return: #Number>
	
	^ segmentPiece textEnd
]

{ #category : #'text - accessing' }
BrTextElementWithCursors >> textStart [
	"Return an index of the first character of a subtext that I represent"
	<return: #Number>
	
	^ segmentPiece textStart
]
