Class {
	#name : #BrMenuExplicit,
	#superclass : #BrMenu,
	#instVars : [
		'stencilBuilder'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #'api - converting' }
BrMenuExplicit >> asElement [
	| anElement |
	anElement := self stencil
			menuModel: self;
			asElement.

	self announcer weak
		when: BrMenuHideRequest
		send: #removeFromParent
		to: anElement.
	^ anElement
]

{ #category : #accessing }
BrMenuExplicit >> stencil [
	<return: #BrMenuExplicitStencilBuilder>
	^ stencilBuilder
]

{ #category : #accessing }
BrMenuExplicit >> stencil: aBrStencil [
	stencilBuilder := aBrStencil asStencilBuilder: BrMenuExplicitStencilBuilder
]
