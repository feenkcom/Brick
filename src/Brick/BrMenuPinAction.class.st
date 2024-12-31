Class {
	#name : #BrMenuPinAction,
	#superclass : #Object,
	#instVars : [
		'preEndPinBlock'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - execution' }
BrMenuPinAction >> executePreEndPinBlockInContext: aContext [
	self preEndPinBlock ifNotNil: [ :aBlock | 
		aBlock cull: aContext ]
]

{ #category : #accessing }
BrMenuPinAction >> preEndPinBlock [
	^ preEndPinBlock
]

{ #category : #accessing }
BrMenuPinAction >> preEndPinBlock: anObject [
	preEndPinBlock := anObject
]
