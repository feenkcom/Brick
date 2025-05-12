Class {
	#name : #BrEditorSearchTextSource,
	#superclass : #Object,
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextSource >> element [
	"Return an element to which actions, e.g., background computation can be hooked"

	<return: #BlElement or: nil>
	^ self subclassResponsibility
]

{ #category : #testing }
BrEditorSearchTextSource >> hasText [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #testing }
BrEditorSearchTextSource >> hasVisibleText [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #accessing }
BrEditorSearchTextSource >> text [
	"Return current editor text"

	<return: #BlText or: nil>
	^ self subclassResponsibility
]

{ #category : #updating }
BrEditorSearchTextSource >> updateText: aStyledText [
	"Integrate new styled text to the existing editor's text.
	Return true if the integration happened, false otherwise.
	Note: Must be called from a UI process."

	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #accessing }
BrEditorSearchTextSource >> visibleText [
	"Return current editor visible text"

	<return: #BlText or: nil>
	^ self subclassResponsibility
]
