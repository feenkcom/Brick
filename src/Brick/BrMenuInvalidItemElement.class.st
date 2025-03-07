Class {
	#name : #BrMenuInvalidItemElement,
	#superclass : #BrMenuItemElement,
	#instVars : [
		'textElement'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuInvalidItemElement >> initialize [
	super initialize.
	self initializeTextElement.

	self addChild: textElement.
	self
		padding: (BlInsets
				top: BrMenuConstants defaultMenuItemTopPadding
				bottom: BrMenuConstants defaultMenuItemBottomPadding
				left: BrMenuConstants defaultMenuItemLeftPadding
				right: BrMenuConstants defaultMenuItemRightPadding).
	self background: self theme status paleErrorBackgroundColor
]

{ #category : #initialization }
BrMenuInvalidItemElement >> initializeTextElement [
	textElement := BlTextElement new
]

{ #category : #'api - initialization' }
BrMenuInvalidItemElement >> labelModel: aLabelModel [
	^ self menuModel: self
]

{ #category : #'event handling' }
BrMenuInvalidItemElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateTextElement
]

{ #category : #'private - updating' }
BrMenuInvalidItemElement >> updateTextElement [
	textElement text: self menuModel gtDisplayString asRopedText
]
