Class {
	#name : #BrMenuSteppedElement,
	#superclass : #BlElement,
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuSteppedElement >> defaultLayout [
	^ BlSteppedLayout new
]

{ #category : #initialization }
BrMenuSteppedElement >> initialize [
	super initialize.

	self
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].

	self
		when: BrMenuShowSubmenuWish
		do: [ :anEvent | self onShowSubmenuWish: anEvent ].
	self
		when: BrMenuHideSubmenuWish
		do: [ :anEvent | self onHideSubmenuWish: anEvent ]
]

{ #category : #'event handling' }
BrMenuSteppedElement >> onHideSubmenuWish: anEvent [
	| aSourceElement aSubmenu aChild |
	self childrenCount isZero ifTrue: [ ^ self ].
	anEvent consumed: true.
	aSourceElement := anEvent fromElement.
	aSubmenu := anEvent submenu.
	
	aChild := self childAt: self childrenCount.
	aChild removeFromParent.
]

{ #category : #'event handling' }
BrMenuSteppedElement >> onShowSubmenuWish: anEvent [
	| aSourceElement aSubmenuElement |
	anEvent consumed: true.
	aSourceElement := anEvent fromElement.
	aSubmenuElement := anEvent submenu asElement.
	aSubmenuElement
				constraintsDo: [ :c | 
					c stepped
						relativeBounds: (aSourceElement bounds) ].
	self addChild: aSubmenuElement.
]
