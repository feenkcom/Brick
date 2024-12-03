Class {
	#name : #BrMenuDetachWish,
	#superclass : #BrWish,
	#instVars : [
		'menuModel'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuDetachWish >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrMenuDetachWish >> menuModel: anObject [
	menuModel := anObject
]
