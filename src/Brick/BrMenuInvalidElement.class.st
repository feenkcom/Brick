Class {
	#name : #BrMenuInvalidElement,
	#superclass : #BrMenuModelElement,
	#instVars : [
		'textElement'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuInvalidElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #initialization }
BrMenuInvalidElement >> initialize [
	super initialize.
	self initializeTextElement.
	self fitContent.

	self addChild: textElement.
	self background: self theme status paleErrorBackgroundColor
]

{ #category : #initialization }
BrMenuInvalidElement >> initializeTextElement [
	textElement := BlTextElement new
]

{ #category : #'api - initialization' }
BrMenuInvalidElement >> labelModel: aLabelModel [
	self menuModel: self
]

{ #category : #'event handling' }
BrMenuInvalidElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateTextElement
]

{ #category : #'private - updating' }
BrMenuInvalidElement >> updateTextElement [
	textElement text: self menuModel gtDisplayString asRopedText
]
