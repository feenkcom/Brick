Class {
	#name : #BrPopoverElementAdded,
	#superclass : #BrPopoverChangeEvent,
	#instVars : [
		'menuModel',
		'menuElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrPopoverElementAdded >> menuElement [
	^ menuElement
]

{ #category : #accessing }
BrPopoverElementAdded >> menuElement: anObject [
	menuElement := anObject
]

{ #category : #accessing }
BrPopoverElementAdded >> menuElementDo: aBlock [
	^ self menuElement ifNotNil: aBlock
]

{ #category : #accessing }
BrPopoverElementAdded >> menuModel [
	^ menuModel
]

{ #category : #accessing }
BrPopoverElementAdded >> menuModel: anObject [
	menuModel := anObject
]

{ #category : #sending }
BrPopoverElementAdded >> sendTo: anObject [
	anObject menuElementAddedEvent: self
]
