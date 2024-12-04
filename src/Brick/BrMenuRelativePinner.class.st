Class {
	#name : #BrMenuRelativePinner,
	#superclass : #BrMenuPinner,
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - actions' }
BrMenuRelativePinner >> pinMenuElement: aWidget [
	| aParent |
	aParent := aWidget parent.
	aWidget removeFromParent.
	aParent addChildFirst: aWidget
]
