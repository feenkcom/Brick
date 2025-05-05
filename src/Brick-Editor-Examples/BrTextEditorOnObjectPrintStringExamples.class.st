Class {
	#name : #BrTextEditorOnObjectPrintStringExamples,
	#superclass : #BrTextEditorExamples,
	#category : #'Brick-Editor-Examples'
}

{ #category : #'example - Object>>#printString' }
BrTextEditorOnObjectPrintStringExamples >> editorOnObjectPrintString [
	<gtExample>
	<return: #BrTextEditorModel>
	^ self newEditor text: self textObjectPrintString
]

{ #category : #'example - Object>>#printString' }
BrTextEditorOnObjectPrintStringExamples >> elementOnObjectPrintString [
	<gtExample>
	<return: #BrEditorElement>
	^ self newElement editor: self editorOnObjectPrintString
]

{ #category : #'example - Object>>#printString' }
BrTextEditorOnObjectPrintStringExamples >> textObjectPrintString [
	<gtExample>
	<return: #BlRunRopedText>
	^ (Object >> #printString) sourceCode asRopedText monospace
]
