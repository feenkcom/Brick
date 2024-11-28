Class {
	#name : #BrMenuItemElement,
	#superclass : #BlElement,
	#instVars : [
		'menuItem'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #'private - updating' }
BrMenuItemElement >> addLabelElement [
	self addChild: self menuItem labelModel asElement
]

{ #category : #initialization }
BrMenuItemElement >> defaultLayout [
	^ BlLinearLayout horizontal
]

{ #category : #initialization }
BrMenuItemElement >> initialize [
	super initialize.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #accessing }
BrMenuItemElement >> menuItem [
	^ menuItem
]

{ #category : #accessing }
BrMenuItemElement >> menuItem: aMenuItem [
	menuItem = aMenuItem ifTrue: [ ^ self ].

	menuItem ifNotNil: [ self unsubscribeFromMenuItem ].
	menuItem := aMenuItem.
	self onMenuItemChanged.
	self subscribeToMenuItem
]

{ #category : #'event handling' }
BrMenuItemElement >> onMenuItemChanged [
	self when: BlMouseEnterEvent do: [ :anEvent | self onMouseEnterEvent: anEvent ]
]

{ #category : #'event handling' }
BrMenuItemElement >> onMouseEnterEvent: anEvent [
	self menuItem ifNil: [ ^ self ].
	anEvent consumed: true.
	self menuItem select
]

{ #category : #'event handling' }
BrMenuItemElement >> onSelectionChanged: anAnnouncement [
]

{ #category : #'event handling' }
BrMenuItemElement >> subscribeToMenuItem [
	self menuItem announcer weak
		when: BrMenuItemSelectionChanged
		send: #onSelectionChanged:
		to: self
]

{ #category : #'event handling' }
BrMenuItemElement >> unsubscribeFromMenuItem [
	self menuItem unsubscribe: self
]
