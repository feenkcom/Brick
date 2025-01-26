Class {
	#name : #BrGlamorousMenuElementBuilder,
	#superclass : #BrMenuElementBuilder,
	#category : #'Brick-Glamorous-Menu'
}

{ #category : #'as yet unclassified' }
BrGlamorousMenuElementBuilder >> defaultTypeBuilder [
	^ BrGlamorousMenuItemTypeBuilder new
]

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

	^ anElementClass new 
		menuModel: aMenuModel;
		typeBuilder: self typeBuilder
]
