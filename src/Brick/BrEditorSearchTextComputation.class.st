"
I am an abstract class.
I am responsible for searching {{gtClass:BrEditorSearchTextPattern}} places in a given {{gtClass:BlText}}.
I am used by {{gtClass:BrEditorSearchTextMarker}}. 
"
Class {
	#name : #BrEditorSearchTextComputation,
	#superclass : #Object,
	#category : #'Brick-Editor - Search'
}

{ #category : #'api - styling' }
BrEditorSearchTextComputation >> markText: aMarkContext using: aFinder [
	^ self subclassResponsibility
]
