Class {
	#name : #BrMenuPinActionContext,
	#superclass : #Object,
	#instVars : [
		'menuElement',
		'pinnableAptitude'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #accessing }
BrMenuPinActionContext >> menuElement [
	^ menuElement
]

{ #category : #accessing }
BrMenuPinActionContext >> menuElement: anObject [
	menuElement := anObject
]

{ #category : #accessing }
BrMenuPinActionContext >> pinnableAptitude [
	^ pinnableAptitude
]

{ #category : #accessing }
BrMenuPinActionContext >> pinnableAptitude: anObject [
	pinnableAptitude := anObject
]
