Class {
	#name : #BrMenu,
	#superclass : #BrMenuModel,
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - visibility' }
BrMenu >> hide [
	announcer announce: (BrMenuHideRequest new menuItems: self)
]
