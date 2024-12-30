Class {
	#name : #BrMenuAnchorElementChanged,
	#superclass : #BrChangeEvent,
	#instVars : [
		'anchorElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuAnchorElementChanged >> anchorElement [
	^ anchorElement
]

{ #category : #accessing }
BrMenuAnchorElementChanged >> anchorElement: anObject [
	anchorElement := anObject
]

{ #category : #sending }
BrMenuAnchorElementChanged >> sendTo: anObject [
	anObject menuAnchorElementChangedEvent: self
]
