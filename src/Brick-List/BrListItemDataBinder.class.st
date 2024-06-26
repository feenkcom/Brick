"
I define the api of an object that should bind the actual item data to the reused item elements
"
Class {
	#name : #BrListItemDataBinder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'itemPosition',
		'itemObject',
		'itemElement',
		'rowObject'
	],
	#category : #'Brick-List-Stencils'
}

{ #category : #converting }
BrListItemDataBinder >> asStencilBuilder: aStencilBuilderClass [
	aStencilBuilderClass = BrColumnCellDataBinder
		ifTrue: [ ^ BrListItemToColumnCellDataBinderAdapter new listItemDataBinder: self ].
	^ self
]

{ #category : #'api - instantiation' }
BrListItemDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ itemElement
]

{ #category : #accessing }
BrListItemDataBinder >> itemElement [
	^ itemElement
]

{ #category : #accessing }
BrListItemDataBinder >> itemElement: anObject [
	itemElement := anObject
]

{ #category : #accessing }
BrListItemDataBinder >> itemObject [
	^ itemObject
]

{ #category : #accessing }
BrListItemDataBinder >> itemObject: anObject [
	itemObject := anObject
]

{ #category : #accessing }
BrListItemDataBinder >> itemPosition [
	^ itemPosition
]

{ #category : #accessing }
BrListItemDataBinder >> itemPosition: anObject [
	itemPosition := anObject
]

{ #category : #'api - instantiation' }
BrListItemDataBinder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self itemElement;
		push: self itemObject;
		push: self itemPosition
]

{ #category : #initialization }
BrListItemDataBinder >> reset [
	itemObject := nil.
	itemPosition := nil.
	itemElement := nil.
	rowObject := nil
]

{ #category : #accessing }
BrListItemDataBinder >> rowObject [
	^ rowObject
]

{ #category : #accessing }
BrListItemDataBinder >> rowObject: anObject [
	rowObject := anObject
]
