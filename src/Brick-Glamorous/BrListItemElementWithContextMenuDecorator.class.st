Class {
	#name : #BrListItemElementWithContextMenuDecorator,
	#superclass : #BrListItemElementStencilBuilder,
	#instVars : [
		'stencilBuilder',
		'contextMenuStencil'
	],
	#category : #'Brick-Glamorous-List, Tree'
}

{ #category : #accessing }
BrListItemElementWithContextMenuDecorator class >> stencilProperties [
	^ #(contextMenuStencil stencilBuilder)
]

{ #category : #'api - instantiation' }
BrListItemElementWithContextMenuDecorator >> buildDefault [
	| anElement aContextMenuAptitude |
	<return: #BrStencil or: #BlElement>

	anElement := stencilBuilder
		itemType: self itemType;
		build.

	aContextMenuAptitude :=
		BrGlamorousWithContextMenuAptitude
			content: [
				anElement
					allParentsDetect: [ :eachParent | 
						eachParent isKindOf: BrSimpleList ]
					ifFound: [ :aListElement |
						| anItemHolder anItemPosition anItemObject anItemType |
						
						anItemHolder := anElement constraints infinite holder.
						anItemPosition := anItemHolder dataSourcePosition.
						anItemObject := aListElement viewModel itemAt: anItemPosition.

						anItemType := aListElement viewModel itemTypeStencil
							itemPosition: anItemPosition;
							itemObject: anItemObject;
							build.
								
						contextMenuStencil
							itemType: anItemType;
							itemObject: anItemObject;
							itemPosition: anItemPosition;
							itemElement: anElement;
							build ]
					ifNone: [ BlElement new ]].

	anElement addAptitude: aContextMenuAptitude.
	^ anElement
]

{ #category : #accessing }
BrListItemElementWithContextMenuDecorator >> contextMenuStencil [
	<return: #GtPhlowListContextMenuStencilBuilder>

	^ contextMenuStencil
]

{ #category : #accessing }
BrListItemElementWithContextMenuDecorator >> contextMenuStencil: aGtPhlowListContextMenuStencilBuilder [
	contextMenuStencil := aGtPhlowListContextMenuStencilBuilder asStencilBuilder: GtPhlowListContextMenuStencilBuilder
]

{ #category : #accessing }
BrListItemElementWithContextMenuDecorator >> stencilBuilder [
	<return: #BrListItemElementStencilBuilder>

	^ stencilBuilder
]

{ #category : #accessing }
BrListItemElementWithContextMenuDecorator >> stencilBuilder: aBrListItemElementStencilBuilder [
	stencilBuilder := aBrListItemElementStencilBuilder asStencilBuilder: BrListItemElementStencilBuilder
]
