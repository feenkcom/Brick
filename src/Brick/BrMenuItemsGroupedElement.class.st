Class {
	#name : #BrMenuItemsGroupedElement,
	#superclass : #BrMenuModelElement,
	#instVars : [
		'listElement'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuItemsGroupedElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
BrMenuItemsGroupedElement >> initialize [
	super initialize.
	self fitContentLimited.
	self initializeListElement.

	self addChild: listElement as: #'menu--list'.
	self initializeCommonStyle
]

{ #category : #initialization }
BrMenuItemsGroupedElement >> initializeListElement [
	listElement := BrGroupedList new
			fitContentLimited;
			headerElementStencil: [ :anItemType :aListWidget | 
				BrLabel new
					beSmallSize;
					aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
					hMatchParent;
					vFitContent;
					margin: (BlInsets
							top: BrMenuConstants defaultMenuItemTopPadding
							bottom: 1
							left: BrMenuConstants defaultMenuItemLeftPadding
							right: BrMenuConstants defaultMenuItemRightPadding) ];
			headerDataBinder: [ :aLabelElement :aGroup | aLabelElement text: aGroup domainObject name asString ];
			groups: #()
]

{ #category : #'private - updating' }
BrMenuItemsGroupedElement >> listGroups [
	<return: #Collection of: #BrGroup>
	^ self menuModel groups
		collect: [ :each | 
			BrGroup new
				items: each items;
				domainObject: each configuration;
				itemType: [ :aFactory :anObject :anIndex | anObject elementType ];
				itemStencil: [ :anItemType | anItemType new ];
				itemDataBinder: [ :anItemElement :anItem | anItemElement menuModel: anItem ] ]
]

{ #category : #'event handling' }
BrMenuItemsGroupedElement >> onMenuHideRequest: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ 
			self removeFromParent ]
]

{ #category : #'private - updating' }
BrMenuItemsGroupedElement >> onMenuItemsChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self updateListElement ]
]

{ #category : #'event handling' }
BrMenuItemsGroupedElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateListElement
]

{ #category : #'event handling' }
BrMenuItemsGroupedElement >> subscribeToMenuModel [
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
BrMenuItemsGroupedElement >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.

	self menuModel announcer unsubscribe: self
]

{ #category : #'private - updating' }
BrMenuItemsGroupedElement >> updateListElement [
	listElement groups: self listGroups
]
