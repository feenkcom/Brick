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
	self
		fitContentLimited;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		background: self theme default contentBackgroundColor.

	self initializeListElement.
	self addChild: listElement as: #'menu--list'.
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
					margin: (BlInsets top: 3 bottom: 1 left: 3 right: 3) ];
			headerDataBinder: [ :aLabelElement :aGroup | 
				aLabelElement text: aGroup domainObject name asString ];
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
	self removeFromParent
]

{ #category : #'event handling' }
BrMenuItemsGroupedElement >> onMenuModelChanged [
	super onMenuModelChanged.

	listElement groups: self listGroups
]

{ #category : #'event handling' }
BrMenuItemsGroupedElement >> subscribeToMenuModel [
	super subscribeToMenuModel.

	self menuModel announcer weak
		when: BrMenuHideRequest
		send: #onMenuHideRequest:
		to: self
]

{ #category : #'event handling' }
BrMenuItemsGroupedElement >> unsubscribeFromMenuModel [
	super unsubscribeFromMenuModel.

	self menuModel announcer unsubscribe: self
]
