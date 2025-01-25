Class {
	#name : #BrMenuItemTypeBuilder,
	#superclass : #Object,
	#traits : 'TBrMenuModelVisitor',
	#classTraits : 'TBrMenuModelVisitor classTrait',
	#category : #'Brick-Menu - UI'
}

{ #category : #visiting }
BrMenuItemTypeBuilder >> visitMenuModel: aMenuModel [
	^ BlInfiniteItemType invalid
]
