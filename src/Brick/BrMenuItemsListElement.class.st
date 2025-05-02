Class {
	#name : #BrMenuItemsListElement,
	#superclass : #BrMenuModelElement,
	#instVars : [
		'listElement',
		'typeBuilder'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #'event handling' }
BrMenuItemsListElement >> actOnSelectedMenuItem [
	listElement selectedItemDo: [ :anItem | 
		anItem requestAct ]
]

{ #category : #initialization }
BrMenuItemsListElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
BrMenuItemsListElement >> initialize [
	super initialize.
	self fitContentLimited.
	self initializeListElement.

	self addChild: listElement as: #'menu--list'.
	self initializeCommonStyle.
	
	self 
		when: BrPopoverGainFocusWish
		do: [ :anEvent | self onPopoverGainFocusWish: anEvent ]
]

{ #category : #initialization }
BrMenuItemsListElement >> initializeListElement [
	listElement := BrSimpleList new
		fitContentLimited;
		itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | 
			anItemObject elementType ];
		itemType: [ :aFactory :anObject :anIndex | 
			self visitMenuModel: anObject ];
		itemStencil: [ :anItemType | 
			self typeBuilder buildElementFromItemType: anItemType ];
		itemDataBinder: [ :anItemElement :anItemObject :anItemIndex |
			anItemElement menuModel: anItemObject ];
		when: BrSelectionChanged do: [ :anEvent | self onSelectionChanged: anEvent ];
		addShortcut: (BlShortcutWithAction new
			name: 'Navigate to submenu';
			description: 'Navigate to a menu item submenu';
			combination: BlKeyCombination builder arrowRight build;
			action: [ :aShortcutEvent :aShortcut | self navigateToMenuItemSubmenu ]);
		addShortcut: (BlShortcutWithAction new
			name: 'Navigate to parent menu item';
			description: 'Navigate to a parent menu item to which a current submenu belongs';
			combination: BlKeyCombination builder arrowLeft build;
			action: [ :aShortcutEvent :aShortcut | self navigateToParentMenuItem ]);
		addShortcut: (BlShortcutWithAction new
			name: 'Act on selected menu item';
			description: 'Act on selected menu item';
			combination: BlKeyCombination builder return build;
			action: [  :aShortcutEvent :aShortcut | self actOnSelectedMenuItem ]).
]

{ #category : #'event handling' }
BrMenuItemsListElement >> navigateToMenuItemSubmenu [
	listElement selectedItemDo: [ :anItem | 
		anItem requestNavigateToSubmenu ]
]

{ #category : #'event handling' }
BrMenuItemsListElement >> navigateToParentMenuItem [
	listElement selectedItemDo: [ :anItem | 
		anItem deselect ].
	self menuModel requestNavigateToParent.
]

{ #category : #'event handling' }
BrMenuItemsListElement >> onMenuHideRequest: anAnnouncement [
	"Must be called in a UI process."

	self removeFromParent
]

{ #category : #'event handling' }
BrMenuItemsListElement >> onMenuItemsChanged: anAnnouncement [
	BlTaskAction 
		enqueueElement: self 
		action: [ self updateListElement ]
]

{ #category : #'event handling' }
BrMenuItemsListElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateListElement
]

{ #category : #'event handling' }
BrMenuItemsListElement >> onMenuNavigateAnnouncement: anAnnouncement [
	anAnnouncement menuModel == self menuModel ifFalse: [ ^ self ].
	listElement requestFocus
]

{ #category : #'event handling' }
BrMenuItemsListElement >> onMenuUnsubscribeWish: anEvent [
	| aScrollable |
	super onMenuUnsubscribeWish: anEvent.

	anEvent alsoUserSubscriptions ifFalse: [ ^ self ].
	aScrollable := listElement childWithId: #scrollable.
	aScrollable childrenDo: [ :eachChild | 
		eachChild dispatchEvent: (BrPopoverUnsubscribeWish new alsoUserSubscriptions: true) ]
]

{ #category : #initialization }
BrMenuItemsListElement >> onPopoverGainFocusWish: anEvent [ 
	anEvent consumed: true.
	
	listElement requestFocus.
	"listElement selectOne: 1"
]

{ #category : #'event handling' }
BrMenuItemsListElement >> onSelectionChanged: anEvent [
	listElement selectedItemDo: [ :aMenuModel | aMenuModel select ]
]

{ #category : #'event handling' }
BrMenuItemsListElement >> subscribeToMenuModel [
	super subscribeToMenuModel.

	self menuModel announcer weak
		when: BrMenuHideAnnouncement
			send: #onMenuHideRequest:
			to: self;
		when: BrMenuItemsChangedAnnouncement
			send: #onMenuItemsChanged:
			to: self;
		when: BrMenuNavigateAnnouncement
			send: #onMenuNavigateAnnouncement:
			to: self
]

{ #category : #accessing }
BrMenuItemsListElement >> typeBuilder [
	<return: #BrMenuItemTypeBuilder>
	^ typeBuilder ifNil: [ typeBuilder := BrMenuItemTypeBuilder new ]
]

{ #category : #accessing }
BrMenuItemsListElement >> typeBuilder: anObject [
	typeBuilder := anObject
]

{ #category : #'event handling' }
BrMenuItemsListElement >> unsubscribeFromMenuModelExcludingUserSubscriptions [
	super unsubscribeFromMenuModelExcludingUserSubscriptions.

	self menuModel announcer unsubscribe: self
]

{ #category : #'private - updating' }
BrMenuItemsListElement >> updateListElement [
	listElement items: self menuModel items
]

{ #category : #initialization }
BrMenuItemsListElement >> visitMenuModel: aMenuModel [
	^ aMenuModel acceptVisitor: self typeBuilder 
]
