"
I am {{gtClass:BrMenuItem}}. 
I create {{gtClass:BrMenuItems}}'s item element using {{gtMethod:BrMenuExplicitItem >> #stencil: | label=#yourself}}. 
Users can use convenience methods:
- {{gtMethod:BrMenuItems>>#addItemStencil:}}, 
- {{gtMethod: BrMenuItems>>#addItemId:stencil: }}. 
# Example
Click on the following button and check the explicit item with a text editor: {{gtExample:BrMenuExamples >> menuItems | codeExpanded=false | previewExpanded=true | previewHeight=300 | previewShow=#gtDropdownFor: }}
"
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
