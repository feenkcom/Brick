Class {
	#name : #BrMenuSpaceRootPinner,
	#superclass : #BrMenuPinner,
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - actions' }
BrMenuSpaceRootPinner >> pinMenuElement: aWidget [
	| aPosition aCurrentParent aNewParent willBeSameParent |
	aWidget isAttachedToSceneGraph ifFalse: [ ^ self ].
	aPosition := aWidget positionInSpace.
	aCurrentParent := aWidget parent.
	aNewParent := aWidget topMostParent.
	willBeSameParent := aCurrentParent parent = aNewParent.
	aWidget removeFromParent.
	willBeSameParent
		ifTrue: [ aNewParent addChild: aWidget before: aCurrentParent ]
		ifFalse: [ aNewParent addChild: aWidget ].
	aWidget relocate: aPosition
]
