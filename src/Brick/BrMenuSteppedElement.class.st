Class {
	#name : #BrMenuSteppedElement,
	#superclass : #BrMenuModelElement,
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
			c ignoreByLayout.
			c horizontal matchParent.
			c vertical matchParent ];
		preventMouseEvents;
		clipChildren: false.

	self
		when: BrMenuShowSubmenuWish
		do: [ :anEvent | self onShowSubmenuWish: anEvent ].
]

{ #category : #'event handling' }
BrMenuSteppedElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateElement.
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

{ #category : #'private - updating' }
BrMenuSteppedElement >> updateElement [
	self removeChildren.
	self addChild: self menuModel asElement
]
