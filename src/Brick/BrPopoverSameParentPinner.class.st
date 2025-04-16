Class {
	#name : #BrPopoverSameParentPinner,
	#superclass : #BrPopoverPinner,
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - actions' }
BrPopoverSameParentPinner >> pinMenuElement: aWidget [
	| aParent |
	aParent := aWidget parent.
	aWidget removeFromParent.
	aParent addChildFirst: aWidget
]
