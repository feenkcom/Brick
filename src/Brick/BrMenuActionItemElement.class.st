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
	self addViewModel: (buttonModel := BrButtonModel new
		action: [ :anElement :aButtonModel :anEvent |
			self 
				onClick: anEvent 
				element: anElement 
				model: aButtonModel ]).
	self initializeCommonStyling
]

{ #category : #'event handling' }
BrMenuActionItemElement >> onClick: anEvent element: anElement model: aButtonModel [ 
	| aMenuModel |
	aMenuModel := self menuModel.
	aMenuModel ifNil: [ ^ self ].
	aMenuModel action ifNotNil: [ :anAction | 
		anAction gtValueWithArgs: { anElement. aButtonModel. anEvent } ].
	aMenuModel hideOnClick ifTrue: [ 
		BlTaskAction
			enqueueElement: self 
			action: [ aMenuModel hideAll ] ].
]
