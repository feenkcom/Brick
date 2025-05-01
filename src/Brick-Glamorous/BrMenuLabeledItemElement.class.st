Class {
	#name : #BrMenuLabeledItemElement,
	#superclass : #BrMenuItemElement,
	#instVars : [
		'labelElement'
	],
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #'api - enablement' }
BrMenuLabeledItemElement >> disable [
	super disable.
	labelElement disable.
]

{ #category : #'api - enablement' }
BrMenuLabeledItemElement >> enable [
	super enable.
	labelElement enable.
]

{ #category : #initialization }
BrMenuLabeledItemElement >> initialize [
	super initialize.
	self initializeLabelElement.
	self addChild: labelElement as: #'menu--labeled'.
]

{ #category : #initialization }
BrMenuLabeledItemElement >> initializeLabelElement [
	labelElement := BrMenuTextLabelElement new
]

{ #category : #'api - initialization' }
BrMenuLabeledItemElement >> labelElementClass: anElementClass [
	| anElement |
	self
		assert: [ anElementClass isNotNil ]
		description: [ 'Label element must be non-nil' ].
		
	anElementClass = labelElement class ifTrue: [ ^ self ].
		
	anElement := anElementClass new.
	self replaceChild: labelElement with: anElement as: #'menu--labeled'.
	labelElement := anElement.
	
	self menuModel ifNil: [ ^ self ].
	self updateLabelElement
]

{ #category : #'event handling' }
BrMenuLabeledItemElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateLabelElement
]

{ #category : #'event handling' }
BrMenuLabeledItemElement >> onUpdateRequestedAnnouncement: anAnnouncement [
	super onUpdateRequestedAnnouncement: anAnnouncement.

	labelElement dispatchEvent: BrPopoverUpdateWish new
]

{ #category : #'private - updating' }
BrMenuLabeledItemElement >> updateLabelElement [
	labelElement labelModel: self menuModel labelModel
]
