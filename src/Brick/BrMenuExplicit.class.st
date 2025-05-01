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

{ #category : #accessing }
BrMenuExplicit >> stencil [
	<return: #BrMenuExplicitStencilBuilder>
	^ stencilBuilder
]

{ #category : #accessing }
BrMenuExplicit >> stencil: aBrStencilBuilder [
	"Set a stencil builder that builds BlElement instances.
	It can be a block with one argument, receiving this menu model object: [ :anExplicitMenu | ]."

	stencilBuilder := aBrStencilBuilder asStencilBuilder: BrMenuExplicitStencilBuilder
]
