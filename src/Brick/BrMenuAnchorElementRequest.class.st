Class {
	#name : #BrMenuAnchorElementRequest,
	#superclass : #BlEvent,
	#instVars : [
		'sourceElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuAnchorElementRequest >> sourceElement [
	^ sourceElement
]

{ #category : #accessing }
BrMenuAnchorElementRequest >> sourceElement: anObject [
	sourceElement := anObject
]

{ #category : #accessing }
BrMenuAnchorElementRequest >> sourceElementDo: aBlock [
	^ sourceElement ifNotNil: aBlock
]
