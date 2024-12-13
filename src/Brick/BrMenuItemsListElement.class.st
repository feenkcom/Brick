Class {
	#name : #BrMenuItemsListElement,
	#superclass : #BrMenuModelElement,
	#instVars : [
		'listElement'
	],
	#category : #'Brick-Menu - UI'
}

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
	self initializeCommonStyle
]

{ #category : #initialization }
BrMenuItemsListElement >> initializeListElement [
	listElement := BrSimpleList new
		fitContentLimited;
		itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | 
			anItemObject elementType ];
		itemStencil: [ :anItemType | 
			anItemType new ];
		itemDataBinder: [ :anItemElement :anItemObject :anItemIndex |
			anItemElement menuModel: anItemObject ].
]

{ #category : #'event handling' }
BrMenuItemsListElement >> onMenuHideRequest: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self removeFromParent ]
]

{ #category : #'event handling' }
BrMenuItemsListElement >> onMenuItemsChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self updateListElement ]
]

{ #category : #'event handling' }
BrMenuItemsListElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateListElement
]

{ #category : #'event handling' }
BrMenuItemsListElement >> subscribeToMenuModel [
	super subscribeToMenuModel.

	self menuModel announcer weak
		when: BrMenuHideRequest
			send: #onMenuHideRequest:
			to: self;
		when: BrMenuItemsChanged
			send: #onMenuItemsChanged:
			to: self
]

{ #category : #'event handling' }
BrMenuItemsListElement >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.

	self menuModel announcer unsubscribe: self
]

{ #category : #'private - updating' }
BrMenuItemsListElement >> updateListElement [
	listElement items: self menuModel items
]
