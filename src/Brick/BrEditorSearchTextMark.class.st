Class {
	#name : #BrEditorSearchTextMark,
	#superclass : #BlTextAttribute,
	#instVars : [
		'index'
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
