Class {
	#name : 'BrListItemToColumnCellDataBinderAdapter',
	#superclass : 'BrColumnCellDataBinder',
	#instVars : [
		'listItemDataBinder'
	],
	#category : 'Brick-List - Stencil'
}

{ #category : 'api - instantiation' }
BrListItemToColumnCellDataBinderAdapter >> buildDefault [
	^ listItemDataBinder
		itemElement: cellElement;
		itemObject: rowObject;
		itemPosition: rowIndex;
		build
]

{ #category : 'accessing' }
BrListItemToColumnCellDataBinderAdapter >> listItemDataBinder: aBrListItemDataBinder [
	listItemDataBinder := aBrListItemDataBinder asStencilBuilder: BrListItemDataBinder
]
