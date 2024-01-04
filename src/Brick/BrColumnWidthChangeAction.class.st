Class {
	#name : #BrColumnWidthChangeAction,
	#superclass : #Object,
	#instVars : [
		'cellElement'
	],
	#category : #'Brick-Column - Model'
}

{ #category : #accessing }
BrColumnWidthChangeAction >> cellElement [
	^ cellElement at: 1
]

{ #category : #accessing }
BrColumnWidthChangeAction >> cellElement: anElement [
	cellElement := anElement asWeakReference
]

{ #category : #evaluating }
BrColumnWidthChangeAction >> cull: anAnnouncement cull: anAnnouncer [
	self cellElement ifNotNil: [ :aCellElement | anAnnouncement columnWidth applyOn: aCellElement ]
]
