Class {
	#name : #BrColumnedTree,
	#superclass : #BrTree,
	#instVars : [
		'columnedModel'
	],
	#category : #'Brick-Tree - UI'
}

{ #category : #'api - scripting' }
BrColumnedTree >> column [
	<return: #BrColumn>

	^ columnedModel column
]

{ #category : #initialization }
BrColumnedTree >> defaultListModel [
	^ BrColumnedTreeModel new
]

{ #category : #initialization }
BrColumnedTree >> initialize [
	super initialize.

	self viewModel add: (columnedModel := BrColumnedModel new).

	self aptitude: BrColumnedTreeAptitude + BrGlamorousWithVerticalScrollbarAptitude
]

{ #category : #'api - scripting' }
BrColumnedTree >> nodeType: aBrTreeNodeTypeStencilBuilderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemTypeFactory :aTreeNode :aNodeIndex | ].
	anItemTypeFactory is a ${class:BrListItemType class}$ "
	
	self viewModel nodeTypeStencil: aBrTreeNodeTypeStencilBuilderOrBlock
]

{ #category : #'api - scripting' }
BrColumnedTree >> rowDataBinder: aBrTreeRowDataBinderOrBlock [
	"An item type stencil can be a #value-able of the form [ :aRowElement :aTreeNode :aRowPosition | ]"

	self viewModel rowDataBinder: aBrTreeRowDataBinderOrBlock
]

{ #category : #'api - scripting' }
BrColumnedTree >> rowStencil: aBrColumnedTreeRowElementStencilBuilderOrBlock [
	"A row element stencil can be a #value-able of the form [ :aNodeType :theColumnElements :theColumns | ]"

	self viewModel rowElementStencil: aBrColumnedTreeRowElementStencilBuilderOrBlock
]

{ #category : #'api - scripting' }
BrColumnedTree >> withoutSelection [
	self aptitude withoutSelection
]
