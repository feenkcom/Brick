Class {
	#name : #BrPopoverElementRemoved,
	#superclass : #BrPopoverChangeEvent,
	#instVars : [
		'menuModel',
		'menuElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrPopoverElementRemoved >> menuElement [
	^ menuElement
]

{ #category : #accessing }
BrPopoverElementRemoved >> menuElement: anObject [
	menuElement := anObject
]

{ #category : #accessing }
BrPopoverElementRemoved >> menuElementDo: aBlock [
	^ self menuElement ifNotNil: aBlock
]

{ #category : #accessing }
BrPopoverElementRemoved >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrPopoverElementRemoved >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #sending }
BrPopoverElementRemoved >> sendTo: anObject [
	anObject menuElementRemovedEvent: self
]
