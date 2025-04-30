Class {
	#name : #BrMenuElementBuilder,
	#superclass : #Object,
	#traits : 'TBrMenuModelVisitor + TBrMenuLabelModelVisitor',
	#classTraits : 'TBrMenuModelVisitor classTrait + TBrMenuLabelModelVisitor classTrait',
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
BrMenuElementBuilder >> visitGivenModel: aMenuModel [
	^ aMenuModel acceptVisitor: self
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuDecoratingModel: aDecoratingMenuModel [
	| anOriginalMenuModel anElement |
	anOriginalMenuModel := aDecoratingMenuModel menuModel.
	anOriginalMenuModel ifNil: [ 
		^ self visitMenuModel: aDecoratingMenuModel ].
	
	anElement := anOriginalMenuModel acceptVisitor: self.
	
	aDecoratingMenuModel decorator ifNil: [ ^ anElement ].
	aDecoratingMenuModel decorator cull: anElement.
	
	^ anElement
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuExplicit: aMenuModel [
	| anElement |
	anElement := aMenuModel stencil
			menuModel: aMenuModel;
			asElement.

	aMenuModel id ifNotNil: [ :anId | anElement id: anId ].

	anElement addAptitude: (BrPopoverHideableAptitude new menuModel: aMenuModel).

	^ anElement
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuExplicitHandle: aMenuModel [
	| anElement |
	anElement := aMenuModel handleStencil asElement.
	anElement addAptitude: (BrPopoverHideableAptitude new menuModel: aMenuModel).
	
	"If a user clicks on a handle, we want to close its menu."
	anElement
		when: BlClickEvent
		do: [ :anEvent | anEvent currentTarget fireEvent: BrPopoverHideAllWish new ].

	^ anElement
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuExplicitItem: aMenuModel [
	| anElement |
	anElement := aMenuModel stencil
			menuModel: aMenuModel;
			asElement.
			
	aMenuModel id ifNotNil: [ :anId | anElement id: anId ].

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

	| aType anElement |
	aType := aMenuModel acceptVisitor: self typeBuilder.
	anElement := self typeBuilder buildElementFromItemType: aType.
	^ anElement menuModel: aMenuModel
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuLabelModel: aLabelModel [
	| aType anElement |
	aType := aLabelModel acceptVisitor: self typeBuilder.
	anElement := self typeBuilder buildElementFromItemType: aType.
	^ anElement labelModel: aLabelModel
]

{ #category : #visiting }
BrMenuElementBuilder >> visitMenuModel: aMenuModel [
	^ BrMenuInvalidItemElement new menuModel: aMenuModel
]
