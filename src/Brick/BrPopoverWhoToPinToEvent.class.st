Class {
	#name : #BrPopoverWhoToPinToEvent,
	#superclass : #BrPopoverEvent,
	#instVars : [
		'anchorElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrPopoverWhoToPinToEvent >> anchorElement [
	^ anchorElement
]

{ #category : #accessing }
BrPopoverWhoToPinToEvent >> anchorElement: anObject [
	anchorElement := anObject
]

{ #category : #accessing }
BrPopoverWhoToPinToEvent >> element [
	^ anchorElement
]

{ #category : #accessing }
BrPopoverWhoToPinToEvent >> element: anObject [
	anchorElement := anObject
]
