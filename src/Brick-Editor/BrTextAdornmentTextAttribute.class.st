Class {
	#name : #BrTextAdornmentTextAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'text'
	],
	#category : 'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextAdornmentTextAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	"Return an element that should affect (either append or replace) a provided text piece"
	<return: #SequenceableCollection of: #BlElement>

	^ BlTextElement new text: text
]

{ #category : #accessing }
BrTextAdornmentTextAttribute >> text [
	^ text
]

{ #category : #accessing }
BrTextAdornmentTextAttribute >> text: anObject [
	text := anObject
]
