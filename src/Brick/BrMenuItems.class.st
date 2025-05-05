Class {
	#name : #BrMenuItems,
	#superclass : #BrMenu,
	#instVars : [
		'items',
		'selectedItem',
		'groups',
		'elementType'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenuItems >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuItems: self
]

{ #category : #'add / remove' }
BrMenuItems >> addItem: aMenuItem [
	groups := nil.
	aMenuItem parent: self.
	self items add: aMenuItem.
	
	aMenuItem isSelected ifTrue: [
		self selectedItem: aMenuItem ].

	aMenuItem announcer weak
		when: BrMenuItemSelectionChangedAnnouncement
		send: #onMenuItemSelection:
		to: self.
		
	self announcer announce: (BrMenuItemsChangedAnnouncement new menuModel: self)
]

{ #category : #'add / remove' }
BrMenuItems >> addItemIcon: anIconStencil label: aText action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem icon: anIconStencil label: aText.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemIcon: anIconStencil label: aText preview: aPreviewText action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem icon: anIconStencil label: aText preview: aPreviewText.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemIcon: anIconStencil label: aText preview: aPreviewText shortcut: aShortcutString action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem icon: anIconStencil label: aText preview: aPreviewText shortcut: aShortcutString.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemIcon: anIconStencil label: aText preview: aPreviewText shortcut: aShortcutString submenu: aSubmenu [
	| aMenuItem |
	aMenuItem := BrMenuSubmenuItem new.
	aMenuItem
		icon: anIconStencil 
		label: aText 
		preview: aPreviewText 
		shortcut: aShortcutString.
	aMenuItem submenu: aSubmenu.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemIcon: anIconStencil label: aLabelString shortcut: aShortcutString action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem icon: anIconStencil label: aLabelString shortcut: aShortcutString.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemIcon: anIconStencil label: aText shortcut: aShortcutString submenu: aSubmenu [
	| aMenuItem |
	aMenuItem := BrMenuSubmenuItem new.
	aMenuItem icon: anIconStencil label: aText shortcut: aShortcutString.
	aMenuItem submenu: aSubmenu.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemIcon: anIconStencil label: aText submenu: aSubmenu [
	| aMenuItem |
	aMenuItem := BrMenuSubmenuItem new.
	aMenuItem icon: anIconStencil label: aText.
	aMenuItem submenu: aSubmenu.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemId: anId icon: anIconStencil label: aLabelString shortcut: aShortcutString action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem id: anId.
	aMenuItem icon: anIconStencil label: aLabelString shortcut: aShortcutString.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemId: anId label: aLabelString action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem id: anId.
	aMenuItem label: aLabelString.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemId: anId label: aText preview: aPreviewText action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem id: anId.
	aMenuItem label: aText preview: aPreviewText.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemId: anId label: aLabelString shortcut: aShortcutString action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem id: anId.
	aMenuItem label: aLabelString shortcut: aShortcutString.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemId: anId stencil: aStencil [
	| aMenuItem |
	aMenuItem := BrMenuExplicitItem new.
	aMenuItem id: anId.
	aMenuItem stencil: aStencil.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemLabel: aText action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem label: aText.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemLabel: aText preview: aPreviewText action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem label: aText preview: aPreviewText.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemLabel: aText preview: aPreviewText shortcut: aShortcutString action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem label: aText preview: aPreviewText shortcut: aShortcutString.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemLabel: aText preview: aPreviewText shortcut: aShortcutString submenu: aSubmenu [
	| aMenuItem |
	aMenuItem := BrMenuSubmenuItem new.
	aMenuItem 
		label: aText 
		preview: aPreviewText 
		shortcut: aShortcutString.
	aMenuItem submenu: aSubmenu.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemLabel: aLabelString shortcut: aShortcutString action: anAction [
	| aMenuItem |
	aMenuItem := BrMenuActionItem new.
	aMenuItem label: aLabelString shortcut: aShortcutString.
	aMenuItem action: anAction.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemLabel: aText shortcut: aShortcutString submenu: aSubmenu [
	| aMenuItem |
	aMenuItem := BrMenuSubmenuItem new.
	aMenuItem label: aText shortcut: aShortcutString.
	aMenuItem submenu: aSubmenu.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemLabel: aText submenu: aSubmenu [
	| aMenuItem |
	aMenuItem := BrMenuSubmenuItem new.
	aMenuItem label: aText.
	aMenuItem submenu: aSubmenu.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItemStencil: aStencil [
	| aMenuItem |
	aMenuItem := BrMenuExplicitItem new.
	aMenuItem stencil: aStencil.
	self addItem: aMenuItem
]

{ #category : #'add / remove' }
BrMenuItems >> addItems: aCollection [
	aCollection do: [ :each | self addItem: each ]
]

{ #category : #'api - converting' }
BrMenuItems >> asTreeElement [
	"Not a production code.
	For exploration purposes only."

	| anElement |
	anElement := BrSimpleTree new.
	anElement
		fitContentLimited;
		stencil: [ :aRowValue :anIndex :aListWidget | aRowValue asElement ];
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		padding: (BlInsets all: 5);
		border: (BlBorder paint: Color veryLightGray width: 1);
		background: anElement theme default contentBackgroundColor;
		items: self groups lazy: #items;
		expandUpTo: 2;
		addAptitude: (BrPopoverHideableAptitude new menuModel: self).

	^ anElement
]

{ #category : #'api - initialization' }
BrMenuItems >> beListElementType [
	self elementType: BrMenuItemsListElement
]

{ #category : #'api - selection' }
BrMenuItems >> deselect [
	selectedItem ifNotNil: #deselect.
	selectedItem := nil
]

{ #category : #'api - selection' }
BrMenuItems >> deselectedItem: aMenuItem [
	self assert: [ aMenuItem isSelected not ].
	selectedItem == aMenuItem ifFalse: [ ^ self ].

	selectedItem := nil
]

{ #category : #'api - converting' }
BrMenuItems >> elementType [
	^ elementType
]

{ #category : #'api - initialization' }
BrMenuItems >> elementType: aClass [
	"Set a class that is kind of `BlElement`.
	The will be used to create menu elements, displaying this menu."

	elementType := aClass
]

{ #category : #'api - grouping' }
BrMenuItems >> groups [
	<return: #Array of: #BrMenuItemGroup>
	| aDictionary |
	groups ifNotNil: [ ^ groups ].
	aDictionary := Dictionary new.
	self items
		do: [ :eachItem | 
			aDictionary
				at: eachItem group id
				ifPresent: [ :aGroup | aGroup addItem: eachItem ]
				ifAbsentPut: [ BrMenuItemGroup new addItem: eachItem ] ].

	groups := aDictionary values sort: [ :a :b | a priority < b priority ].
	^ groups
]

{ #category : #'gt - extensions' }
BrMenuItems >> gtItemChildren [
	^ self items
]

{ #category : #'gt - extensions' }
BrMenuItems >> gtRootItems [
	^ self items
]

{ #category : #'api - visibility' }
BrMenuItems >> hide [
	"Hide corresponding menu element.
	Note: This method can be called only from the UI process."

	"Deselect any menu item."
	self deselect.
	
	super hide.
]

{ #category : #initialization }
BrMenuItems >> initialize [
	super initialize.
	items := OrderedCollection new
]

{ #category : #accessing }
BrMenuItems >> items [
	^ items
]

{ #category : #'add / remove' }
BrMenuItems >> items: aCollection [
	groups := nil.
	selectedItem := nil.
	aCollection do: [ :eachItem | eachItem parent: self ].
	self items removeAll.
	self items addAll: aCollection.
	
	aCollection do: [ :eachItem |
		eachItem isSelected ifTrue: [
			self selectedItem: aCollection ] ].

	aCollection do: [ :eachItem |
		eachItem announcer weak
			when: BrMenuItemSelectionChangedAnnouncement
			send: #onMenuItemSelection:
			to: self ].
	
	self announcer announce: (BrMenuItemsChangedAnnouncement new menuModel: self)
]

{ #category : #accessing }
BrMenuItems >> itemsCount [
	^ self items size
]

{ #category : #accessing }
BrMenuItems >> menuType [
	^ self class
]

{ #category : #'event handling' }
BrMenuItems >> onMenuItemSelection: anAnnouncement [
	anAnnouncement menuModel isSelected
		ifTrue: [ self selectedItem: anAnnouncement menuModel ]
		ifFalse: [ self deselectedItem: anAnnouncement menuModel ]
]

{ #category : #printing }
BrMenuItems >> printOn: aStream [
	super printOn: aStream.

	aStream
		space;
		nextPut: $[;
		print: self itemsCount;
		space;
		nextPutAll: ('item' asPluralBasedOn: self itemsCount);
		nextPut: $]
]

{ #category : #accessing }
BrMenuItems >> selectedItem [
	^ selectedItem
]

{ #category : #'api - selection' }
BrMenuItems >> selectedItem: aMenuItem [
	self assert: [ aMenuItem isSelected ].
	selectedItem == aMenuItem ifTrue: [ ^ self ].

	selectedItem ifNotNil: #deselect.
	selectedItem := aMenuItem
]
