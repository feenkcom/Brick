Class {
	#name : #BrMenuSubmenuItem,
	#superclass : #BrMenuItem,
	#instVars : [
		'submenu'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - converting' }
BrMenuSubmenuItem >> asElement [
	^ BrMenuSubmenuItemElement new menuModel: self
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
	<return: #BrMenuItems>
	^ submenu
]

{ #category : #'api - submenu' }
BrMenuSubmenuItem >> submenu: aBrMenuItems [
	aBrMenuItems parent: self.
	submenu := aBrMenuItems
]

{ #category : #'api - submenu' }
BrMenuSubmenuItem >> submenuItem: aMenuItem [
	self submenu addItem: aMenuItem
]
