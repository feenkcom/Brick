Class {
	#name : #BrMenuIconTextLabelElement,
	#superclass : #BrMenuTextLabelElement,
	#instVars : [
		'iconContainer'
	],
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #initialization }
BrMenuIconTextLabelElement >> initialize [
	super initialize.
	self initializeIconElement.
	self addChildFirst: iconContainer as: #'menu--icon-container'.
]

{ #category : #initialization }
BrMenuIconTextLabelElement >> initializeIconElement [
	iconContainer := BrFrame new fitContent
]

{ #category : #'private - updating' }
BrMenuIconTextLabelElement >> updateElement [
	super updateElement.
	self updateIconElement.
]

{ #category : #'private - updating' }
BrMenuIconTextLabelElement >> updateIconElement [
	| anIconElement |
	iconContainer removeChildren.
	self labelModel icon ifNil: [ ^ self ].
	[ anIconElement := self labelModel icon asStencil asElement ]
		onErrorDo: [ :anException | 
			| aButton |
			aButton := BrDebuggableElementStencil new
					freeze: anException;
					createDebugButton.
			aButton id: #'menu--icon-exception'.
			self addChild: aButton after: iconContainer.
			anException return: nil ].
	anIconElement ifNil: [ ^ self ].
	iconContainer addChild: anIconElement as: #'menu-icon'
]
