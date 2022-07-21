Class {
	#name : #BrGroupedListHeader,
	#superclass : #BrGroupedListEntity,
	#instVars : [
		'groupObject'
	],
	#category : #'Brick-List-Grouped-Models'
}

{ #category : #accessing }
BrGroupedListHeader >> groupObject [

	^ groupObject
]

{ #category : #accessing }
BrGroupedListHeader >> groupObject: anObject [

	groupObject := anObject
]

{ #category : #testing }
BrGroupedListHeader >> isHeader [
	^ true
]

{ #category : #accessing }
BrGroupedListHeader >> object [
	^ self groupObject
]
