Class {
	#name : #BrWithExplicitTooltipAptitude,
	#superclass : #BrWithExplicitMenuAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'instance creation' }
BrWithExplicitTooltipAptitude class >> content: aBlockOrStencil [
	^ self menu: (BrMenuExplicit new stencil: aBlockOrStencil)
]

{ #category : #'instance creation' }
BrWithExplicitTooltipAptitude class >> menu: aBlockOrStencil [
	"Set a stencil that creates a menu model.
	The stencil returns a BrMenu instance.
	A default menu handle is used."
	
	^ self new handleSubmenu: aBlockOrStencil asStencil
]

{ #category : #'instance creation' }
BrWithExplicitTooltipAptitude class >> menu: aBlockOrStencil do: anAptitudeBlock [
	"Set a stencil that creates a menu model.
	The stencil returns a BrMenu instance.
	A default menu handle is used."

	| anAptitude |
	anAptitude := self menu: aBlockOrStencil.
	anAptitudeBlock value: anAptitude.
	^ anAptitude
]

{ #category : #'instance creation' }
BrWithExplicitTooltipAptitude class >> text: aLabelString [
	^ self text: aLabelString shortcut: nil
]

{ #category : #'instance creation' }
BrWithExplicitTooltipAptitude class >> text: aLabelString do: anAptitudeBlock [
	^ self
		text: aLabelString
		shortcut: nil
		do: anAptitudeBlock
]

{ #category : #'instance creation' }
BrWithExplicitTooltipAptitude class >> text: aLabelString shortcut: aShortcutString [
	"Keymap can be:
		- a text, e.g., 'F5',
		- a BlKeyCombination instance, or
		- nil"

	^ self
		text: aLabelString
		shortcut: aShortcutString
		do: [ :anAptitude |  ]
]

{ #category : #'instance creation' }
BrWithExplicitTooltipAptitude class >> text: aLabelString shortcut: aShortcutString do: anAptitudeBlock [
	"Keymap can be:
		- a text, e.g., 'F5',
		- a BlKeyCombination instance, or
		- nil"

	^ self
		menu: [ aShortcutString
				ifNotNil: [ BrMenuLabelItem new label: aLabelString shortcut: aShortcutString asString ]
				ifNil: [ BrMenuLabelItem new label: aLabelString ] ]
		do: [ :anAptitude | 
			anAptitude preferredChildWeight: 1.0.
			anAptitudeBlock value: anAptitude ]
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

{ #category : #'api - initialization' }
BrWithExplicitTooltipAptitude >> withDefaultHandle [
	self withTooltipHandle
]
