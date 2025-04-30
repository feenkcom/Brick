Class {
	#name : #BrMenuExplicitItemElement,
	#superclass : #BrMenuItemElement,
	#category : #'Brick-Menu - UI'
}

{ #category : #accessing }
BrMenuExplicitItemElement >> childId [
	^ #'menu--explicit-child'
]

{ #category : #'api - enablement' }
BrMenuExplicitItemElement >> disable [
	super disable.
	self explicitChildIfFound: [ :aChild | self disableExplicitChild: aChild ] ifNone: [  ].
	^ self
]

{ #category : #'api - enablement' }
BrMenuExplicitItemElement >> disableExplicitChild: aChild [
	aChild states addState: BlElementState disabled
]

{ #category : #'api - enablement' }
BrMenuExplicitItemElement >> enable [
	super enable.
	self explicitChildIfFound: [ :aChild | self enableExplicitChild: aChild ] ifNone: [  ]
]

{ #category : #'api - enablement' }
BrMenuExplicitItemElement >> enableExplicitChild: aChild [
	aChild states removeState: BlElementState disabled
]

{ #category : #'children accessing' }
BrMenuExplicitItemElement >> explicitChildIfFound: aFoundBlock ifNone: aNoneBlock [
	^ self
		childWithId: self childId
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #initialization }
BrMenuExplicitItemElement >> initialize [
	super initialize.
	self initializeCommonStyling
]

{ #category : #'event handling' }
BrMenuExplicitItemElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateExplicitChild
]

{ #category : #'event handling' }
BrMenuExplicitItemElement >> onUpdateRequestedAnnouncement: anAnnouncement [
	super onUpdateRequestedAnnouncement: anAnnouncement.

	self
		explicitChildIfFound: [ :aChild | aChild dispatchEvent: BrPopoverUpdateWish new ]
		ifNone: [  ]
]

{ #category : #'private - updating' }
BrMenuExplicitItemElement >> updateExplicitChild [
	| aNewChild |
	self menuModel stencil
		ifNotNil: [ :aStencil | 
			aNewChild := aStencil
					menuModel: self menuModel;
					asElement ].

	aNewChild
		ifNil: [ self
				explicitChildIfFound: [ :anOldChild | self removeChild: anOldChild ]
				ifNone: [  ].
			^ self ].

	self isEnabled
		ifTrue: [ self enableExplicitChild: aNewChild ]
		ifFalse: [ self disableExplicitChild: aNewChild ].

	self
		explicitChildIfFound: [ :anOldChild | 
			self
				replaceChild: anOldChild
				with: aNewChild
				as: self childId ]
		ifNone: [ self addChildFirst: aNewChild as: self childId ]
]
