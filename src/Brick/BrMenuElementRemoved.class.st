Class {
	#name : #BrMenuElementRemoved,
	#superclass : #BrMenuChangeEvent,
	#instVars : [
		'menuModel',
		'menuElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuElementRemoved >> menuElement [
	^ menuElement
]

{ #category : #accessing }
BrMenuElementRemoved >> menuElement: anObject [
	menuElement := anObject
]

{ #category : #accessing }
BrMenuElementRemoved >> menuElementDo: aBlock [
	^ self menuElement ifNotNil: aBlock
]

{ #category : #accessing }
BrMenuElementRemoved >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrMenuElementRemoved >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #sending }
BrMenuElementRemoved >> sendTo: anObject [
	anObject menuElementRemovedEvent: self
]
