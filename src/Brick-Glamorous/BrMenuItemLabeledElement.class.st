Class {
	#name : #BrMenuItemLabeledElement,
	#superclass : #BrMenuItemElement,
	#instVars : [
		'labelElement'
	],
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #initialization }
BrMenuItemLabeledElement >> initialize [
	super initialize.
	self initializeLabelElement.
	self addChild: labelElement as: #'menu--labeled'.
	self
		padding: (BlInsets
				top: BrMenuConstants defaultMenuItemTopPadding
				bottom: BrMenuConstants defaultMenuItemBottomPadding
				left: BrMenuConstants defaultMenuItemLeftPadding
				right: BrMenuConstants defaultMenuItemRightPadding)
]

{ #category : #initialization }
BrMenuItemLabeledElement >> initializeLabelElement [
	labelElement := BrMenuTextLabelElement new
]

{ #category : #'api - initialization' }
BrMenuItemLabeledElement >> labelElementClass: anElementClass [
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
BrMenuItemLabeledElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateLabelElement
]

{ #category : #'event handling' }
BrMenuItemLabeledElement >> onUpdateRequestedAnnouncement: anAnnouncement [
	super onUpdateRequestedAnnouncement: anAnnouncement.

	labelElement dispatchEvent: BrMenuUpdateWish new
]

{ #category : #'private - updating' }
BrMenuItemLabeledElement >> updateLabelElement [
	labelElement labelModel: self menuModel labelModel
]
