Class {
	#name : #BrMenuSteppedElement,
	#superclass : #BrMenuModelElement,
	#instVars : [
		'elementCache',
		'elementBuilder'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #'private - updating' }
BrMenuSteppedElement >> addMenuModel: aMenuModel element: aMenuElement [
	aMenuElement parent == self ifTrue: [ ^ self ].

	aMenuElement removeFromParent.
	self addChild: aMenuElement.
	self
		dispatchEvent: (BrPopoverElementAdded new
				menuElement: aMenuElement;
				menuModel: aMenuModel).
	aMenuModel onMenuDisplayed: aMenuElement
]

{ #category : #accessing }
BrMenuSteppedElement >> anchor: anAnchor [
	super anchor: anAnchor.

	"Some code depends on anchor elements even after menu element removal.
	For that reason, the anchor is set to every menu element."
	elementCache
		keysAndValuesDo: [ :aMenuModel :anElement | anElement anchor: anAnchor ]
]

{ #category : #private }
BrMenuSteppedElement >> cachedSubmenuElement: aSubmenu [
	^ elementCache
		at: aSubmenu elementMenuModel
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
BrMenuSteppedElement >> hasEmptyElementCache [
	"For testing purposes only, e.g., scripter examples"

	^ elementCache isEmpty
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
		when: BrPopoverShowSubmenuWish
		do: [ :anEvent | self onShowSubmenuWish: anEvent ].
	self 
		when: BrPopoverDetachWish
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
	| anElement |
	anElement := self visitSubmenu: aSubmenu.
	
	"Some code depends on anchor elements even after menu element removal.
	For that reason, the anchor is set to every menu element.
	Note: We want to remove such dependency, so please do not create more
	code using `anElement anchor`."
	anElement ifNotNil: [
		self anchor ifNotNil: [ :anAnchor | 
			anElement anchor: self anchor ] ].
	
	^ anElement
]

{ #category : #'hooks - children' }
BrMenuSteppedElement >> onChildRemoved: anElement [
	super onChildRemoved: anElement.

	self dispatchEvent: (BrPopoverElementRemoved new menuElement: anElement).

	self childrenCount isZero ifFalse: [ ^ self ].

	BlTaskAction
		enqueueElement: self
		action: [ self dispatchEvent: BrPopoverHideAllWish new ]
]

{ #category : #'event handling' }
BrMenuSteppedElement >> onDetachWish: anEvent [
	"Detach an event source element from its view model.
	Particularly:
	- remove the element from my cache (and therefore create a new element if show menu it requested again), and
	- unsubscribe it from the menu model"

	| aMenuModel anElement |
	anEvent consumed: true.
	
	aMenuModel := anEvent menuModel elementMenuModel.
	aMenuModel ifNil: [ 
		elementCache keysAndValuesDo: [ :eachMenuModel :eachElement | 
			eachElement = anEvent source ifTrue: [ aMenuModel := eachMenuModel ] ] ].
	aMenuModel ifNil: [ ^ self ].
	
	anElement := self removeCachedSubmenuElement: aMenuModel.
	anElement ifNil: [ ^ self ].
	
	"In case of detach wish, we do not want to unsubscribe from user-defined subscriptions."
	anElement dispatchEvent: (BrPopoverUnsubscribeWish new
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
	aSubmenuElement
		constraintsDo: [ :c | c stepped relativeBounds: anEvent fromElement bounds ].
	self addMenuModel: aSubmenu element: aSubmenuElement
]

{ #category : #'private - updating' }
BrMenuSteppedElement >> removeCachedElements [
	elementCache
		keysAndValuesDo: [ :aMenuModel :anElement | 
			anElement
				dispatchEvent: (BrPopoverUnsubscribeWish new
						alsoUserSubscriptions: true).
			anElement removeFromParent ].
	elementCache removeAll
]

{ #category : #'private - updating' }
BrMenuSteppedElement >> removeCachedSubmenuElement: aMenuModel [
	^ elementCache removeKey: aMenuModel elementMenuModel ifAbsent: [ nil ].
]

{ #category : #'api - displaying' }
BrMenuSteppedElement >> show [
	"Display menu element."

	| anElement aMenuModel |
	aMenuModel := self menuModel.
	anElement := self cachedSubmenuElement: aMenuModel.
	self addMenuModel: aMenuModel element: anElement
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
BrMenuSteppedElement >> withTooltipAreas [
	self layout withTooltipAreas
]

{ #category : #'api - initialization' }
BrMenuSteppedElement >> withTooltipHandle [
	self layout withTooltipHandle
]

{ #category : #'api - initialization' }
BrMenuSteppedElement >> withTopLeftHandle [
	self layout withTopLeftHandle
]

{ #category : #'api - initialization' }
BrMenuSteppedElement >> withoutHandle [
	self layout withoutHandle
]
