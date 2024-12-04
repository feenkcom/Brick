Class {
	#name : #BrMenuSubmenuItem,
	#superclass : #BrMenuLabeledItem,
	#instVars : [
		'submenu'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - converting' }
BrMenuSubmenuItem >> elementType [
	^ BrMenuSubmenuItemElement
]

{ #category : #'gt - extensions' }
BrMenuSubmenuItem >> gtItemChildren [
	^ self submenu gtItemChildren
]

{ #category : #initialization }
BrMenuSubmenuItem >> initialize [
	super initialize.
	submenu := BrMenuItems new parent: self
]

{ #category : #'api - submenu' }
BrMenuSubmenuItem >> items [
	<return: #BrMenuItems>
	^ self submenu items
]

{ #category : #'event handling' }
BrMenuSubmenuItem >> onSelectionChanged [
	super onSelectionChanged.
	
	self isSelected ifFalse: [ 
		self submenu hide ].
		
	"Note: show action happens in BrMenuSubmenuItemElement>>#onSelectionChanged:.
	It looks confusing."
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
