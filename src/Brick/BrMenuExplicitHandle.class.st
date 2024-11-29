Class {
	#name : #BrMenuExplicitHandle,
	#superclass : #BrMenuHandle,
	#instVars : [
		'stencil'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - converting' }
BrMenuExplicitHandle >> asElement [
	| anElement |
	anElement := self stencil asElement.
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
		size: 3@3;
		geometry: BlCircleGeometry new;
		background: Color white
]

{ #category : #initialization }
BrMenuExplicitHandle >> initialize [
	super initialize.

	stencil := [ self defaultElement ] asStencil
]

{ #category : #accessing }
BrMenuExplicitHandle >> stencil [
	^ stencil
]

{ #category : #accessing }
BrMenuExplicitHandle >> stencil: aStencil [
	stencil := aStencil asStencil
]
