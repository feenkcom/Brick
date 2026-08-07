Class {
	#name : #BrTextEditorModelExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Model'
}

{ #category : #examples }
BrTextEditorModelExamples >> insertLineEndingAtCursorInheritsIndentationOfPreviousLine [
	"Pressing Enter at the end of an indented line should insert a platform
	line ending and carry the leading whitespace of that line over to the new one."
	<gtExample>
	<return: #BrTextEditorModel>
	| indentedLine anEditor |
	indentedLine := String tab , 'Hello'.
	anEditor := BrTextEditorModel new text: indentedLine asRopedText.
	anEditor moveCursorTo: indentedLine size.

	anEditor insertLineEndingAtCursor.

	self
		assert: anEditor text asString
		equals: indentedLine , OSPlatform current lineEnding , String tab.

	^ anEditor
]

{ #category : #examples }
BrTextEditorModelExamples >> insertLineEndingAtCursorWithoutIndentationInsertsPlatformLineEnding [
	"With no leading whitespace to inherit, only the platform line ending is inserted."
	<gtExample>
	<return: #BrTextEditorModel>
	| anEditor |
	anEditor := BrTextEditorModel new text: 'Hello' asRopedText.
	anEditor moveCursorTo: 'Hello' size.

	anEditor insertLineEndingAtCursor.

	self
		assert: anEditor text asString
		equals: 'Hello' , OSPlatform current lineEnding.

	^ anEditor
]
