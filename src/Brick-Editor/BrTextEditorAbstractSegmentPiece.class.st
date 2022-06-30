Class {
	#name : #BrTextEditorAbstractSegmentPiece,
	#superclass : #Object,
	#traits : 'TBrTextEditorTextualPiece',
	#classTraits : 'TBrTextEditorTextualPiece classTrait',
	#instVars : [
		'segment',
		'currentCursors'
	],
	#category : #'Brick-Editor-Model - Segment'
}

{ #category : #'instance creation' }
BrTextEditorAbstractSegmentPiece >> createAdornmentElement: anEditorElement [
	| theAdornmentElements |
	theAdornmentElements := (self adornmentAttribute
			affect: self
			in: anEditorElement) asOrderedCollection.
	theAdornmentElements
		ifEmpty: [ theAdornmentElements := OrderedCollection with: (BlElement new size: 0 @ 0) ].
	theAdornmentElements
		do: [ :eachElement | 
			eachElement mouseCursor ifNil: [ eachElement mouseCursor: BlCursor default ].
			eachElement userData at: #brickEditorAdornment put: true.
			self adornmentAttribute isFocusable
				ifFalse: [ eachElement focusability: BlFocusabilityNone new ] ].

	self
		assert: [ self isVirtual
				or: [  "only replacement attribute can be non-virtual"self isVirtual not
						and: [ self adornmentAttribute shouldReplace ] ] ]
		description: [ 'Only replacement attribute can be non-virtual' ].

	theAdornmentElements
		withIndexDo: [ :eachAdornmentElement :eachIndex | 
			| aCharLength |
			aCharLength := self isVirtual
					ifTrue: [ 0 ]
					ifFalse: [ eachIndex = theAdornmentElements size
							ifTrue: [ self textLength ]
							ifFalse: [ 0 ] ].

			eachAdornmentElement userData at: #brickEditorCharLength put: aCharLength.
			eachAdornmentElement userData at: #brickEditorTextPiece put: self ].

	^ theAdornmentElements
]

{ #category : #'instance creation' }
BrTextEditorAbstractSegmentPiece >> createElement: anEditorElement [
	<return: #BlElement>

	^ self subclassResponsibility
]

{ #category : #'api - cursor' }
BrTextEditorAbstractSegmentPiece >> currentCursors [
	"Return a collection of known unique cursors within this segment piece.
	It is important to remember cursors in order to send fine grained events when cursor's location changes
	or new cursors are added"
	<return: #Set of: #BrTextEditorSingleCursor>
	
	^ currentCursors
]

{ #category : #'api - cursor' }
BrTextEditorAbstractSegmentPiece >> currentCursors: aSetOfCursors [	
	currentCursors := aSetOfCursors asSet
]

{ #category : #printing }
BrTextEditorAbstractSegmentPiece >> gtDisplayOn: aStream [
	self printOn: aStream
]

{ #category : #initialization }
BrTextEditorAbstractSegmentPiece >> initialize [
	super initialize.
	
	currentCursors := Set new
]

{ #category : #testing }
BrTextEditorAbstractSegmentPiece >> isText [
	^ false
]

{ #category : #updating }
BrTextEditorAbstractSegmentPiece >> onRecycled: aPieceElement in: anEditorElement [
]

{ #category : #printing }
BrTextEditorAbstractSegmentPiece >> printOn: aStream [
	self text printOn: aStream
]

{ #category : #accessing }
BrTextEditorAbstractSegmentPiece >> segment [
	^ segment
]

{ #category : #accessing }
BrTextEditorAbstractSegmentPiece >> segment: anObject [
	segment := anObject
]

{ #category : #updating }
BrTextEditorAbstractSegmentPiece >> updateFocus: hasFocus of: aTextPieceElement in: anEditorElement [
	| aRequest |

	aRequest := hasFocus
		ifTrue: [ BrTextEditorFocusRequest new ]
		ifFalse: [ BrTextEditorBlurRequest new ].

	aTextPieceElement dispatchEvent: (aRequest editorElement: anEditorElement)
]

{ #category : #updating }
BrTextEditorAbstractSegmentPiece >> updateText: aTextElement of: aLineSegment in: anEditorElement [
	aTextElement dispatchEvent: (BrTextEditorTextChangedRequest new
		editorElement: anEditorElement;
		segmentPiece: self;
		text: self text;
		textStart: self textStart;
		textEnd: self textEnd)
]

{ #category : #'api - geometry' }
BrTextEditorAbstractSegmentPiece >> wordMargin [
	<return: #BlInsets>
	| aHalfOfLineSpacing |
	
	aHalfOfLineSpacing := (self segment lineSpacing / 2.0) floor.

	^ BlInsets
		top: aHalfOfLineSpacing
		bottom: (self segment lineSpacing - aHalfOfLineSpacing)
]

{ #category : #'api - geometry' }
BrTextEditorAbstractSegmentPiece >> wordPadding [
	<return: #BlInsets>
		
	^ self segment wordPadding
]
