Class {
	#name : #BrGlamorousMenuItemTypeBuilder,
	#superclass : #BrMenuItemTypeBuilder,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #visiting }
BrGlamorousMenuItemTypeBuilder >> visitCoderMenuActionItem: aMenuModel [
	^ self
		visitMenuLabeledItem: aMenuModel
		withElementClass: GtCoderMenuActionItemElement
]

{ #category : #visiting }
BrGlamorousMenuItemTypeBuilder >> visitMenuActionItem: aMenuModel [
	^ self
		visitMenuLabeledItem: aMenuModel
		withElementClass: BrMenuActionItemElement
]

{ #category : #visiting }
BrGlamorousMenuItemTypeBuilder >> visitMenuIconTextLabelModel: aLabelModel [
	^ BrMenuElementClassType new elementClass: BrMenuIconTextLabelElement
]

{ #category : #visiting }
BrGlamorousMenuItemTypeBuilder >> visitMenuLabelItem: aMenuModel [
	^ self
		visitMenuLabeledItem: aMenuModel
		withElementClass: BrMenuLabelItemElement
]

{ #category : #visiting }
BrGlamorousMenuItemTypeBuilder >> visitMenuSubmenuItem: aMenuModel [
	^ self
		visitMenuLabeledItem: aMenuModel
		withElementClass: BrMenuSubmenuItemElement
]

{ #category : #visiting }
BrGlamorousMenuItemTypeBuilder >> visitMenuTextLabelModel: aLabelModel [
	^ BrMenuElementClassType new elementClass: BrMenuTextLabelElement
]
