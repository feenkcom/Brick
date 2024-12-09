Class {
	#name : #BrMenuSameParentPinner,
	#superclass : #BrMenuPinner,
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - actions' }
BrMenuSameParentPinner >> pinMenuElement: aWidget [
	| aParent |
	aParent := aWidget parent.
	aWidget removeFromParent.
	aParent addChildFirst: aWidget
]
