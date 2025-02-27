Class {
	#name : #BrWithExplicitDropdownAptitude,
	#superclass : #BrWithExplicitMenuAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'instance creation' }
BrWithExplicitDropdownAptitude class >> handle: aHandleStencil content: aContentStencil [
	"Create a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aContentStencil is a stencil that creates a BlElement instance."

	^ self new handle: aHandleStencil content: aContentStencil
]

{ #category : #'instance creation' }
BrWithExplicitDropdownAptitude class >> handle: aHandleStencil content: aContentStencil containerDo: aContainerBlock [
	"Create a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aContentStencil is a stencil that creates a BlElement instance."

	^ self new
		handle: aHandleStencil content: aContentStencil;
		menuContainerDo: aContainerBlock
]

{ #category : #'instance creation' }
BrWithExplicitDropdownAptitude class >> handle: aHandleStencil content: aContentStencil do: anAptitudeBlock [
	"Create a menu with a handle element and with an explicit menu element.
	aHandleStencil is a stencil that creates a BlElement instance.
	aContentStencil is a stencil that creates a BlElement instance.
	anAptitudeBlock is a block that receives the aptitude instance."

	^ self new 
		handle: aHandleStencil content: aContentStencil;
		in: [ :anAptitude | anAptitudeBlock value: anAptitude ];
		yourself
]

{ #category : #initialization }
BrWithExplicitDropdownAptitude >> initialize [
	super initialize.
	self beDropdown.
	self withAllExtraEventHandlers
]

{ #category : #initialization }
BrWithExplicitDropdownAptitude >> initializeListeners [
	super initializeListeners.
	self when: BrDropdownShowWish do: [ :anEvent | self onShowWish: anEvent ].
	self when: BrDropdownHideWish do: [ :anEvent | self onHideWish: anEvent ]
]

{ #category : #'private - event management' }
BrWithExplicitDropdownAptitude >> onHidden [
	super onHidden.
	self dispatchEvent: BrDropdownIsHidden new
]

{ #category : #'private - event management' }
BrWithExplicitDropdownAptitude >> onShown [
	super onShown.
	self dispatchEvent: BrDropdownIsVisible new
]

{ #category : #'api - initialization' }
BrWithExplicitDropdownAptitude >> withDefaultHandle [
	self withTopLeftHandle
]
