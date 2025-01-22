Class {
	#name : #BrWithExplicitDropdownAptitude,
	#superclass : #BrWithExplicitMenuAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #'instance creation' }
BrWithExplicitDropdownAptitude class >> handle: aHandleStencil content: aContentStencil [
	^ self new
		handle: aHandleStencil
		submenu: (BrMenuExplicit new stencil: aContentStencil)
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
