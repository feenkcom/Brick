Class {
	#name : #BrMenuSpaceRootPinner,
	#superclass : #BrMenuPinner,
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - actions' }
BrMenuSpaceRootPinner >> pinMenuElement: aWidget [
	| aPosition aParent aSpace isParentInSpaceRoot |
	aWidget isAttachedToSceneGraph ifFalse: [ ^ self ].
	aPosition := aWidget positionInSpace.
	aParent := aWidget parent.
	aSpace := aWidget space.
	isParentInSpaceRoot := aParent parent = aSpace root.
	aWidget removeFromParent.
	isParentInSpaceRoot
		ifTrue: [ aSpace root addChild: aWidget before: aParent ]
		ifFalse: [ aSpace root addChild: aWidget ].
	aWidget relocate: aPosition
]
