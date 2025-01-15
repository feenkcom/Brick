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
	
	BlTaskAction
		enqueueElement: anElement
		action: [ anElement
				fireEvent: (BrMenuShowSubmenuWish new
						submenu: self menu;
						fromElement: anElement) ].
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
	handleStencil := aStencil asStencil
]

{ #category : #'api - visibility' }
BrMenuExplicitHandle >> hide [
	super hide.
	
	"Recompute the submenu next time is it displayed."
	menu := nil
]

{ #category : #initialization }
BrMenuExplicitHandle >> initialize [
	super initialize.

	handleStencil := [ self defaultElement ] asStencil.
	submenuStencil := nil.
]

{ #category : #accessing }
BrMenuExplicitHandle >> submenu: aStencil [
	submenuStencil := aStencil asStencil
]
