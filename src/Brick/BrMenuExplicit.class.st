Class {
	#name : #BrMenuExplicit,
	#superclass : #BrMenu,
	#instVars : [
		'stencil'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - converting' }
BrMenuExplicit >> asElement [
	| anElement |
	anElement := self stencil asElement.

	self announcer weak
		when: BrMenuHideRequest
		send: #removeFromParent
		to: anElement.
	^ anElement
]

{ #category : #accessing }
BrMenuExplicit >> stencil [
	^ stencil
]

{ #category : #accessing }
BrMenuExplicit >> stencil: aBrStencil [
	stencil := aBrStencil asStencil
]
