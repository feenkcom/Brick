Class {
	#name : #BrWithExplicitTooltipAptitude,
	#superclass : #BrWithExplicitPopoverAptitude,
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
		- a KMKeyCombination instance, or
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
		- a KMKeyCombination instance, or
		- nil"

	| anAptitude |
	anAptitude := self new text: aLabelString shortcut: aShortcutString.
	anAptitude preferredChildWeight: 1.0.
	anAptitudeBlock value: anAptitude.
	^ anAptitude
]

{ #category : #'event handling' }
BrWithExplicitTooltipAptitude >> consumeClickedOutsideMouseUpEvent: anEvent [
	"Tooltips do not consume click outside events since the event may trigger other actions.
	For example:
		- open a dropdown
		- open a context menu
		- run a button action."
]

{ #category : #initialization }
BrWithExplicitTooltipAptitude >> defaultMouseEventHandler [
	^ self newMouseHoverEventHandler
]

{ #category : #'api - initialization' }
BrWithExplicitTooltipAptitude >> hideDelay: aDuration [
	"Note: It assumes that the mouse event handler is the tooltip event handler."

	self mouseEventHandler hideDelay: aDuration
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

{ #category : #'private - instance creation' }
BrWithExplicitTooltipAptitude >> newMenuModelWithLabel: aLabelString shortcut: aShortcutString [
	^ aShortcutString
		ifNotNil: [ BrMenuLabelItem new
				label: aLabelString value asString
				shortcut: aShortcutString value asString ]
		ifNil: [ BrMenuLabelItem new label: aLabelString value asString ]
]

{ #category : #'api - initialization' }
BrWithExplicitTooltipAptitude >> showDelay: aDuration [
	"Note: It assumes that the mouse event handler is the tooltip event handler."

	self mouseEventHandler showDelay: aDuration
]

{ #category : #'api - menu' }
BrWithExplicitTooltipAptitude >> text: aLabelString [
	self text: aLabelString shortcut: nil
]

{ #category : #'api - menu' }
BrWithExplicitTooltipAptitude >> text: aLabelString shortcut: aShortcutString [
	"Keymap can be:
		- a text, e.g., 'F5',
		- a BlKeyCombination instance, or
		- a KMKeyCombination instance, or
		- nil"

	self
		handleSubmenu: [ self newMenuModelWithLabel: aLabelString shortcut: aShortcutString ]
]

{ #category : #'api - initialization' }
BrWithExplicitTooltipAptitude >> withDefaultHandle [
	self withTooltipHandle
]
