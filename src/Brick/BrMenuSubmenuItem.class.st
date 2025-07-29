Class {
	#name : #BrMenuSubmenuItem,
	#superclass : #BrMenuLabeledItem,
	#instVars : [
		'submenu',
		'action',
		'hideOnClick',
		'actionWithModifiers'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenuSubmenuItem >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuSubmenuItem: self
]

{ #category : #'api - action' }
BrMenuSubmenuItem >> action [
	^ action
]

{ #category : #'api - action' }
BrMenuSubmenuItem >> action: aBlock [
	"Set a block that is evaluated on click events.
	It has the following arguments: [ :anElement :aButtonModel :anEvent | ]"

	action := aBlock
]

{ #category : #'api - action' }
BrMenuSubmenuItem >> actionWithModifiers [
	^ actionWithModifiers
]

{ #category : #'api - action' }
BrMenuSubmenuItem >> actionWithModifiers: aBlock [
	"Set a block that is evaluated on click events.
	It has the following arguments: [ :anElement :aButtonModel :anEvent | ]"

	actionWithModifiers := aBlock
]

{ #category : #'api - action' }
BrMenuSubmenuItem >> bePinSubmenuAction [
	self action: [ :anElement :aButtonModel :anEvent | self notifyPinRequest ]
]

{ #category : #accessing }
BrMenuSubmenuItem >> definition: aBlock [
	super definition: aBlock.
	self actionWithModifiers: [ :anElement :aButtonModel :anEvent |
		self definition ifNotNil: [ :aDefinition |
			anElement phlow spawnObject: aDefinition ] ]
]

{ #category : #'gt - extensions' }
BrMenuSubmenuItem >> gtItemChildren [
	^ self submenu gtItemChildren
]

{ #category : #'api - action' }
BrMenuSubmenuItem >> hideOnClick [
	<return: #Boolean>
	^ hideOnClick ifNil: [ false ]
]

{ #category : #'api - action' }
BrMenuSubmenuItem >> hideOnClick: aBoolean [
	hideOnClick := aBoolean
]

{ #category : #initialization }
BrMenuSubmenuItem >> initialize [
	super initialize.
	action := [ :anElement :aButtonModel :anEvent |  ].
	actionWithModifiers := [ :anElement :aButtonModel :anEvent | ].
	hideOnClick := false.
	submenu := BrMenuItems new parent: self
]

{ #category : #'api - submenu' }
BrMenuSubmenuItem >> items [
	<return: #BrMenuItems>
	^ self submenu items
]

{ #category : #'event handling' }
BrMenuSubmenuItem >> notifyPinRequest [
	self submenu notifyPinRequest
]

{ #category : #'event handling' }
BrMenuSubmenuItem >> onSelectionChanged [
	super onSelectionChanged.
	
	self isSelected ifFalse: [ 
		self submenu hide ].
		
	"Note: show action happens in BrMenuSubmenuItemElement>>#onSelectionChanged:.
	It looks confusing."
]

{ #category : #'api - navigation' }
BrMenuSubmenuItem >> requestNavigateToSubmenu [
	super requestNavigateToSubmenu.
	
	self select.
	self isSelected ifTrue: [ 
		self submenu navigate ].
]

{ #category : #'api - submenu' }
BrMenuSubmenuItem >> submenu [
	<return: #BrMenu>
	^ submenu
]

{ #category : #'api - submenu' }
BrMenuSubmenuItem >> submenu: aBrMenu [
	aBrMenu parent: self.
	submenu := aBrMenu
]

{ #category : #'api - submenu' }
BrMenuSubmenuItem >> submenuItem: aMenuItem [
	self submenu addItem: aMenuItem
]
