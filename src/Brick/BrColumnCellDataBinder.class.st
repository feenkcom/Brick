Class {
	#name : #BrColumnCellDataBinder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'cellElement',
		'rowObject',
		'rowIndex',
		'rowHolder',
		'columnIndex',
		'itemObject'
	],
	#category : 'Brick-Column - Stencil'
}

{ #category : #'api - instantiation' }
BrColumnCellDataBinder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ cellElement
]

{ #category : #accessing }
BrColumnCellDataBinder >> cellElement [
	^ cellElement
]

{ #category : #accessing }
BrColumnCellDataBinder >> cellElement: anObject [
	cellElement := anObject
]

{ #category : #accessing }
BrColumnCellDataBinder >> columnIndex [
	^ columnIndex
]

{ #category : #accessing }
BrColumnCellDataBinder >> columnIndex: anObject [
	columnIndex := anObject
]

{ #category : #accessing }
BrColumnCellDataBinder >> itemObject [
	^ itemObject
]

{ #category : #accessing }
BrColumnCellDataBinder >> itemObject: anObject [
	itemObject := anObject
]

{ #category : #'api - instantiation' }
BrColumnCellDataBinder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self cellElement;
		push: self itemObject;
		push: self rowIndex;
		push: self rowHolder;
		push: self columnIndex
]

{ #category : #initialization }
BrColumnCellDataBinder >> reset [
	cellElement := nil.
	columnIndex := nil.
	rowIndex := nil.
	rowObject := nil.
	rowHolder := nil
]

{ #category : #accessing }
BrColumnCellDataBinder >> rowHolder [
	^ rowHolder
]

{ #category : #accessing }
BrColumnCellDataBinder >> rowHolder: anObject [
	rowHolder := anObject
]

{ #category : #accessing }
BrColumnCellDataBinder >> rowIndex [
	^ rowIndex
]

{ #category : #accessing }
BrColumnCellDataBinder >> rowIndex: anObject [
	rowIndex := anObject
]

{ #category : #accessing }
BrColumnCellDataBinder >> rowObject [
	^ rowObject
]

{ #category : #accessing }
BrColumnCellDataBinder >> rowObject: anObject [
	rowObject := anObject
]
