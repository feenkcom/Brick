Class {
	#name : #BrGroupedList,
	#superclass : #BrList,
	#instVars : [
		'updater'
	],
	#category : #'Brick-List-Grouped-Elements'
}

{ #category : #'instance creation' }
BrGroupedList class >> multiSelection [
	^ self basicNew
		initialize;
		initializeAptitude: BrMultiGroupedListAptitude + BrGlamorousListWithScrollbarAptitude
]

{ #category : #'instance creation' }
BrGroupedList class >> new [
	^ self singleSelection
]

{ #category : #'instance creation' }
BrGroupedList class >> singleSelection [
	^ self basicNew
		initialize;
		initializeAptitude: BrGroupedListAptitude + BrGlamorousListWithScrollbarAptitude
]

{ #category : #'api - orientation' }
BrGroupedList >> beHorizontal [
	self states addState: BrListOrientationState horizontal
]

{ #category : #'api - orientation' }
BrGroupedList >> beVertical [
	self states addState: BrListOrientationState vertical
]

{ #category : #initialization }
BrGroupedList >> defaultListModel [
	^ BrGroupedListModel new
]

{ #category : #'api - accessing' }
BrGroupedList >> groups: aCollectionOfBrGroup [
	self groupsProvider: (BrSequenceableCollectionItemsProvider new collection: aCollectionOfBrGroup)
]

{ #category : #'api - accessing' }
BrGroupedList >> groupsProvider: aBrAbstractListItemsProvider [
	self checkInUIProcess.
	self viewModel groupsProvider: aBrAbstractListItemsProvider
]

{ #category : #'api - accessing' }
BrGroupedList >> headerDataBinder: aBrListItemDataBinderOrBlock [
	"An item type stencil can be a #value-able of the form [ :anItemElement :anItemObject :anItemIndex | ]"

	self viewModel headerDataBinder: aBrListItemDataBinderOrBlock
]

{ #category : #'api - accessing' }
BrGroupedList >> headerElementStencil: aBrListItemElementStencilBuilderOrBlock [
	"A group's header element stencil can be a #value-able of the form [ :anItemType :aListWidget | ]"

	self viewModel headerElementStencil: aBrListItemElementStencilBuilderOrBlock
]

{ #category : #initialization }
BrGroupedList >> initialize [
	super initialize.

	self beVertical.
		
	updater := BrElementUpdater new
		element: self
		selector: #onGroupsChanged.

	self when: BrGroupedListGroupsChanged do: [ updater requestUpdate ]
]

{ #category : #initialization }
BrGroupedList >> initializeAptitude: aGroupedListAptitude [
	self addAptitude: aGroupedListAptitude
]

{ #category : #'private - event handling' }
BrGroupedList >> onGroupsChanged [
	"Is sent when the structure of the groups has been changed.
	This event handler is called at most once per frame from a UI process"
	
	^ self viewModel processLoadedData
]

{ #category : #'api - selection' }
BrGroupedList >> selectedEntityDo: aBlock [
	"Evaluate aBlock with the currently selected entity and index"

	self selectedIndices
		ifNotEmpty: [ :theIndices |
			(theIndices first between: 1 and: self maxSelectionIndex)
				ifTrue: [ aBlock 
					cull: (self viewModel entityAt: theIndices first) 
					cull: theIndices first ] ]
]

{ #category : #'api - accessing' }
BrGroupedList >> stream: anAsyncStream [
	self
		stream: anAsyncStream
		executionConfiguration: BrStreamItemsProvider defaultExecutionConfiguration
]

{ #category : #accessing }
BrGroupedList >> stream: anAsyncStream executionConfiguration: anAsyncFutureExecutionConfiguration [
	self checkInUIProcess.
	self groupsProvider: (BrStreamItemsProvider new
		stream: anAsyncStream;
		executionConfiguration: anAsyncFutureExecutionConfiguration)
]
