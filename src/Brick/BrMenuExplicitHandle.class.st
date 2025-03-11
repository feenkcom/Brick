Class {
	#name : #BrMenuExplicitHandle,
	#superclass : #BrMenuHandle,
	#instVars : [
		'handleStencil',
		'submenuStencil'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenuExplicitHandle >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuExplicitHandle: self
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

{ #category : #accessing }
BrMenuExplicitHandle >> handleStencil [
	^ handleStencil
]

{ #category : #'api - visibility' }
BrMenuExplicitHandle >> hide [
	"Hide corresponding menu element.
	Note: This method can be called only from the UI process."
	
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
