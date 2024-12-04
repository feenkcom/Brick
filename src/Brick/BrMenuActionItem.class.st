Class {
	#name : #BrMenuActionItem,
	#superclass : #BrMenuLabeledItem,
	#instVars : [
		'action'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #accessing }
BrMenuActionItem >> action [
	^ action
]

{ #category : #accessing }
BrMenuActionItem >> action: anObject [
	action := anObject
]

{ #category : #'api - converting' }
BrMenuActionItem >> elementType [
	^ BrMenuActionItemElement
]
