Class {
	#name : #BrGlamorousListContextMenuItemsStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'itemType',
		'itemElement',
		'itemObject',
		'itemPosition'
	],
	#category : #'Brick-Glamorous-List, Tree'
}

{ #category : #'api - instantiation' }
BrGlamorousListContextMenuItemsStencilBuilder >> buildDefault [
	<return: #BrMenu of: #nil>
	^ nil
]

{ #category : #accessing }
BrGlamorousListContextMenuItemsStencilBuilder >> itemElement [

	^ itemElement
]

{ #category : #accessing }
BrGlamorousListContextMenuItemsStencilBuilder >> itemElement: anObject [

	itemElement := anObject
]

{ #category : #accessing }
BrGlamorousListContextMenuItemsStencilBuilder >> itemObject [

	^ itemObject
]

{ #category : #accessing }
BrGlamorousListContextMenuItemsStencilBuilder >> itemObject: anObject [

	itemObject := anObject
]

{ #category : #accessing }
BrGlamorousListContextMenuItemsStencilBuilder >> itemPosition [

	^ itemPosition
]

{ #category : #accessing }
BrGlamorousListContextMenuItemsStencilBuilder >> itemPosition: anObject [

	itemPosition := anObject
]

{ #category : #accessing }
BrGlamorousListContextMenuItemsStencilBuilder >> itemType [

	^ itemType
]

{ #category : #accessing }
BrGlamorousListContextMenuItemsStencilBuilder >> itemType: anObject [

	itemType := anObject
]

{ #category : #'api - instantiation' }
BrGlamorousListContextMenuItemsStencilBuilder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self itemElement;
		push: self itemObject;
		push: self itemPosition;
		push: self itemType
]

{ #category : #accessing }
BrGlamorousListContextMenuItemsStencilBuilder >> reset [
	itemType := nil.
	itemElement := nil.
	itemObject := nil.
	itemPosition := nil
]
