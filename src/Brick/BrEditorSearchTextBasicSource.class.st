Class {
	#name : #BrEditorSearchTextBasicSource,
	#superclass : #BrEditorSearchTextSource,
	#instVars : [
		'text',
		'visibleText'
	],
	#category : #'Brick-Editor - Search Model'
}

{ #category : #accessing }
BrEditorSearchTextBasicSource >> element [
	"Return an element to which actions, e.g., background computation can be hooked"

	<return: #BlElement or: nil>
	^ nil
]

{ #category : #testing }
BrEditorSearchTextBasicSource >> hasText [
	<return: #Boolean>
	^ self text isNotNil
]

{ #category : #testing }
BrEditorSearchTextBasicSource >> hasVisibleText [
	<return: #Boolean>
	^ self visibleText isNotNil
]

{ #category : #accessing }
BrEditorSearchTextBasicSource >> text [
	^ text
]

{ #category : #accessing }
BrEditorSearchTextBasicSource >> text: anObject [
	text := anObject
]

{ #category : #updating }
BrEditorSearchTextBasicSource >> updateText: aStyledText [
	"Integrate new styled text to the existing editor's text.
	Return true if the integration happened, false otherwise.
	Note: Must be called from a UI process."

	<return: #Boolean>
	(aStyledText isNextGenerationOf: text) ifFalse: [ ^ false ].

	text updateFrom: aStyledText text.
	
	^ true
]

{ #category : #accessing }
BrEditorSearchTextBasicSource >> visibleText [
	^ visibleText
]

{ #category : #accessing }
BrEditorSearchTextBasicSource >> visibleText: anObject [
	visibleText := anObject
]
