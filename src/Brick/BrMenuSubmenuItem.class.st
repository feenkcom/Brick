Class {
	#name : #BrMenuSubmenuItem,
	#superclass : #BrMenuItem,
	#instVars : [
		'submenu'
	],
	#category : #'Brick-Menu'
}

{ #category : #'gt - extensions' }
BrMenuSubmenuItem >> gtItemChildren [
	^ self submenu items
]

{ #category : #'gt - extensions' }
BrMenuSubmenuItem >> gtSubmenuFor: aView [
	<gtView>
	submenu ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Menu items';
		object: [ self submenu ];
		view: #gtItemsFor:
]

{ #category : #initialization }
BrMenuSubmenuItem >> initialize [
	super initialize.
	submenu := BrMenuItems new parent: self
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
