Class {
	#name : #BrGlamorousMenuItemTypeBuilder,
	#superclass : #BrMenuItemTypeBuilder,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #visiting }
BrGlamorousMenuItemTypeBuilder >> visitCoderMenuActionItem: aMenuModel [
	^ GtCoderMenuActionItemElement
]

{ #category : #visiting }
BrGlamorousMenuItemTypeBuilder >> visitMenuActionItem: aMenuModel [
	^ BrMenuActionItemElement
]

{ #category : #visiting }
BrGlamorousMenuItemTypeBuilder >> visitMenuSubmenuItem: aMenuModel [
	^ BrMenuSubmenuItemElement
]
