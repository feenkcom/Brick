Class {
	#name : #BrMenuActionItem,
	#superclass : #BrMenuItem,
	#instVars : [
		'action'
	],
	#category : #'Brick-Menu'
}

{ #category : #accessing }
BrMenuActionItem >> action [
	^ action
]

{ #category : #accessing }
BrMenuActionItem >> action: anObject [
	action := anObject
]
