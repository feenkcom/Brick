Class {
	#name : #BrTextEditorParagraphBasedSelecterExamples,
	#superclass : #BrTextEditorSelecterExamples,
	#category : #'Brick-Editor-Examples-Operators'
}

{ #category : #'examples - word' }
BrTextEditorParagraphBasedSelecterExamples >> editorFor: aText [
	<return: #BrEditor>
	| anEditor |
	anEditor := super editorFor: aText.
	anEditor editor beParagraphBased.
	^anEditor
]
