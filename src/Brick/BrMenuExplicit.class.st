Class {
	#name : #BrMenuExplicit,
	#superclass : #BrMenu,
	#instVars : [
		'stencilBuilder'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenuExplicit >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuExplicit: self
]

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
BrMenuExplicit >> stencil: aBrStencilBuilder [
	"Set a stencil builder that builds BlElement instances.
	It can be a block with one argument, receiving this element model object: [ :anExplicitMenu | ]."

	stencilBuilder := aBrStencilBuilder asStencilBuilder: BrMenuExplicitStencilBuilder
]
