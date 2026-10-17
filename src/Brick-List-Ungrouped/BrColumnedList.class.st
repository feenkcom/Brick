Class {
	#name : #BrColumnedList,
	#superclass : #BrUngroupedList,
	#instVars : [
		'columnedModel',
		'sortState'
	],
	#category : #'Brick-List-Ungrouped-Elements'
}

{ #category : #sorting }
BrColumnedList >> applyColumnSort [
	self applyColumnSortPreserving: self selectedItems asArray
]

{ #category : #sorting }
BrColumnedList >> applyColumnSortPreserving: selected [
	| ordered indices |
	ordered := self sortState orderedItems: self items.
	self deselectAll.
	super itemsProvider: (BrSequenceableCollectionItemsProvider new collection: ordered).
	indices := OrderedCollection new.
	self items withIndexDo: [ :item :index |
		(selected anySatisfy: [ :each | each == item ]) ifTrue: [ indices add: index ] ].
	indices ifNotEmpty: [ self selectSeveral: indices ]
]

{ #category : #sorting }
BrColumnedList >> beUnsorted [
	"Stop applying an ordering. Keep the current presentation order; do not invent a source order."
	sortState := BrColumnUnsortedState new.
	self canSortColumns ifTrue: [ self applyColumnSort ]
]

{ #category : #sorting }
BrColumnedList >> canSortColumns [
	"Never materialize streams or remote providers implicitly."
	^ self itemsProvider class = BrSequenceableCollectionItemsProvider
]

{ #category : #'api - scripting' }
BrColumnedList >> column [
	<return: #BrColumn>

	^ self viewModel column
]

{ #category : #'api - scripting' }
BrColumnedList >> columns [
	<return: #Collection of: #BrColumn>

	^ self viewModel columns
]

{ #category : #initialization }
BrColumnedList >> defaultListModel [
	^ BrColumnedListModel new
]

{ #category : #initialization }
BrColumnedList >> initialize [
	super initialize.

	self aptitude: BrColumnedListAptitude + BrGlamorousWithVerticalScrollbarAptitude
]

{ #category : #sorting }
BrColumnedList >> isSortAscending [
	^ self sortState isAscending
]

{ #category : #accessing }
BrColumnedList >> itemsProvider: aProvider [
	| selected |
	selected := self sortState isUnsorted ifTrue: [ #() ] ifFalse: [ self selectedItems asArray ].
	super itemsProvider: aProvider.
	(self sortState isUnsorted not and: [ self canSortColumns ]) ifTrue: [ self applyColumnSortPreserving: selected ]
]

{ #category : #initialization }
BrColumnedList >> rowDataBinder: aBrListRowDataBinderOrBlock [
	"An item type stencil can be a #value-able of the form [ :aRowElement :aTreeNode :aRowPosition | ]"

	self viewModel rowDataBinder: aBrListRowDataBinderOrBlock
]

{ #category : #'api - scripting' }
BrColumnedList >> rowStencil: aRowStencil [
	self aptitude rowStencilBuilder: aRowStencil
]

{ #category : #sorting }
BrColumnedList >> sortByColumn: aColumn [
	(self canSortColumns and: [ aColumn isSortable ]) ifFalse: [ ^ self ].
	sortState := self sortState nextForColumn: aColumn.
	self applyColumnSort
]

{ #category : #sorting }
BrColumnedList >> sortState [
	^ sortState ifNil: [ sortState := BrColumnUnsortedState new ]
]

{ #category : #sorting }
BrColumnedList >> sortedColumn [
	^ self sortState column
]

{ #category : #headers }
BrColumnedList >> withHeaders [
	self addAptitude: BrColumnedListHeaderAptitude new
]
