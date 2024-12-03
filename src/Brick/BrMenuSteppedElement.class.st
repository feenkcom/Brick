Class {
	#name : #BrMenuSteppedElement,
	#superclass : #BrMenuModelElement,
	#instVars : [
		'elementCache'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #private }
BrMenuSteppedElement >> cachedSubmenuElement: aSubmenu [
	^ elementCache
		at: aSubmenu
		ifPresent: [ :anElement | anElement removeFromParent ]
		ifAbsentPut: [ aSubmenu asElement ]
]

{ #category : #initialization }
BrMenuSteppedElement >> defaultLayout [
	^ BlSteppedLayout new
]

{ #category : #initialization }
BrMenuSteppedElement >> initialize [
	super initialize.
	elementCache := IdentityDictionary new.

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
	self 
		when: BrMenuDetachWish
		do: [ :anEvent | self onDetachWish: anEvent ]
]

{ #category : #'event handling' }
BrMenuSteppedElement >> onDetachWish: anEvent [
	| aMenuModel anElement |
	anEvent consumed: true.
	aMenuModel := anEvent menuModel.
	aMenuModel ifNil: [
		elementCache keysAndValuesDo: [ :eachMenuModel :eachElement | 
			eachElement = anEvent source ifTrue: [
				aMenuModel := eachMenuModel ] ] ].
	aMenuModel ifNil: [ ^ self ].
	anElement := elementCache removeKey: aMenuModel ifAbsent: [ nil ].
	aMenuModel announcer unsubscribe: anElement
]

{ #category : #'event handling' }
BrMenuSteppedElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateElement.
]

{ #category : #'event handling' }
BrMenuSteppedElement >> onShowSubmenuWish: anEvent [
	| aSourceElement aSubmenuElement aSubmenu |
	anEvent consumed: true.
	aSubmenu := anEvent submenu.
	aSubmenuElement := self cachedSubmenuElement: aSubmenu.
	aSourceElement := anEvent fromElement.
	aSubmenuElement
		constraintsDo: [ :c | c stepped relativeBounds: aSourceElement bounds ].
	self addChild: aSubmenuElement
]

{ #category : #'private - updating' }
BrMenuSteppedElement >> updateElement [
	self removeChildren.
	self addChild: (self cachedSubmenuElement: self menuModel)
]
