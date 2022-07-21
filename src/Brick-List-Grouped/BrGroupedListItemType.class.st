Class {
	#name : #BrGroupedListItemType,
	#superclass : #BrListItemType,
	#instVars : [
		'group',
		'itemType'
	],
	#category : #'Brick-List-Grouped-Support'
}

{ #category : #comparing }
BrGroupedListItemType >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ group = anObject group and: [ itemType = anObject itemType ]
]

{ #category : #accessing }
BrGroupedListItemType >> group [

	^ group
]

{ #category : #accessing }
BrGroupedListItemType >> group: anObject [

	group := anObject
]

{ #category : #comparing }
BrGroupedListItemType >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ group hash bitXor: itemType hash
]

{ #category : #accessing }
BrGroupedListItemType >> itemType [

	^ itemType
]

{ #category : #accessing }
BrGroupedListItemType >> itemType: anObject [

	itemType := anObject
]
