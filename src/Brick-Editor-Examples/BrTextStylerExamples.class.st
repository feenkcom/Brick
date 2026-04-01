"
Hello World *https://gtoolkit.com*
"
Class {
	#name : #BrTextStylerExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples'
}

{ #category : #'examples - editor' }
BrTextStylerExamples >> codeSnippetStyler [
	<gtExample>
	<return: #BrRBTextStyler>
	^ BrRBTextStyler new classOrMetaClass: BlElement
]

{ #category : #'examples - editor' }
BrTextStylerExamples >> editorWithMethod [
	<gtExample>
	<return: #BrTextEditorModel>
	^ self newEditor text: self newMethodText
]

{ #category : #'examples - styler strategy' }
BrTextStylerExamples >> editorWithSyncStylerStrategy [
	<gtExample>
	<return: #BrTextEditorModel>
	| anEditor anEditorElement aStyler theTextAttributes |
	anEditor := self editorWithMethod.
	aStyler := self codeSnippetStyler.

	anEditorElement := BrEditorElement new.
	anEditorElement editor: anEditor.

	anEditor useSyncStylerStrategy.
	anEditor styler: aStyler.
	self assert: anEditor stylerStrategy class equals: BrTextStylerSyncStrategy.
	theTextAttributes := anEditor text attributesAt: 1.
	self assert: theTextAttributes size isZero not.

	^ anEditor
]

{ #category : #'instance creation' }
BrTextStylerExamples >> newEditor [
	<gtExample>
	<return: #BrTextEditorModel>
	^ BrTextEditorModel new
]

{ #category : #'instance creation' }
BrTextStylerExamples >> newMethodText [
	<gtExample>
	<return: #BlRunRopedText>
	^ (BlElement >> #applyLayoutSafelyIn:context:) sourceCode asRopedText
]

{ #category : #defaults }
BrTextStylerExamples >> timeoutMilliseconds [
	^ 500
]

{ #category : #'examples - editor' }
BrTextStylerExamples >> workspaceStyler [
	<gtExample>
	<return: #BrRBTextStyler>
	| styler ast |
	styler := BrRBTextStyler new
			isForWorkspace: true;
			yourself.
	ast := styler parseWithSemanticAnalysis: '3 + 4' asRopedText.
	self assert: ast isMethod not.
	^ styler
]
