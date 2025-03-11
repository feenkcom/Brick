Class {
	#name : #BrMenuSteppedElement,
	#superclass : #BrMenuModelElement,
	#instVars : [
		'elementCache',
		'elementBuilder'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #private }
BrMenuSteppedElement >> cachedSubmenuElement: aSubmenu [
	^ elementCache
		at: aSubmenu
		ifPresent: [ :anElement | anElement ]
		ifAbsentPut: [ self newElementForSubmenu: aSubmenu ]
]

{ #category : #initialization }
BrMenuSteppedElement >> defaultLayout [
	^ BlSteppedLayout new
]

{ #category : #accessing }
BrMenuSteppedElement >> elementBuilder [
	<return: #BrMenuElementBuilder>
	^ elementBuilder ifNil: [ elementBuilder := BrMenuElementBuilder new ]
]

{ #category : #accessing }
BrMenuSteppedElement >> elementBuilder: anElementBuilder [
	"Set a builder that is used to create menu elements."

	elementBuilder := anElementBuilder
]

{ #category : #accessing }
BrMenuSteppedElement >> elementCache [
	"Return a cache.
	For testing purposes only."

	^ elementCache
]

{ #category : #'api - testing' }
BrMenuSteppedElement >> hasPinnedChildrenOnly [
	^ elementCache allSatisfy: [ :anElement | 
		(anElement parent == self) not ]
]

{ #category : #'api - displaying' }
BrMenuSteppedElement >> hide [
	"Remove all my menu elements and caches.
	I should not remove elements that are not cached menu elements."

	self removeCachedElements
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
		clipChildren: false;
		beInSingleCompositionLayer.

	self
		when: BrMenuShowSubmenuWish
		do: [ :anEvent | self onShowSubmenuWish: anEvent ].
	self 
		when: BrMenuDetachWish
		do: [ :anEvent | self onDetachWish: anEvent ].
]

{ #category : #'api - testing' }
BrMenuSteppedElement >> isUnpinnedChild: anElement [
	"Return true if anElement is my child element of an unpinned menu."
	
	(anElement hasParent: self) ifFalse: [ ^ false ].

	^ elementCache anySatisfy: [ :eachElement | 
		anElement == eachElement or: [ 
			anElement hasParent: eachElement ] ]
]

{ #category : #private }
BrMenuSteppedElement >> newElementForSubmenu: aSubmenu [
	<return: #BlElement or: nil>
	^ self visitSubmenu: aSubmenu
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
	aMenuModel
		ifNil: [ elementCache
				keysAndValuesDo: [ :eachMenuModel :eachElement | eachElement = anEvent source ifTrue: [ aMenuModel := eachMenuModel ] ] ].
	aMenuModel ifNil: [ ^ self ].
	anElement := self removeCachedSubmenuElement: aMenuModel.
	anElement ifNil: [ ^ self ].
	
	"In case of detach wish, we do not want to unsubscribe from user-defined subscriptions."
	anElement dispatchEvent: (BrMenuUnsubscribeWish new
		alsoUserSubscriptions: false).
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
	aSubmenu ifNil: [ ^ self ].
	
	aSubmenuElement := self cachedSubmenuElement: aSubmenu.
	aSubmenuElement constraintsDo: [ :c | 
		c stepped relativeBounds: anEvent fromElement bounds ].
	(aSubmenuElement parent == self) ifFalse: [ 
		aSubmenuElement removeFromParent.
		self addChild: aSubmenuElement.
		aSubmenu onMenuDisplayed: aSubmenuElement ]
]

{ #category : #'private - updating' }
BrMenuSteppedElement >> removeCachedElements [
	elementCache
		keysAndValuesDo: [ :aMenuModel :anElement | 
			anElement
				dispatchEvent: (BrMenuUnsubscribeWish new
						alsoUserSubscriptions: true).
			anElement removeFromParent ].
	elementCache removeAll
]

{ #category : #'private - updating' }
BrMenuSteppedElement >> removeCachedSubmenuElement: aMenuModel [
	^ elementCache removeKey: aMenuModel ifAbsent: [ nil ].
]

{ #category : #'api - displaying' }
BrMenuSteppedElement >> show [
	"Display menu element."

	| anElement |
	anElement := self cachedSubmenuElement: self menuModel.
	(anElement parent == self) ifFalse: [ 
		anElement removeFromParent.
		self addChild: anElement.
		self menuModel onMenuDisplayed: anElement ]
]

{ #category : #'private - updating' }
BrMenuSteppedElement >> updateElement [
	self removeCachedElements.
	self show
]

{ #category : #private }
BrMenuSteppedElement >> visitSubmenu: aSubmenu [
	^ aSubmenu acceptVisitor: self elementBuilder
]

{ #category : #'api - initialization' }
BrMenuSteppedElement >> withCenteredHandle [
	self layout withCenteredHandle
]

{ #category : #'api - initialization' }
BrMenuSteppedElement >> withContextMenuAreas [
	self layout withContextMenuAreas
]

{ #category : #'api - initialization' }
BrMenuSteppedElement >> withDownUpDropdownAreas [
	"Place dropdowns only down or up"

	self layout withDownUpDropdownAreas
]

{ #category : #'api - initialization' }
BrMenuSteppedElement >> withDropdownAreas [
	self layout withDropdownAreas
]

{ #category : #'api - initialization' }
BrMenuSteppedElement >> withTopLeftHandle [
	self layout withTopLeftHandle
]

{ #category : #'api - initialization' }
BrMenuSteppedElement >> withoutHandle [
	self layout withoutHandle
]
