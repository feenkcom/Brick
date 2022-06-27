"
I special type of a segment piece that creates an element based on adornment attribute.

I am created by BrTextEditorAttributedLineSegment - a segment that supports adornment attributes
"
Class {
	#name : #BrTextEditorLineSegmentAdornmentPiece,
	#superclass : #BrTextEditorLineSegmentPiece,
	#instVars : [
		'adornmentAttribute',
		'isVirtual'
	],
	#category : #'Brick-Editor-Model - Segment-Text-Line'
}

{ #category : #comparing }
BrTextEditorLineSegmentAdornmentPiece >> = anotherObject [
	^ super = anotherObject
		and: [ anotherObject adornmentAttribute = self adornmentAttribute ]
]

{ #category : #accessing }
BrTextEditorLineSegmentAdornmentPiece >> adornmentAttribute [
	<return: #BrTextAdornmentAttribute>

	^ adornmentAttribute
]

{ #category : #accessing }
BrTextEditorLineSegmentAdornmentPiece >> adornmentAttribute: aBrTextAdornmentAttribute [

	self
		assert: [ aBrTextAdornmentAttribute isNotNil ]
		description: [ 'Adornment attribute must not be nil' ].

	adornmentAttribute := aBrTextAdornmentAttribute
]

{ #category : #'instance creation' }
BrTextEditorLineSegmentAdornmentPiece >> createElement: anEditorElement [
	^self createAdornmentElement: anEditorElement
]

{ #category : #comparing }
BrTextEditorLineSegmentAdornmentPiece >> hash [
	^ super hash bitXor: self adornmentAttribute hash
]

{ #category : #initialization }
BrTextEditorLineSegmentAdornmentPiece >> initialize [
	super initialize.

	"means I do not count for representing an actual text"
	isVirtual := true
]

{ #category : #accessing }
BrTextEditorLineSegmentAdornmentPiece >> isVirtual [
	^ isVirtual
]

{ #category : #'api - cursor' }
BrTextEditorLineSegmentAdornmentPiece >> screenToCursor: aTransformation of: anEditorElement in: aPieceElement [
	super screenToCursor: aTransformation of: anEditorElement in: aPieceElement.
	
	aTransformation hasResult
		ifFalse: [ aTransformation transformed: self textEnd ]
]

{ #category : #accessing }
BrTextEditorLineSegmentAdornmentPiece >> virtual: aBoolean [
	isVirtual := aBoolean
]
