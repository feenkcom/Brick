Class {
	#name : #BrAbstractListModel,
	#superclass : #BrWidgetModel,
	#instVars : [
		'itemsProvider',
		'itemTypeStencil',
		'itemIdStencil'
	],
	#category : 'Brick-List - Model'
}

{ #category : #initialization }
BrAbstractListModel >> initialize [
	super initialize.

	itemTypeStencil := [ :anItemTypeFactory | anItemTypeFactory default ] asStencilBuilder: BrListItemTypeStencilBuilder.
	itemIdStencil := nil.
	itemsProvider := BrListEmptyItemsProvider new
]

{ #category : #initialization }
BrAbstractListModel >> initializeListeners [
	super initializeListeners.

	"answer if somebody is interested in what items I have"
	self when: BrListItemTypeStencilRequest reply: [ :aResponse | aResponse itemTypeStencil: self itemTypeStencil ].
	self when: BrListItemIdStencilRequest reply: [ :aResponse | aResponse itemIdStencil: self itemIdStencil ].
]

{ #category : #'api - accessing' }
BrAbstractListModel >> itemAt: anIndex [
	^ self itemsProvider itemAt: anIndex
]

{ #category : #'api - accessing' }
BrAbstractListModel >> itemCount [
	<return: #Number>

	^ self itemsProvider itemCount
]

{ #category : #'api - accessing' }
BrAbstractListModel >> itemIdStencil [
	"Return a stencil that is used to create an item id of a given item object"
	<return: #BrListItemIdStencilBuilder or: nil>

	^ itemIdStencil
]

{ #category : #'api - accessing' }
BrAbstractListModel >> itemIdStencil: aStencil [
	"Set a stencil that will be used to create an item element of a given type"

	itemIdStencil := aStencil asStencilBuilder: BrListItemIdStencilBuilder.
	self dispatchEvent: (BrListItemIdStencilChangedEvent new itemIdStencil: itemIdStencil)
]

{ #category : #'api - accessing' }
BrAbstractListModel >> itemTypeStencil [
	"Return a stencil that is used to create an item type of a given item object"
	<return: #BrListItemTypeStencilBuilder>

	^ itemTypeStencil
]

{ #category : #'api - accessing' }
BrAbstractListModel >> itemTypeStencil: aStencil [
	"Set a stencil that will be used to create an item element of a given type"

	itemTypeStencil := aStencil asStencilBuilder: BrListItemTypeStencilBuilder.
	self dispatchEvent: (BrListItemTypeStencilChangedEvent new itemTypeStencil: itemTypeStencil)
]

{ #category : #'api - accessing' }
BrAbstractListModel >> items [
	<return: #Collection of: #Object>
	
	^ itemsProvider currentItems
]

{ #category : #'api - accessing' }
BrAbstractListModel >> items: aCollectionOfObjects [
	self itemsProvider: (BrListSequenceableCollectionItemsProvider new collection: aCollectionOfObjects)
]

{ #category : #'api - accessing' }
BrAbstractListModel >> itemsProvider [
	<return: #BrAbstractListItemsProvider>
	
	^ itemsProvider
]

{ #category : #'api - accessing' }
BrAbstractListModel >> itemsProvider: anItemsProvider [
	itemsProvider := anItemsProvider.
	itemsProvider attachToListModel: self.
]
