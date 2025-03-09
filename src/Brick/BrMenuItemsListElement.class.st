Class {
	#name : #BrMenuItemsListElement,
	#superclass : #BrMenuModelElement,
	#instVars : [
		'listElement',
		'typeBuilder'
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
		beNotFocusable;
		fitContentLimited;
		itemType: [ :anItemTypeFactory :anItemObject :anItemIndex | 
			anItemObject elementType ];
		itemType: [ :aFactory :anObject :anIndex | 
			self visitMenuModel: anObject ];
		itemStencil: [ :anItemType | 
			self typeBuilder buildElementFromItemType: anItemType ];
		itemDataBinder: [ :anItemElement :anItemObject :anItemIndex |
			anItemElement menuModel: anItemObject ].
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
BrMenuItemsListElement >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.

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
