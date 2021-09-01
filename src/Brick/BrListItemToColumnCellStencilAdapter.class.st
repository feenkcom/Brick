Class {
	#name : 'BrListItemToColumnCellStencilAdapter',
	#superclass : 'BrColumnCellStencilBuilder',
	#instVars : [
		'listItemElementStencil'
	],
	#category : 'Brick-List - Stencil'
}

{ #category : 'api - instantiation' }
BrListItemToColumnCellStencilAdapter >> buildDefault [
	^ listItemElementStencil
		itemType: itemType;
		build
]

{ #category : 'accessing' }
BrListItemToColumnCellStencilAdapter >> listItemElementStencil: aBrListItemElementStencilBuilder [
	listItemElementStencil := aBrListItemElementStencilBuilder asStencilBuilder: BrListItemElementStencilBuilder
]
