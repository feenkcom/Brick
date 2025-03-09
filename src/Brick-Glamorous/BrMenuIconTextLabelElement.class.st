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
	anIconElement := self labelModel icon asElement.
	anIconElement ifNil: [ ^ self ].
	iconContainer addChild: anIconElement as: #'menu-icon'
]
