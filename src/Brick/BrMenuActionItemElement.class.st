Class {
	#name : #BrMenuActionItemElement,
	#superclass : #BrMenuItemLabeledElement,
	#instVars : [
		'buttonModel'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuActionItemElement >> initialize [
	super initialize.
	self addViewModel: (buttonModel := BrButtonModel new).
	self initializeCommonStyling
]

{ #category : #'event handling' }
BrMenuActionItemElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateButtonModel.
]

{ #category : #'private - updating' }
BrMenuActionItemElement >> updateButtonModel [
	self menuModel action ifNotNil: [ :anAction | 
		buttonModel action: anAction ]
]
