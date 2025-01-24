Class {
	#name : #BrMenuExplicitHandle,
	#superclass : #BrMenuHandle,
	#instVars : [
		'handleStencil',
		'submenuStencil'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - converting' }
BrMenuExplicitHandle >> asElement [
	| anElement |
	anElement := handleStencil asElement.
	anElement addAptitude: (BrMenuHideableAptitude new menuModel: self).
	
	"If a user clicks on a handle, we want to close its menu."
	anElement
		when: BlClickEvent
		do: [ :anEvent | anEvent currentTarget fireEvent: BrMenuHideAllWish new  ].

	^ anElement
]

{ #category : #initialization }
BrMenuExplicitHandle >> defaultElement [
	^ BlElement new
		size: BrMenuConstants handleExtent * 2.0;
		geometry: BlCircleGeometry new;
		background: Color white;
		addAptitude: BrMenuCommonAptitude new
]

{ #category : #initialization }
BrMenuExplicitHandle >> defaultMenu [
	^ submenuStencil ifNotNil: #create
]

{ #category : #accessing }
BrMenuExplicitHandle >> handle: aStencil [
	"Set a handle stencil.
	aStencil is a stencil that creates a BlElement."

	handleStencil := aStencil asStencil
]

{ #category : #'api - visibility' }
BrMenuExplicitHandle >> hide [
	super hide.
	
	"Recompute the submenu next time is it displayed."
	submenuStencil ifNotNil: [ menu := nil ]
]

{ #category : #initialization }
BrMenuExplicitHandle >> initialize [
	super initialize.

	handleStencil := [ self defaultElement ] asStencil.
	submenuStencil := nil.
]

{ #category : #accessing }
BrMenuExplicitHandle >> submenu: aStencil [
	"Set a submenu stencil.
	aStencil is a stencil that creates a BrMenu instance."

	submenuStencil := aStencil asStencil
]
