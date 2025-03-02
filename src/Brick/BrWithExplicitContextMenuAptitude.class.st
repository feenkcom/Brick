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

	self when: BrContextMenuShowWish do: [ :anEvent | self onShowWish: anEvent ].
	self when: BrContextMenuHideWish do: [ :anEvent | self onHideWish: anEvent ]
]

{ #category : #initialization }
BrWithExplicitContextMenuAptitude >> initializeMenuContainer [
	super initializeMenuContainer.

	menuContainer when: BrContextMenuShowWish do: [ :anEvent | self onShowWish: anEvent ].
	menuContainer when: BrContextMenuHideWish do: [ :anEvent | self onHideWish: anEvent ]
]
