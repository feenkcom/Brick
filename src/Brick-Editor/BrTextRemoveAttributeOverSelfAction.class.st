Class {
	#name : #BrTextRemoveAttributeOverSelfAction,
	#superclass : #BrTextEventHandlingAttributeAction,
	#instVars : [
		'attribute'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #'instance creation' }
BrTextRemoveAttributeOverSelfAction class >> attribute: anAttribute [
	^ self new setAttribute: anAttribute
]

{ #category : #private }
BrTextRemoveAttributeOverSelfAction >> performAction: anEvent in: aTextEditor [
	| aStart anEnd aText |
	aText := aTextEditor text.
	aStart := anEvent attributeStart.
	anEnd := anEvent attributeEnd.
	
	(aText from: aStart to: anEnd) clearAttributes: [ :eachTextAttribute | 
		attribute == eachTextAttribute ] 
]

{ #category : #initialization }
BrTextRemoveAttributeOverSelfAction >> setAttribute: anAttribute [
	attribute := anAttribute
]
