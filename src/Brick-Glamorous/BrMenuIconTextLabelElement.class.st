Class {
	#name : #BrMenuIconTextLabelElement,
	#superclass : #BrMenuTextLabelElement,
	#instVars : [
		'iconContainer'
	],
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #private }
BrMenuIconTextLabelElement >> applyDefaultForegroundToIcon: anIcon [
	| aForeground aBlackBackground aBlackPaint |
	aForeground := self theme label defaultTextForeground.
	aBlackBackground := Color black asBlBackground.
	aBlackPaint := aBlackBackground paint.
	anIcon
		withAllChildrenBreadthFirstDo: [ :anElement | 
			| aBorder |
			aBlackBackground = anElement background
				ifTrue: [ anElement background: aForeground ].
			aBorder := anElement border.
			(aBorder isVisible and: [ aBlackPaint = aBorder paint ])
				ifTrue: [ anElement border: (aBorder copyWithPaint: aForeground) ] ]
]

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
	self applyDefaultForegroundToIcon: anIconElement.
	iconContainer addChild: anIconElement as: #'menu-icon'
]
