Class {
	#name : #BrMenu,
	#superclass : #BrMenuModel,
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenu >> acceptVisitor: aVisitor [
	^ aVisitor visitMenu: self
]

{ #category : #'api - notifying' }
BrMenu >> notifyPinRequest [
	self announcer announce: (BrMenuPinRequest new menuModel: self)
]
