Class {
	#name : #BrMenuItemTypeBuilder,
	#superclass : #Object,
	#traits : 'TBrMenuModelVisitor + TBrMenuLabelModelVisitor',
	#classTraits : 'TBrMenuModelVisitor classTrait + TBrMenuLabelModelVisitor classTrait',
	#category : #'Brick-Menu - UI'
}

{ #category : #'api - instance creation' }
BrMenuItemTypeBuilder >> buildElementFromItemType: anItemType [
	"A helper method to create elements from infinite item types.
	aType is kind of BlInfiniteItemType."
	<return: #BlElement>

	anItemType = BlInfiniteItemType invalid
		ifTrue: [ ^ BrMenuInvalidItemElement new ].
		
	(anItemType isClass and: [ anItemType inheritsFrom: BlElement ])
		ifTrue: [ ^ anItemType new ].
		
	(anItemType isKindOf: BrMenuElementClassType)
		ifTrue: [ ^ anItemType createElement ].
		
	(anItemType isKindOf: BrMenuLabeledElementClassType)
		ifTrue: [ ^ anItemType createElement ].
		
	^ BrMenuInvalidItemElement new
]

{ #category : #private }
BrMenuItemTypeBuilder >> decorateType: aType [
	"Subclasses may add type decorator"

	
]

{ #category : #visiting }
BrMenuItemTypeBuilder >> visitMenuDecoratingModel: aMenuModel [
	| anOriginalMenuModel |
	anOriginalMenuModel := aMenuModel menuModel.
	anOriginalMenuModel ifNil: [ ^ self visitMenuModel: aMenuModel ].
	
	^ anOriginalMenuModel acceptVisitor: self
]

{ #category : #visiting }
BrMenuItemTypeBuilder >> visitMenuExplicitItem: aMenuModel [
	| aType |
	aType := BrMenuElementClassType new elementClass: BrMenuExplicitItemElement.
	self decorateType: aType.
	^ aType
]

{ #category : #visiting }
BrMenuItemTypeBuilder >> visitMenuLabelModel: aLabelModel [
	^ BlInfiniteItemType invalid
]

{ #category : #visiting }
BrMenuItemTypeBuilder >> visitMenuLabeledItem: aMenuModel withElementClass: anElementClass [
	| aLabelType aType |
	aLabelType := aMenuModel labelModel acceptVisitor: self.

	aLabelType class = BrMenuElementClassType ifFalse: [ 
		^ self visitMenuLabeledItem: aMenuModel ].
	
	aType := BrMenuLabeledElementClassType new 
		elementClass: anElementClass;
		labelElementClass: aLabelType elementClass.
		
	self decorateType: aType.
	
	^ aType
]

{ #category : #visiting }
BrMenuItemTypeBuilder >> visitMenuModel: aMenuModel [
	^ BlInfiniteItemType invalid
]
