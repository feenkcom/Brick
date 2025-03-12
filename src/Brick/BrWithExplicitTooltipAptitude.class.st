Class {
	#name : #BrWithExplicitTooltipAptitude,
	#superclass : #BrWithExplicitMenuAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'instace creation' }
BrWithExplicitTooltipAptitude class >> content: aBlockOrStencil [
	^ self menu: (BrMenuExplicit new stencil: aBlockOrStencil)
]

{ #category : #'instace creation' }
BrWithExplicitTooltipAptitude class >> menu: aBlockOrStencil [
	"Set a stencil that creates a menu model.
	The stencil returns a BrMenu instance.
	A default menu handle is used."
	
	^ self new handleSubmenu: aBlockOrStencil asStencil
]

{ #category : #'instace creation' }
BrWithExplicitTooltipAptitude class >> menu: aBlockOrStencil do: anAptitudeBlock [
	"Set a stencil that creates a menu model.
	The stencil returns a BrMenu instance.
	A default menu handle is used."

	| anAptitude |
	anAptitude := self menu: aBlockOrStencil.
	anAptitudeBlock value: anAptitude.
	^ anAptitude
]

{ #category : #initialization }
BrWithExplicitTooltipAptitude >> defaultMouseEventHandler [
	^ self newTooltipEventHandler
]

{ #category : #initialization }
BrWithExplicitTooltipAptitude >> initialize [
	super initialize.
	self beTooltipMenu.
	self withAllExtraEventHandlers.
]

{ #category : #initialization }
BrWithExplicitTooltipAptitude >> initializeListeners [
	super initializeListeners.

	self when: BrTooltipShowWish do: [ :anEvent | self onShowWish: anEvent ].
	self when: BrTooltipHideWish do: [ :anEvent | self onHideWish: anEvent ]
]

{ #category : #initialization }
BrWithExplicitTooltipAptitude >> initializeMenuContainer [
	super initializeMenuContainer.

	menuContainer when: BrTooltipShowWish do: [ :anEvent | self onShowWish: anEvent ].
	menuContainer when: BrTooltipHideWish do: [ :anEvent | self onHideWish: anEvent ]
]
