Class {
	#name : #BrColumnWidthChanged,
	#superclass : #Announcement,
	#instVars : [
		'column',
		'columnWidth'
	],
	#category : #'Brick-Column - Events'
}

{ #category : #accessing }
BrColumnWidthChanged >> column [
	^ column
]

{ #category : #accessing }
BrColumnWidthChanged >> column: anObject [
	column := anObject
]

{ #category : #accessing }
BrColumnWidthChanged >> columnWidth [
	^ columnWidth
]

{ #category : #accessing }
BrColumnWidthChanged >> columnWidth: anObject [
	columnWidth := anObject
]
