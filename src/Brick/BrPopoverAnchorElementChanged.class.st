Class {
	#name : #BrPopoverAnchorElementChanged,
	#superclass : #BrPopoverChangeEvent,
	#instVars : [
		'anchorElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrPopoverAnchorElementChanged >> anchorElement [
	^ anchorElement
]

{ #category : #accessing }
BrPopoverAnchorElementChanged >> anchorElement: anObject [
	anchorElement := anObject
]

{ #category : #sending }
BrPopoverAnchorElementChanged >> sendTo: anObject [
	anObject menuAnchorElementChangedEvent: self
]
