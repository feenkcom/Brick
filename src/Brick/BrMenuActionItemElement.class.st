Class {
	#name : #BrMenuActionItemElement,
	#superclass : #BrMenuItemElement,
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuActionItemElement >> initializeStyling [
	super initializeStyling.

	self initializeCommonStyling
]

{ #category : #'event handling' }
BrMenuActionItemElement >> onMenuItemChanged [
	super onMenuItemChanged.
	self updateElement
]

{ #category : #'event handling' }
BrMenuActionItemElement >> updateElement [
	self removeChildren.
	self addLabelElement
]
