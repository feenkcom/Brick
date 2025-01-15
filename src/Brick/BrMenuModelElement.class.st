Class {
	#name : #BrMenuModelElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'menuModel'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuModelElement >> initializeCommonStyle [
	self addAptitude: BrMenuCommonAptitude new.
]

{ #category : #accessing }
BrMenuModelElement >> menuModel [
	<return: #BrMenuModel>
	^ menuModel
]

{ #category : #accessing }
BrMenuModelElement >> menuModel: aMenuModel [
	menuModel = aMenuModel ifTrue: [ ^ self ].

	menuModel ifNotNil: [ self unsubscribeFromMenuModel ].
	menuModel := aMenuModel.
	self onMenuModelChanged.
	self subscribeToMenuModel
]

{ #category : #'event handling' }
BrMenuModelElement >> onMenuModelChanged [
	self menuModel id ifNotNil: [ :anElementId |
		self id: anElementId ]
]

{ #category : #'event handling' }
BrMenuModelElement >> subscribeToMenuModel [
]

{ #category : #'event handling' }
BrMenuModelElement >> unsubscribeFromMenuModel [
]
