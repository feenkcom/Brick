Class {
	#name : #BrListItemToColumnCellDataBinderAdapter,
	#superclass : #BrColumnCellDataBinder,
	#instVars : [
		'listItemDataBinder'
	],
	#category : #'Brick-List-Stencils'
}

{ #category : #accessing }
BrListItemToColumnCellDataBinderAdapter class >> stencilProperties [
	^ #(listItemDataBinder)
]

{ #category : #'api - instantiation' }
BrListItemToColumnCellDataBinderAdapter >> buildDefault [
	^ listItemDataBinder
		itemElement: cellElement;
		itemObject: itemObject;
		rowObject: rowObject;
		itemPosition: rowIndex;
		build
]

{ #category : #accessing }
BrListItemToColumnCellDataBinderAdapter >> listItemDataBinder: aBrListItemDataBinder [
	listItemDataBinder := aBrListItemDataBinder asStencilBuilder: BrListItemDataBinder
]
