Class {
	#name : #BrSearchTextPatternWish,
	#superclass : #BrWish,
	#instVars : [
		'pattern'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrSearchTextPatternWish >> pattern [
	^ pattern
]

{ #category : #accessing }
BrSearchTextPatternWish >> pattern: anObject [
	pattern := anObject
]

{ #category : #'event handling' }
BrSearchTextPatternWish >> text: aBlText [
	pattern := BrEditorSearchTextSubstringPattern new text: aBlText copy
]
