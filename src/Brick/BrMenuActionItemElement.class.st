Class {
	#name : #BrMenuActionItemElement,
	#superclass : #BrMenuItemElement,
	#instVars : [
		'buttonModel'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuActionItemElement >> initializeEventHandlers [
	super initializeEventHandlers.
]

{ #category : #initialization }
BrMenuActionItemElement >> initializeStyling [
	super initializeStyling.

	self initializeCommonStyling
]

{ #category : #initialization }
BrMenuActionItemElement >> initializeViewModels [
	super initializeViewModels.
	self addViewModel: (buttonModel := BrButtonModel new)
]

{ #category : #'event handling' }
BrMenuActionItemElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateButtonModel.
	self updateElement
]

{ #category : #'private - updating' }
BrMenuActionItemElement >> updateButtonModel [
	self menuModel action ifNotNil: [ :anAction | 
		buttonModel action: anAction ]
]

{ #category : #'private - updating' }
BrMenuActionItemElement >> updateElement [
	self removeChildren.
	self addLabelElement
]
