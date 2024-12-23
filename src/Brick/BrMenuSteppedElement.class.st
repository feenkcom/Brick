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
		ifPresent: [ :anElement | anElement ]
		ifAbsentPut: [ aSubmenu asElement ]
]

{ #category : #initialization }
BrMenuSteppedElement >> defaultLayout [
	^ BlSteppedLayout new
]

{ #category : #'api - testing' }
BrMenuSteppedElement >> hasPinnedChildrenOnly [
	^ elementCache allSatisfy: [ :anElement | 
		(anElement parent == self) not ]
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

{ #category : #'api - testing' }
BrMenuSteppedElement >> isUnpinnedChild: anElement [
	"Return true if anElement is my child element of an unpinned menu."
	
	(anElement hasParent: self) ifFalse: [ ^ false ].

	^ elementCache anySatisfy: [ :eachElement | 
		anElement == eachElement or: [ 
			anElement hasParent: eachElement ] ]
]

{ #category : #'event handling' }
BrMenuSteppedElement >> onDetachWish: anEvent [
	"Detach an event source element from its view model.
	Particularly:
	- remove the element from my cache (and therefore create a new element if show menu it requested again), and
	- unsubscribe it from the menu model"

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
	| aSubmenuElement aSubmenu |
	anEvent consumed: true.
	aSubmenu := anEvent submenu.
	aSubmenuElement := self cachedSubmenuElement: aSubmenu.
	aSubmenuElement constraintsDo: [ :c | 
		c stepped relativeBounds: anEvent fromElement bounds ].
	(aSubmenuElement parent == self) ifFalse: [ 
		aSubmenuElement removeFromParent.
		self addChild: aSubmenuElement ]
]

{ #category : #'api - displaying' }
BrMenuSteppedElement >> show [
	| anElement |
	anElement := self cachedSubmenuElement: self menuModel.
	(anElement parent == self) ifFalse: [ 
		anElement removeFromParent.
		self addChild: anElement ]
]

{ #category : #'private - updating' }
BrMenuSteppedElement >> updateElement [
	elementCache keysAndValuesDo: [ :aMenu :anElement | 
		anElement removeFromParent ].
	elementCache removeAll.
	self show
]
