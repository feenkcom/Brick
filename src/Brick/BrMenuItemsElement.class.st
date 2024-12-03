Class {
	#name : #BrMenuItemsElement,
	#superclass : #BrMenuModelElement,
	#instVars : [
		'listElement'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuItemsElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
BrMenuItemsElement >> initialize [
	super initialize.
	self fitContentLimited.

	self initializeListElement.
	self addChild: listElement as: #'menu--list'
]

{ #category : #initialization }
BrMenuItemsElement >> initializeListElement [
	listElement := BrSimpleList new
		fitContentLimited;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		padding: (BlInsets all: 5);
		border: (BlBorder paint: Color veryLightGray width: 1);
		background: self theme default contentBackgroundColor;
		stencil: [ :aRowValue :anIndex :aListWidget | aRowValue asElement ];
		itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | anItemObject elementType ];
		itemStencil: [ :anItemType | anItemType new ];
		itemDataBinder: [ :anItemElement :anItemObject :anItemIndex |
			anItemElement menuModel: anItemObject ].
]

{ #category : #'event handling' }
BrMenuItemsElement >> onMenuHideRequest: anAnnouncement [
	self removeFromParent
]

{ #category : #'event handling' }
BrMenuItemsElement >> onMenuModelChanged [
	super onMenuModelChanged.

	listElement items: self menuModel items
]

{ #category : #'event handling' }
BrMenuItemsElement >> subscribeToMenuModel [
	super subscribeToMenuModel.

	self menuModel announcer weak
		when: BrMenuHideRequest
		send: #onMenuHideRequest:
		to: self
]

{ #category : #'event handling' }
BrMenuItemsElement >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.

	self menuModel announcer unsubscribe: self
]
