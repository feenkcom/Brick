Class {
	#name : #BrTextRemoveAttributeOverSelfAction,
	#superclass : #BrTextEventHandlingAttributeAction,
	#instVars : [
		'attribute'
	],
	#category : 'Brick-Editor-Attributes'
}

{ #category : #'instance creation' }
BrTextRemoveAttributeOverSelfAction class >> attribute: anAttribute [
	^ self new setAttribute: anAttribute
]

{ #category : #initialization }
BrTextRemoveAttributeOverSelfAction >> setAttribute: anAttribute [
	attribute := anAttribute
]
