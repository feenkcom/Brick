Class {
	#name : #BrMenuItemLabeledElement,
	#superclass : #BrMenuItemElement,
	#instVars : [
		'labelElement'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuItemLabeledElement >> initialize [
	super initialize.
	self initializeLabelElement.
	self addChild: labelElement as: #'menu--labeled'.
	self padding: (BlInsets top: 5 bottom: 5 left: 10 right: 10)
]

{ #category : #initialization }
BrMenuItemLabeledElement >> initializeLabelElement [
	labelElement := BrMenuTextLabelElement new
]

{ #category : #'event handling' }
BrMenuItemLabeledElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateLabelElement
]

{ #category : #'private - updating' }
BrMenuItemLabeledElement >> updateLabelElement [
	labelElement labelModel: self menuModel labelModel
]
