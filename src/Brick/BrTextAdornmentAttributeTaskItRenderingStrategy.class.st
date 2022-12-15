Class {
	#name : #BrTextAdornmentAttributeTaskItRenderingStrategy,
	#superclass : #BrTextAdornmentAttributeRenderingStrategy,
	#category : #'Brick-Editor - UI'
}

{ #category : #accessing }
BrTextAdornmentAttributeTaskItRenderingStrategy >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	"Return an element that should affect (either append or replace) a provided text piece"
	<return: #BlElement>

	^ BrAsyncWidget new
		in: [ :theElement | self attribute initializeLazyElement: theElement ];
		stencil: [ self attribute doAffect: aTBrTextEditorTextualPiece in: anEditorElement ]
]
