Class {
	#name : #BrMenuActionItemElement,
	#superclass : #BrMenuLabeledItemElement,
	#instVars : [
		'buttonModel'
	],
	#category : #'Brick-Glamorous-Menu'
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
BrMenuActionItemElement >> onActionRequestedAnnouncement: anAnnouncement [
	self dispatchEvent: BlClickEvent new
]

{ #category : #'event handling' }
BrMenuActionItemElement >> onClick: anEvent element: anElement model: aButtonModel [ 
	| aMenuModel |
	aMenuModel := self menuModel.
	aMenuModel ifNil: [ ^ self ].
	aMenuModel action ifNotNil: [ :anAction | 
		anAction gtValueWithArgs: { anElement. aButtonModel. anEvent } ].
	aMenuModel hideOnClick ifTrue: [ aMenuModel hideAll ].
]

{ #category : #'event handling' }
BrMenuActionItemElement >> subscribeToMenuModel [
	super subscribeToMenuModel.
	self menuItem announcer weak
		when: BrMenuModelActionRequestedAnnouncement
		send: #onActionRequestedAnnouncement:
		to: self.
]
