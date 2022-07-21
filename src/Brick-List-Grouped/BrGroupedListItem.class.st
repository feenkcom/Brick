Class {
	#name : #BrGroupedListItem,
	#superclass : #BrGroupedListEntity,
	#instVars : [
		'itemObject'
	],
	#category : #'Brick-List-Grouped-Models'
}

{ #category : #testing }
BrGroupedListItem >> isItem [
	^ true
]

{ #category : #accessing }
BrGroupedListItem >> itemObject [

	^ itemObject
]

{ #category : #accessing }
BrGroupedListItem >> itemObject: anObject [

	itemObject := anObject
]

{ #category : #accessing }
BrGroupedListItem >> object [
	^ self itemObject
]
