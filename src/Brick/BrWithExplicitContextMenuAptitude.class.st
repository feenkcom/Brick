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

{ #category : #initialization }
BrWithExplicitContextMenuAptitude >> initializeListeners [
	super initializeListeners.

	self
		when: BrContextMenuShowWish
		do: [ :anEvent | 
			anEvent consumed: true.
			self showDueTo: nil ].
	self
		when: BrContextMenuHideWish
		do: [ :anEvent | 
			anEvent consumed: true.
			self hide ]
]
