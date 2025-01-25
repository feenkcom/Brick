Class {
	#name : #BrMenuItemLabeledElement,
	#superclass : #BrMenuItemElement,
	#instVars : [
		'labelElement'
	],
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #initialization }
BrMenuItemLabeledElement >> initialize [
	super initialize.
	self initializeLabelElement.
	self addChild: labelElement as: #'menu--labeled'.
	self
		padding: (BlInsets
				top: BrMenuConstants defaultMenuItemTopPadding
				bottom: BrMenuConstants defaultMenuItemBottomPadding
				left: BrMenuConstants defaultMenuItemLeftPadding
				right: BrMenuConstants defaultMenuItemRightPadding)
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
