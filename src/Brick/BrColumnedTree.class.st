Class {
	#name : #BrColumnedTree,
	#superclass : #BrTree,
	#instVars : [
		'columnedModel',
		'sortState',
		'sourceItems',
		'childrenComputation',
		'immediateChildren',
		'childrenCache',
		'cellSpacing'
	],
	#category : #'Brick-Tree - UI'
}

{ #category : #'instance  creation' }
BrColumnedTree class >> newMultiSelectionAptitude [
	^ BrColumnedMultiTreeAptitude + BrGlamorousWithVerticalScrollbarAptitude
]

{ #category : #'instance  creation' }
BrColumnedTree class >> newSingleSelectionAptitude [
	^ BrColumnedTreeAptitude + BrGlamorousWithVerticalScrollbarAptitude
]

{ #category : #sorting }
BrColumnedTree >> beUnsorted [
	self sortState isUnsorted ifTrue: [ ^ self ].
	sortState := BrColumnUnsortedState new.
	self canSortColumns ifTrue: [ self rebuildSortedTree ]
]

{ #category : #sorting }
BrColumnedTree >> canSortColumns [
	^ sourceItems notNil
]

{ #category : #accessing }
BrColumnedTree >> cellSpacing [
	^ cellSpacing ifNil: [ BrColumn defaultCellSpacing ]
]

{ #category : #accessing }
BrColumnedTree >> cellSpacing: aNumber [
	"Configure before installing headers. Applies to the default row stencil; custom rows must honor this setting."
	cellSpacing := aNumber.
	self rowStencil: (BrGlamorousColumnedTreeSelectableRowElementStencilBuilder new cellSpacing: aNumber)
]

{ #category : #'api - scripting' }
BrColumnedTree >> column [
	<return: #BrColumn>

	^ columnedModel column
]

{ #category : #'api - scripting' }
BrColumnedTree >> columns [
	<return: #BrColumn>

	^ columnedModel columns
]

{ #category : #initialization }
BrColumnedTree >> defaultListModel [
	^ BrColumnedTreeModel new
]

{ #category : #initialization }
BrColumnedTree >> initialize [
	super initialize.

	self viewModel add: (columnedModel := BrColumnedModel new)
]

{ #category : #sorting }
BrColumnedTree >> isSortAscending [
	^ self sortState isAscending
]

{ #category : #accessing }
BrColumnedTree >> items: items children: aBlock [
	self items: items lazy: aBlock
]

{ #category : #accessing }
BrColumnedTree >> items: items immediate: aBlock [
	sourceItems := items asArray copy.
	childrenComputation := aBlock.
	childrenCache := IdentityDictionary new.
	immediateChildren := true.
	self sortState isUnsorted
		ifTrue: [ super items: items immediate: aBlock ]
		ifFalse: [ self rebuildSortedTree ]
]

{ #category : #accessing }
BrColumnedTree >> items: items lazy: aBlock [
	sourceItems := items asArray copy.
	childrenComputation := aBlock.
	childrenCache := IdentityDictionary new.
	immediateChildren := false.
	self sortState isUnsorted
		ifTrue: [ super items: items lazy: aBlock ]
		ifFalse: [ self rebuildSortedTree ]
]

{ #category : #'api - scripting' }
BrColumnedTree >> nodeType: aBrTreeNodeTypeStencilBuilderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemTypeFactory :aTreeNode :aNodeIndex | ].
	anItemTypeFactory is a ${class:BrListItemType class}$ "
	
	self viewModel nodeTypeStencil: aBrTreeNodeTypeStencilBuilderOrBlock
]

{ #category : #sorting }
BrColumnedTree >> rebuildSortedTree [
	"Sort siblings without flattening the hierarchy or evaluating collapsed descendants."

	| selected expanded state computation roots indices cache |
	selected := self selectedItems asArray.
	expanded := OrderedCollection new.
	self viewModel root
		allChildrenNodesLinearDo: [ :node | node isExpanded ifTrue: [ expanded add: node value ] ].
	state := self sortState.
	computation := childrenComputation.
	cache := childrenCache.
	roots := state orderedItems: sourceItems.
	self deselectAll.
	immediateChildren
		ifTrue: [ self viewModel
				items: roots
				immediate: [ :item | 
					state
						orderedItems: (cache at: item ifAbsentPut: [ (computation value: item) asArray ]) ] ]
		ifFalse: [ self viewModel
				items: roots
				children: [ :item | 
					state
						orderedItems: (cache at: item ifAbsentPut: [ (computation value: item) asArray ]) ] ].
	self viewModel
		expandSuchThat: [ :node | 
			node == self viewModel root
				or: [ expanded anySatisfy: [ :item | item == node value ] ] ].
	indices := OrderedCollection new.
	1
		to: self viewModel itemCount
		do: [ :index | 
			(selected anySatisfy: [ :item | item == (self nodeAt: index) value ])
				ifTrue: [ indices add: index ] ].
	indices ifNotEmpty: [ self selectSeveral: indices ]
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

{ #category : #sorting }
BrColumnedTree >> sortByColumn: aColumn [
	(self canSortColumns and: [ aColumn isSortable ]) ifFalse: [ ^ self ].
	self sortState isUnsorted ifTrue: [
		"Retain already realized child identities when entering sorted mode."
		self viewModel root allChildrenNodesLinearDo: [ :node |
			node isExpanded ifTrue: [ childrenCache at: node value put: node childrenValues asArray ] ] ].
	sortState := self sortState nextForColumn: aColumn.
	self rebuildSortedTree
]

{ #category : #sorting }
BrColumnedTree >> sortState [
	^ sortState ifNil: [ sortState := BrColumnUnsortedState new ]
]

{ #category : #sorting }
BrColumnedTree >> sortedColumn [
	^ self sortState column
]

{ #category : #headers }
BrColumnedTree >> withHeaders [
	self withHeadersDo: [ :header | ]
]

{ #category : #headers }
BrColumnedTree >> withHeadersDo: aBlock [
	| header |
	header := BrColumnedTreeHeaderAptitude new cellSpacing: self cellSpacing.
	aBlock value: header.
	self addAptitude: header
]

{ #category : #'api - scripting' }
BrColumnedTree >> withoutSelection [
	self aptitude withoutSelection
]
