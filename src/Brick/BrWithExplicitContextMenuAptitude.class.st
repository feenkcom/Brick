Class {
	#name : #BrWithExplicitContextMenuAptitude,
	#superclass : #BrWithExplicitMenuAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'instance creation' }
BrWithExplicitContextMenuAptitude class >> menu: aBlockOrStencil [
	^ self new handleSubmenu: aBlockOrStencil asStencil
]

{ #category : #initialization }
BrWithExplicitContextMenuAptitude >> initialize [
	super initialize.
	self beContextMenu.
	self withAllExtraEventHandlers.
]
