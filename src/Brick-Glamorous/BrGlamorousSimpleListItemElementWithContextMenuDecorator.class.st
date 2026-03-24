Class {
	#name : #BrGlamorousSimpleListItemElementWithContextMenuDecorator,
	#superclass : #BrListItemElementStencilBuilder,
	#instVars : [
		'stencilBuilder',
		'contextMenuStencil',
		'multipleSelectionEnabled'
	],
	#category : #'Brick-Glamorous-List, Tree'
}

{ #category : #accessing }
BrGlamorousSimpleListItemElementWithContextMenuDecorator class >> stencilProperties [
	^ #(contextMenuStencil stencilBuilder multipleSelectionEnabled)
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
						| anItemHolder anItemPosition anItemObject anItemType selectedItems aPickedObject |
						anItemHolder := anElement constraints infinite holder.
						anItemPosition := anItemHolder dataSourcePosition.
						anItemObject := aListElement viewModel itemAt: anItemPosition.

						selectedItems := aListElement selectedItems 
							ifEmpty: [ { anItemObject } ].
						(selectedItems includes: anItemObject) ifFalse: [
							selectedItems := { anItemObject } ].
						aPickedObject := self isMultipleSelectionEnabled
							ifTrue: [ selectedItems ]
							ifFalse: [ selectedItems anyOne ].
						
						anItemType := aListElement viewModel itemTypeStencil
								itemPosition: anItemPosition;
								itemObject: aPickedObject;
								build.

						contextMenuStencil
							itemType: anItemType;
							itemObject: aPickedObject;
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

{ #category : #initialization }
BrGlamorousSimpleListItemElementWithContextMenuDecorator >> initialize [
	super initialize.
	
	multipleSelectionEnabled := false.
]

{ #category : #testing }
BrGlamorousSimpleListItemElementWithContextMenuDecorator >> isMultipleSelectionEnabled [
	^ multipleSelectionEnabled == true
]

{ #category : #'api - instantiation' }
BrGlamorousSimpleListItemElementWithContextMenuDecorator >> listOfKindClass [
	^ BrSimpleList
]

{ #category : #'api - initialization' }
BrGlamorousSimpleListItemElementWithContextMenuDecorator >> multipleSelectionEnabled: aBoolean [
	multipleSelectionEnabled := aBoolean
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
