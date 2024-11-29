Class {
	#name : #BrMenuModelElement,
	#superclass : #BlElement,
	#instVars : [
		'menuModel'
	],
	#category : #'Brick-Menu - UI'
}

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
]

{ #category : #'event handling' }
BrMenuModelElement >> subscribeToMenuModel [
]

{ #category : #'event handling' }
BrMenuModelElement >> unsubscribeFromMenuModel [
]
