Class {
	#name : #BrMenu,
	#superclass : #BrMenuModel,
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - notifying' }
BrMenu >> notifyPinRequest [
	self announcer announce: (BrMenuPinRequest new menuModel: self)
]
