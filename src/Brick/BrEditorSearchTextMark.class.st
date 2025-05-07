Class {
	#name : #BrEditorSearchTextMark,
	#superclass : #BlTextHighlightAttribute,
	#instVars : [
		'index',
		'isCurrent'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #comparing }
BrEditorSearchTextMark >> equals: anAnotherAttribute [
	^ (super equals: anAnotherAttribute)
		and: [ self index = anAnotherAttribute index
				and: [ self isCurrent = anAnotherAttribute isCurrent ] ]
]

{ #category : #accessing }
BrEditorSearchTextMark >> index [
	^ index
]

{ #category : #accessing }
BrEditorSearchTextMark >> index: anInteger [
	index := anInteger
]

{ #category : #initialization }
BrEditorSearchTextMark >> initialize [
	super initialize.

	index := 1.
	isCurrent := false.
]

{ #category : #accessing }
BrEditorSearchTextMark >> isCurrent [
	^ isCurrent
]

{ #category : #accessing }
BrEditorSearchTextMark >> isCurrent: aBoolean [
	isCurrent := aBoolean
]
