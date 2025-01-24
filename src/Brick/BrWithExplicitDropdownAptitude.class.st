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

{ #category : #initialization }
BrWithExplicitDropdownAptitude >> initialize [
	super initialize.
	self beDropdown.
	self withAllExtraEventHandlers
]

{ #category : #initialization }
BrWithExplicitDropdownAptitude >> initializeListeners [
	super initializeListeners.

	self 
		when: BrDropdownShowWish
		do: [ :anEvent | 
			anEvent consumed: true.
			self showDueTo: nil ].
	self 
		when: BrDropdownHideWish
		do: [ :anEvent | 
			anEvent consumed: true.
			self hide ].
]

{ #category : #'api - initialization' }
BrWithExplicitDropdownAptitude >> withDefaultHandle [
	self withTopLeftHandle
]
