Class {
	#name : #BrTextEventHandlingAttributeAction,
	#superclass : #Object,
	#category : 'Brick-Editor-Attributes'
}

{ #category : #private }
BrTextEventHandlingAttributeAction >> performAction: anEvent in: aTextEditor [ 
]

{ #category : #'api - execution' }
BrTextEventHandlingAttributeAction >> performEnterAction: anEvent in: aTextEditor [
	self performAction: anEvent in: aTextEditor
]

{ #category : #'api - execution' }
BrTextEventHandlingAttributeAction >> performLeaveAction: anEvent in: aTextEditor [
	self performAction: anEvent in: aTextEditor
]
