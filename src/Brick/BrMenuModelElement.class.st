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
BrMenuModelElement >> initialize [
	super initialize.

	self
		when: BrPopoverUnsubscribeWish
		do: [ :anEvent | self onMenuUnsubscribeWish: anEvent ]
]

{ #category : #initialization }
BrMenuModelElement >> initializeCommonStyle [
	self addAptitude: BrPopoverCommonAptitude new.
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
BrMenuModelElement >> onMenuUnsubscribeWish: anEvent [
	anEvent alsoUserSubscriptions
		ifTrue: [ self unsubscribeFromMenuModel ]
		ifFalse: [ self unsubscribeFromMenuModelExcludingUserSubscriptions ]
]

{ #category : #'event handling' }
BrMenuModelElement >> subscribeToMenuModel [
]

{ #category : #'event handling' }
BrMenuModelElement >> unsubscribeFromMenuModel [
	self unsubscribeFromMenuModelExcludingUserSubscriptions
]

{ #category : #'event handling' }
BrMenuModelElement >> unsubscribeFromMenuModelExcludingUserSubscriptions [
]
