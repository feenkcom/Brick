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
	self menuModel ifNotNil: [ :aMenuModel |
		aMenuModel action ifNotNil: [ :anAction | 
			anAction cull: anElement cull: aButtonModel cull: anEvent.
			aMenuModel hideOnClick ifTrue: [ 
				aMenuModel hide ] ] ].
]
