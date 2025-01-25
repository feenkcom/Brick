Class {
	#name : #BrMenuElementBuilder,
	#superclass : #Object,
	#traits : 'TBrMenuModelVisitor',
	#classTraits : 'TBrMenuModelVisitor classTrait',
	#instVars : [
		'typeBuilder'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuElementBuilder >> defaultTypeBuilder [
	^ BrMenuItemTypeBuilder new
]

{ #category : #accessing }
BrMenuElementBuilder >> typeBuilder [
	<return: #BrMenuItemTypeBuilder>
	^ typeBuilder ifNil: [ typeBuilder := self defaultTypeBuilder ]
]

{ #category : #accessing }
BrMenuElementBuilder >> typeBuilder: anObject [
	typeBuilder := anObject
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuExplicit: aMenuModel [
	| anElement |
	anElement := aMenuModel stencil
			menuModel: aMenuModel;
			asElement.

	anElement addAptitude: (BrMenuHideableAptitude new menuModel: aMenuModel).

	^ anElement
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuExplicitHandle: aMenuModel [
	| anElement |
	anElement := aMenuModel handleStencil asElement.
	anElement addAptitude: (BrMenuHideableAptitude new menuModel: aMenuModel).
	
	"If a user clicks on a handle, we want to close its menu."
	anElement
		when: BlClickEvent
		do: [ :anEvent | anEvent currentTarget fireEvent: BrMenuHideAllWish new ].

	^ anElement
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuItem: aMenuModel [
	"Use type builder to get element class.
	Since menu item instances are supposed to be used
	in infinite layouts (e.g., grouped lists), the type builder is used.
	The type builder returns either
	- BlInfiniteItemType invalid, or 
	- a BlElement class whose instance understands #menuModel:"

	| aType |
	aType := aMenuModel acceptVisitor: self typeBuilder.
	^ aType = BlInfiniteItemType invalid
		ifTrue: [ BrMenuInvalidItemElement new menuModel: aMenuModel ]
		ifFalse: [ aType new menuModel: aMenuModel ]
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuModel: aMenuModel [
	^ BrMenuInvalidItemElement new menuModel: aMenuModel
]
