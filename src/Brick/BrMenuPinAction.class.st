Class {
	#name : #BrMenuPinAction,
	#superclass : #Object,
	#instVars : [
		'preEndPinBlock',
		'preStartPinBlock'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - execution' }
BrMenuPinAction >> executePreEndPinBlockInContext: aContext [
	self preEndPinBlock ifNotNil: [ :aBlock | 
		aBlock cull: aContext ]
]

{ #category : #'api - execution' }
BrMenuPinAction >> executePreStartPinBlockInContext: aContext [
	self preStartPinBlock ifNotNil: [ :aBlock | 
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

{ #category : #accessing }
BrMenuPinAction >> preStartPinBlock [
	^ preStartPinBlock
]

{ #category : #accessing }
BrMenuPinAction >> preStartPinBlock: anObject [
	preStartPinBlock := anObject
]
