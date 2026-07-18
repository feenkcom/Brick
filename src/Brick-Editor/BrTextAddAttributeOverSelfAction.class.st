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

{ #category : #initialization }
BrTextAddAttributeOverSelfAction >> setAttribute: anAttribute [
	attribute := anAttribute
]
