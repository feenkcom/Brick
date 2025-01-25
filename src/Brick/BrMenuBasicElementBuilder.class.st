Class {
	#name : #BrMenuBasicElementBuilder,
	#superclass : #Object,
	#traits : 'TBrMenuModelVisitor',
	#classTraits : 'TBrMenuModelVisitor classTrait',
	#category : #'Brick-Menu - UI'
}

{ #category : #visiting }
BrMenuBasicElementBuilder >> visitMenuModel: aMenuModel [
	^ BlElement new
		background: Color paleYellow;
		size: 120 @ 30
]
