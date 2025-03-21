Class {
	#name : #BrMenuItemsGroupedElement,
	#superclass : #BrMenuModelElement,
	#instVars : [
		'listElement',
		'typeBuilder'
	],
	#category : #'Brick-Glamorous-Menu'
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
			beNotFocusable;
			fitContentLimited;
			headerElementStencil: [ :anItemType :aListWidget | 
				BrLabel new
					beSmallSize;
					aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
					hMatchParent;
					vFitContent;
					margin: (BlInsets
							top: BrMenuConstants defaultMenuGroupTopPadding
							bottom: BrMenuConstants defaultMenuGroupBottomPadding
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
				itemType: [ :aFactory :anObject :anIndex | 
					self visitMenuModel: anObject ];
				itemStencil: [ :anItemType | 
					self typeBuilder buildElementFromItemType: anItemType ];
				itemDataBinder: [ :anItemElement :anItem | 
					anItemElement menuModel: anItem ] ]
]

{ #category : #'event handling' }
BrMenuItemsGroupedElement >> onMenuHideRequest: anAnnouncement [
	"Must be called in a UI process."

	self removeFromParent
]

{ #category : #'private - updating' }
BrMenuItemsGroupedElement >> onMenuItemsChanged: anAnnouncement [
	BlTaskAction 
		enqueueElement: self 
		action: [ self updateListElement ]
]

{ #category : #'event handling' }
BrMenuItemsGroupedElement >> onMenuModelChanged [
	super onMenuModelChanged.
	self updateListElement
]

{ #category : #'event handling' }
BrMenuItemsGroupedElement >> onMenuUnsubscribeWish: anEvent [
	| aScrollable |
	super onMenuUnsubscribeWish: anEvent.

	anEvent alsoUserSubscriptions ifFalse: [ ^ self ].
	aScrollable := listElement childWithId: #scrollable.
	aScrollable childrenDo: [ :eachChild | 
		eachChild dispatchEvent: (BrMenuUnsubscribeWish new alsoUserSubscriptions: true) ]
]

{ #category : #'event handling' }
BrMenuItemsGroupedElement >> subscribeToMenuModel [
	super subscribeToMenuModel.

	self menuModel announcer weak
		when: BrMenuHideAnnouncement
			send: #onMenuHideRequest:
			to: self;
		when: BrMenuItemsChangedAnnouncement
			send: #onMenuItemsChanged:
			to: self
]

{ #category : #accessing }
BrMenuItemsGroupedElement >> typeBuilder [
	<return: #BrMenuItemTypeBuilder>
	^ typeBuilder ifNil: [ typeBuilder := BrGlamorousMenuItemTypeBuilder new ]
]

{ #category : #accessing }
BrMenuItemsGroupedElement >> typeBuilder: anObject [
	typeBuilder := anObject
]

{ #category : #'event handling' }
BrMenuItemsGroupedElement >> unsubscribeFromMenuModelExcludingUserSubscriptions [
	super unsubscribeFromMenuModelExcludingUserSubscriptions.

	self menuModel announcer unsubscribe: self
]

{ #category : #'private - updating' }
BrMenuItemsGroupedElement >> updateListElement [
	listElement groups: self listGroups
]

{ #category : #'private - updating' }
BrMenuItemsGroupedElement >> visitMenuModel: aMenuModel [
	^ aMenuModel acceptVisitor: self typeBuilder
]
