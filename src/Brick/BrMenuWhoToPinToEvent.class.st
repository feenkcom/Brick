Class {
	#name : #BrMenuWhoToPinToEvent,
	#superclass : #BlEvent,
	#instVars : [
		'anchorElement'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #accessing }
BrMenuWhoToPinToEvent >> anchorElement [
	^ anchorElement
]

{ #category : #accessing }
BrMenuWhoToPinToEvent >> anchorElement: anObject [
	anchorElement := anObject
]

{ #category : #accessing }
BrMenuWhoToPinToEvent >> element [
	^ anchorElement
]

{ #category : #accessing }
BrMenuWhoToPinToEvent >> element: anObject [
	anchorElement := anObject
]
