Class {
	#name : #BrGroup,
	#superclass : #Object,
	#instVars : [
		'domainObject',
		'itemsProvider',
		'itemStencil',
		'itemDataBinder',
		'shouldShowWithoutItems',
		'itemsLimit',
		'itemTypeStencil'
	],
	#category : #'Brick-List-Grouped-Models'
}

{ #category : #accessing }
BrGroup >> domainObject [

	^ domainObject
]

{ #category : #accessing }
BrGroup >> domainObject: anObject [

	domainObject := anObject
]

{ #category : #initialization }
BrGroup >> initialize [
	super initialize.
	
	domainObject := nil.
	itemsProvider := BrEmptyItemsProvider new.
	shouldShowWithoutItems := false.
	itemsLimit := Float infinity.
	itemTypeStencil := [ :anItemTypeFactory | anItemTypeFactory default ] asStencilBuilder: BrListItemTypeStencilBuilder
]

{ #category : #accessing }
BrGroup >> itemDataBinder [

	^ itemDataBinder
]

{ #category : #accessing }
BrGroup >> itemDataBinder: aBrListItemDataBinderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemElement :anItemObject :anItemIndex | ]"

	itemDataBinder := aBrListItemDataBinderOrBlock asStencilBuilder: BrListItemDataBinder
]

{ #category : #accessing }
BrGroup >> itemStencil [

	^ itemStencil
]

{ #category : #accessing }
BrGroup >> itemStencil: aBrListItemElementStencilBuilderOrBlock [
	"An item element stencil can be a #value-able of the form [ :anItemType :aListWidget | ]"

	itemStencil := aBrListItemElementStencilBuilderOrBlock asStencilBuilder: BrListItemElementStencilBuilder.
]

{ #category : #accessing }
BrGroup >> itemType: aBrListItemTypeStencilBuilderOrBlock [
	"Set a stencil that will be used to create an item element of a given type"

	itemTypeStencil := aBrListItemTypeStencilBuilderOrBlock asStencilBuilder: BrListItemTypeStencilBuilder
]

{ #category : #accessing }
BrGroup >> itemTypeStencil [
	^ itemTypeStencil
]

{ #category : #accessing }
BrGroup >> items: aCollectionOfItems [
	self itemsProvider: (BrSequenceableCollectionItemsProvider new collection: aCollectionOfItems)
]

{ #category : #accessing }
BrGroup >> itemsLimit [
	"Return a maximum amount of items a group should display"
	<return: #Number>

	^ itemsLimit
]

{ #category : #accessing }
BrGroup >> itemsLimit: anObject [

	itemsLimit := anObject
]

{ #category : #accessing }
BrGroup >> itemsProvider [

	^ itemsProvider
]

{ #category : #accessing }
BrGroup >> itemsProvider: anObject [
	itemsProvider := anObject asBrItemsProvider
]

{ #category : #accessing }
BrGroup >> shouldShowWithoutItems [
	"Return true if the group should be rendered even though it does not have items.
	When there are no items, just a header of the groups will appear in the list with potentially corresponding actions"
	<return: #Boolean>

	^ shouldShowWithoutItems
]

{ #category : #accessing }
BrGroup >> shouldShowWithoutItems: anObject [

	shouldShowWithoutItems := anObject
]

{ #category : #accessing }
BrGroup >> stream: anAsyncStream [
	self itemsProvider: (BrStreamItemsProvider new stream: anAsyncStream)
]
