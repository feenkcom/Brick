"
I am {{gtClass:BrEditorSearchTextSource}}. 
I know how to access {{gtMethod:BrEditor>>#text}}. 
"
Class {
	#name : #BrEditorSearchTextEditorElementSource,
	#superclass : #BrEditorSearchTextSource,
	#instVars : [
		'editorElement'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextEditorElementSource >> editorElement [
	^ editorElement
]

{ #category : #accessing }
BrEditorSearchTextEditorElementSource >> editorElement: anObject [
	editorElement := anObject
]

{ #category : #accessing }
BrEditorSearchTextEditorElementSource >> element [
	"Return an element to which actions, e.g., background computation can be hooked"

	<return: #BlElement or: nil>
	^ self editorElement
]

{ #category : #testing }
BrEditorSearchTextEditorElementSource >> hasText [
	<return: #Boolean>
	^ self editorElement isNotNil
]

{ #category : #testing }
BrEditorSearchTextEditorElementSource >> hasVisibleText [
	<return: #Boolean>
	^ self hasText
		and: [ self editorElement firstVisibleSegment isNotNil
				and: [ self editorElement lastVisibleSegment isNotNil ] ]
]

{ #category : #accessing }
BrEditorSearchTextEditorElementSource >> text [
	"Return current editor text"

	<return: #BlText>
	^ self editorElement text
]

{ #category : #updating }
BrEditorSearchTextEditorElementSource >> updateText: aStyledText [
	"Integrate new styled text to the existing editor's text.
	Return true if the integration happened, false otherwise.
	Note: Must be called from a UI process."

	<return: #Boolean>
	^ BrEditorSearchTextUpdater new
		editorModel: self editorElement editor;
		styledText: aStyledText;
		update
]

{ #category : #accessing }
BrEditorSearchTextEditorElementSource >> visibleText [
	"Return current editor visible text"

	<return: #BlText or: nil>
	^ self editorElement visibleText
]
