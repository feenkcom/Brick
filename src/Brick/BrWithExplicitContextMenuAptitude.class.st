Class {
	#name : #BrWithExplicitContextMenuAptitude,
	#superclass : #BrWithExplicitPopoverAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'instance creation' }
BrWithExplicitContextMenuAptitude class >> content: aBlockOrStencil [
	^ self menu: (BrMenuExplicit new stencil: aBlockOrStencil)
]

{ #category : #'instance creation' }
BrWithExplicitContextMenuAptitude class >> items: aCollectionOfAssociations [
	"Create a context menu with items with given labels and actions.
	Items is a collection of associations: 'item label' -> [ :anElement :aButtonModel :anEvent | 'item action' ]."

	^ self items: aCollectionOfAssociations do: [ :anAptitude |  ]
]

{ #category : #'instance creation' }
BrWithExplicitContextMenuAptitude class >> items: aCollectionOfAssociations do: anAptitudeBlock [
	"Create a context menu with items with given labels and actions.
	Items is a collection of associations: 'item label' -> [ :anElement :aButtonModel :anEvent | 'item action' ]."

	^ self
		menu: [ | aMenuItems |
			aMenuItems := BrMenuItems new.
			aCollectionOfAssociations value
				do: [ :eachAssoc | aMenuItems addItemLabel: eachAssoc key action: eachAssoc value ].
			aMenuItems ]
		do: anAptitudeBlock
]

{ #category : #'instance creation' }
BrWithExplicitContextMenuAptitude class >> itemsWithAnchorActions: aCollectionOfAssociationsOrBlock [
	"Create a context menu with items with given labels and actions.
	Items is a collection of associations: 'item label' -> [ :anAchorElement :anElement :aButtonModel :anEvent | 'item action' ]."

	^ self itemsWithAnchorActions: aCollectionOfAssociationsOrBlock do: [ :anAptitude |  ]
]

{ #category : #'instance creation' }
BrWithExplicitContextMenuAptitude class >> itemsWithAnchorActions: aCollectionOfAssociationsOrBlock do: anAptitudeBlock [
	"Create a context menu with items with given labels and actions.
	Items is a collection of associations: 'item label' -> [ :anAnchorElement :anElement :aButtonModel :anEvent | 'item action' ]."

	^ self
		menu: [ | aMenuItems |
			aMenuItems := BrMenuItems new.
			aCollectionOfAssociationsOrBlock value
				do: [ :eachAssoc | aMenuItems 
					addItemLabel: eachAssoc key 
					action: [ :anElement :aButtonModel :anEvent | 
						eachAssoc value cull: anElement anchor cull: anElement cull: aButtonModel cull: anEvent ] ].
			aMenuItems ]
		do: anAptitudeBlock
]

{ #category : #'instance creation' }
BrWithExplicitContextMenuAptitude class >> menu: aBlockOrStencil [
	"Set a stencil that creates a menu model.
	The stencil returns a BrMenu instance.
	A default menu handle is used."
	
	^ self new handleSubmenu: aBlockOrStencil asStencil
]

{ #category : #'instance creation' }
BrWithExplicitContextMenuAptitude class >> menu: aBlockOrStencil do: anAptitudeBlock [
	"Set a stencil that creates a menu model.
	The stencil returns a BrMenu instance.
	A default menu handle is used."

	| anAptitude |
	anAptitude := self menu: aBlockOrStencil.
	anAptitudeBlock value: anAptitude.
	^ anAptitude
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
