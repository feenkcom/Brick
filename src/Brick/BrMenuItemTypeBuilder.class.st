Class {
	#name : #BrMenuItemTypeBuilder,
	#superclass : #Object,
	#traits : 'TBrMenuModelVisitor',
	#classTraits : 'TBrMenuModelVisitor classTrait',
	#category : #'Brick-Menu - UI'
}

{ #category : #visiting }
BrMenuItemTypeBuilder >> visitMenuDecoratingModel: aMenuModel [
	| anOriginalMenuModel |
	anOriginalMenuModel := aMenuModel menuModel.
	anOriginalMenuModel ifNil: [ ^ self visitMenuModel: aMenuModel ].
	
	^ anOriginalMenuModel acceptVisitor: self
]

{ #category : #visiting }
BrMenuItemTypeBuilder >> visitMenuModel: aMenuModel [
	^ BlInfiniteItemType invalid
]
