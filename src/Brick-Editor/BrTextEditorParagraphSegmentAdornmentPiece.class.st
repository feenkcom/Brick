Class {
	#name : #BrTextEditorParagraphSegmentAdornmentPiece,
	#superclass : #BrTextEditorParagraphSegmentPiece,
	#instVars : [
		'adornmentAttribute',
		'isVirtual'
	],
	#category : #'Brick-Editor-Model - Segment-Text-Paragraph'
}

{ #category : #comparing }
BrTextEditorParagraphSegmentAdornmentPiece >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject text = self text
		and: [ anotherObject adornmentAttribute = self adornmentAttribute ]
]

{ #category : #accessing }
BrTextEditorParagraphSegmentAdornmentPiece >> adornmentAttribute [
	<return: #BrTextAdornmentAttribute>

	^ adornmentAttribute
]

{ #category : #accessing }
BrTextEditorParagraphSegmentAdornmentPiece >> adornmentAttribute: aBrTextAdornmentAttribute [

	self
		assert: [ aBrTextAdornmentAttribute isNotNil ]
		description: [ 'Adornment attribute must not be nil' ].

	adornmentAttribute := aBrTextAdornmentAttribute
]

{ #category : #'instance creation' }
BrTextEditorParagraphSegmentAdornmentPiece >> createElement: anEditorElement [
	^ self createAdornmentElement: anEditorElement
]

{ #category : #comparing }
BrTextEditorParagraphSegmentAdornmentPiece >> hash [
	^ (self class hash bitXor: self text hash) bitXor: self adornmentAttribute hash
]

{ #category : #initialization }
BrTextEditorParagraphSegmentAdornmentPiece >> initialize [
	super initialize.

	"means I do not count for representing an actual text"
	isVirtual := true
]

{ #category : #accessing }
BrTextEditorParagraphSegmentAdornmentPiece >> isVirtual [
	^ isVirtual
]

{ #category : #accessing }
BrTextEditorParagraphSegmentAdornmentPiece >> virtual: aBoolean [
	self
		assert: [ aBoolean or: [
			"only replacement attribute can be non-virtual"
			aBoolean not and: [ self adornmentAttribute shouldReplace ] ] ]
		description: [ 'Only replacement attribute can be non-virtual' ].

	isVirtual := aBoolean
]
