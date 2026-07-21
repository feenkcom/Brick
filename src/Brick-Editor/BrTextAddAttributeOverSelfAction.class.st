Class {
	#name : #BrTextAddAttributeOverSelfAction,
	#superclass : #BrTextEventHandlingAttributeAction,
	#instVars : [
		'attribute'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #'instance creation' }
BrTextAddAttributeOverSelfAction class >> attribute: anAttribute [
	^ self new setAttribute: anAttribute
]

{ #category : #private }
BrTextAddAttributeOverSelfAction >> performAction: anEvent in: aTextEditor [
	| aStart anEnd |
	aStart := anEvent attributeStart.
	anEnd := anEvent attributeEnd.

	(aTextEditor text from: aStart to: anEnd) attributes: {attribute}
]

{ #category : #initialization }
BrTextAddAttributeOverSelfAction >> setAttribute: anAttribute [
	attribute := anAttribute
]
