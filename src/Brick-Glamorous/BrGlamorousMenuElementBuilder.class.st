Class {
	#name : #BrGlamorousMenuElementBuilder,
	#superclass : #BrMenuElementBuilder,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #visiting }
BrGlamorousMenuElementBuilder >> visitMenuActionItem: aMenuModel [
	^ BrMenuActionItemElement new menuModel: aMenuModel
]

{ #category : #visiting }
BrGlamorousMenuElementBuilder >> visitMenuItems: aMenuModel [
	| anElementClass |
	anElementClass := aMenuModel elementType
			ifNil: [ aMenuModel groups size > 1
					ifFalse: [ BrMenuItemsListElement ]
					ifTrue: [ BrMenuItemsGroupedElement ] ].

	^ anElementClass new menuModel: aMenuModel
]

{ #category : #visiting }
BrGlamorousMenuElementBuilder >> visitMenuModel: aMenuModel [
	^ BrLabel new
		text: aMenuModel gtDisplayText;
		aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors errorBackgroundColor)
]

{ #category : #visiting }
BrGlamorousMenuElementBuilder >> visitMenuSubmenuItem: aMenuModel [
	^ BrMenuSubmenuItemElement new menuModel: aMenuModel
]
