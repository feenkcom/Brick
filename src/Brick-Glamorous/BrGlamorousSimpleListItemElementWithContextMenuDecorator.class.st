Class {
	#name : #BrGlamorousSimpleListItemElementWithContextMenuDecorator,
	#superclass : #BrListItemElementStencilBuilder,
	#instVars : [
		'stencilBuilder',
		'contextMenuStencil'
	],
	#category : #'Brick-Glamorous-List, Tree'
}

{ #category : #accessing }
BrGlamorousSimpleListItemElementWithContextMenuDecorator class >> stencilProperties [
	^ #(contextMenuStencil stencilBuilder)
]

{ #category : #'api - instantiation' }
BrGlamorousSimpleListItemElementWithContextMenuDecorator >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| anElement aContextMenuAptitude |
	
	anElement := stencilBuilder
			itemType: self itemType;
			build.

	aContextMenuAptitude := BrGlamorousWithExplicitContextMenuAptitude
			menu: [ anElement
					allParentsDetect: [ :eachParent | eachParent isKindOf: self listOfKindClass ]
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
					ifNone: [ nil ] ].

	anElement addAptitude: aContextMenuAptitude.
	^ anElement
]

{ #category : #accessing }
BrGlamorousSimpleListItemElementWithContextMenuDecorator >> contextMenuStencil [
	<return: #GtPhlowListContextMenuStencilBuilder>

	^ contextMenuStencil
]

{ #category : #accessing }
BrGlamorousSimpleListItemElementWithContextMenuDecorator >> contextMenuStencil: aGtPhlowListContextMenuStencilBuilder [
	contextMenuStencil := aGtPhlowListContextMenuStencilBuilder asStencilBuilder: BrGlamorousListContextMenuItemsStencilBuilder
]

{ #category : #'api - instantiation' }
BrGlamorousSimpleListItemElementWithContextMenuDecorator >> listOfKindClass [
	^ BrSimpleList
]

{ #category : #accessing }
BrGlamorousSimpleListItemElementWithContextMenuDecorator >> stencilBuilder [
	<return: #BrListItemElementStencilBuilder>

	^ stencilBuilder
]

{ #category : #accessing }
BrGlamorousSimpleListItemElementWithContextMenuDecorator >> stencilBuilder: aBrListItemElementStencilBuilder [
	stencilBuilder := aBrListItemElementStencilBuilder asStencilBuilder: BrListItemElementStencilBuilder
]
