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

	anElement addAptitude: (BrMenuHideableAptitude new menuModel: self).
	
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
