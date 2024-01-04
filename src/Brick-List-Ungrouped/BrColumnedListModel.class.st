Class {
	#name : #BrColumnedListModel,
	#superclass : #BrUngroupedListModel,
	#instVars : [
		'columns'
	],
	#category : #'Brick-List-Ungrouped-Models'
}

{ #category : #accessing }
BrColumnedListModel >> column [
	^ columns column
]

{ #category : #accessing }
BrColumnedListModel >> columns [
	^ columns columns
]

{ #category : #enumerating }
BrColumnedListModel >> columnsDo: aBlock [ 

	columns columnsDo: aBlock
]

{ #category : #initialization }
BrColumnedListModel >> initialize [
	super initialize.

	self add: (columns := BrColumnedModel new)
]
