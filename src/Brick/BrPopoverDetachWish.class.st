"
I am used to detach menu elements from their menu models. I am used when a menu element is pinned and therefore should stop listen to hide requests.
I am used internaly. I am not expected to be used by other users, only by the popover implementation.
"
Class {
	#name : #BrPopoverDetachWish,
	#superclass : #BrPopoverWish,
	#instVars : [
		'menuModel'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrPopoverDetachWish >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrPopoverDetachWish >> menuModel: anObject [
	menuModel := anObject
]
