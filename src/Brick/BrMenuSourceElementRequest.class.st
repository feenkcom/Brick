Class {
	#name : #BrMenuSourceElementRequest,
	#superclass : #BlEvent,
	#instVars : [
		'sourceElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuSourceElementRequest >> sourceElement [
	^ sourceElement
]

{ #category : #accessing }
BrMenuSourceElementRequest >> sourceElement: anObject [
	sourceElement := anObject
]

{ #category : #accessing }
BrMenuSourceElementRequest >> sourceElementDo: aBlock [
	^ sourceElement ifNotNil: aBlock
]
