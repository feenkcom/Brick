Class {
	#name : #BrEditorSearchTextResult,
	#superclass : #Object,
	#instVars : [
		'patternItems',
		'context',
		'marker',
		'styledText'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextResult >> context [
	^ context
]

{ #category : #accessing }
BrEditorSearchTextResult >> context: anObject [
	context := anObject
]

{ #category : #accessing }
BrEditorSearchTextResult >> marker [
	^ marker
]

{ #category : #accessing }
BrEditorSearchTextResult >> marker: anObject [
	marker := anObject
]

{ #category : #accessing }
BrEditorSearchTextResult >> patternItems [
	^ patternItems
]

{ #category : #accessing }
BrEditorSearchTextResult >> patternItems: anObject [
	patternItems := anObject
]

{ #category : #accessing }
BrEditorSearchTextResult >> styledText [
	^ styledText
]

{ #category : #accessing }
BrEditorSearchTextResult >> styledText: aText [ 
	styledText := aText
]
