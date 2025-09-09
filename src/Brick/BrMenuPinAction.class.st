Class {
	#name : #BrMenuPinAction,
	#superclass : #Object,
	#instVars : [
		'preEndPinBlock',
		'preStartPinBlock',
		'postEndPinBlock'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - execution' }
BrMenuPinAction >> executePostEndPinBlockInContext: aContext [
	self postEndPinBlock ifNotNil: [ :aBlock | 
		aBlock cull: aContext ]
]

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
BrMenuPinAction >> postEndPinBlock [
	^ postEndPinBlock
]

{ #category : #accessing }
BrMenuPinAction >> postEndPinBlock: oneArgBlock [
	"Define an action that is performed after a menu element is pinned.
	The block must have one argument: [ :aContext | ].
	aContext is an BrMenuPinActionContext object."

	preEndPinBlock := oneArgBlock
]

{ #category : #accessing }
BrMenuPinAction >> preEndPinBlock [
	^ preEndPinBlock
]

{ #category : #accessing }
BrMenuPinAction >> preEndPinBlock: oneArgBlock [
	"Define an action that is performed after a menu element is pinned.
	The block must have one argument: [ :aContext | ].
	aContext is an BrMenuPinActionContext object."

	preEndPinBlock := oneArgBlock
]

{ #category : #accessing }
BrMenuPinAction >> preStartPinBlock [
	^ preStartPinBlock
]

{ #category : #accessing }
BrMenuPinAction >> preStartPinBlock: oneArgBlock [
	"Define an action that is performed before a menu element is pinned.
	The block must have one argument: [ :aContext | ].
	aContext is an BrMenuPinActionContext object."

	preStartPinBlock := oneArgBlock
]
