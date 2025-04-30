Class {
	#name : #BrMenuExplicitItem,
	#superclass : #BrMenuItem,
	#instVars : [
		'stencilBuilder'
	],
	#category : #'Brick-Menu - Model'
}

{ #category : #visiting }
BrMenuExplicitItem >> acceptVisitor: aVisitor [
	^ aVisitor visitMenuExplicitItem: self
]

{ #category : #accessing }
BrMenuExplicitItem >> stencil [
	<return: #BrMenuExplicitStencilBuilder>
	^ stencilBuilder
]

{ #category : #accessing }
BrMenuExplicitItem >> stencil: aBrStencilBuilder [
	"Set a stencil builder that builds BlElement instances.
	It can be a block with one argument, receiving this menu model object: [ :aMenuExplicitItem | ]."

	stencilBuilder := aBrStencilBuilder asStencilBuilder: BrMenuExplicitStencilBuilder
]
