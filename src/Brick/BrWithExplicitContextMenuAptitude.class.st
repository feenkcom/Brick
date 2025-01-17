Class {
	#name : #BrWithExplicitContextMenuAptitude,
	#superclass : #BrWithExplicitMenuAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #initialization }
BrWithExplicitContextMenuAptitude >> initialize [
	super initialize.
	self beContextMenu.
	self withAllExtraEventHandlers.
]
