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
	self announcer announce: (BrMenuPinRequestAnnouncement new menuModel: self)
]

{ #category : #'api - navigation' }
BrMenu >> requestNavigateHere [
	"Subclasses may perform actions on navigate in menus.
	Must be executed from a UI process."

	super requestNavigateHere.
	self navigate
]
