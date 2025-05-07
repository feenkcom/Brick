Class {
	#name : #BrEditorSearchTextMark,
	#superclass : #BlTextAttribute,
	#instVars : [
		'index',
		'isCurrent'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextMark >> index [
	^ index
]

{ #category : #accessing }
BrEditorSearchTextMark >> index: anInteger [
	index := anInteger
]

{ #category : #accessing }
BrEditorSearchTextMark >> isCurrent [
	^ isCurrent
]

{ #category : #accessing }
BrEditorSearchTextMark >> isCurrent: anObject [
	isCurrent := anObject
]
