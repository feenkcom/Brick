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

{ #category : #'api - initialization' }
BrWithExplicitDropdownAptitude >> withDefaultHandle [
	self withTopLeftHandle
]
