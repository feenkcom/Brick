Class {
	#name : #BrEditorSearchTextPatternWish,
	#superclass : #BrWish,
	#instVars : [
		'pattern'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextPatternWish >> pattern [
	^ pattern
]

{ #category : #accessing }
BrEditorSearchTextPatternWish >> pattern: anObject [
	pattern := anObject
]

{ #category : #'event handling' }
BrEditorSearchTextPatternWish >> text: aBlText [
	pattern := BrEditorSearchTextSubstringPattern new text: aBlText copy
]
