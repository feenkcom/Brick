Class {
	#name : #BrMenuElementAdded,
	#superclass : #BrMenuChangeEvent,
	#instVars : [
		'menuModel',
		'menuElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuElementAdded >> menuElement [
	^ menuElement
]

{ #category : #accessing }
BrMenuElementAdded >> menuElement: anObject [
	menuElement := anObject
]

{ #category : #accessing }
BrMenuElementAdded >> menuElementDo: aBlock [
	^ self menuElement ifNotNil: aBlock
]

{ #category : #accessing }
BrMenuElementAdded >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrMenuElementAdded >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #sending }
BrMenuElementAdded >> sendTo: anObject [
	anObject menuElementAddedEvent: self
]
