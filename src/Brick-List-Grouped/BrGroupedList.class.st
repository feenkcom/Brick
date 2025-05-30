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

{ #category : #'api - selection' }
BrGroupedList >> addToSelection: anIndex dueTo: aSourceEvent [
	| anEntity |
	anEntity := self viewModel entityAt: anIndex.
	anEntity isItem ifFalse: [ ^ self ].

	selectionModel addToSelection: anIndex dueTo: aSourceEvent
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
BrGroupedList >> select: anInteger to: anotherIndex dueTo: aSourceEvent [
	| aStart aStop someIndexes |
	aStart := (anInteger min: anotherIndex) max: 1.
	aStop := ((anInteger max: anotherIndex) min: self maxSelectionIndex) max: 1.
	someIndexes := Array
			new: aStop - aStart + 1
			streamContents: [ :aStream | 
				aStart
					to: aStop
					do: [ :anIndex | (self viewModel entityAt: anIndex) isItem ifTrue: [ aStream nextPut: anIndex ] ] ].

	selectionModel selectSeveral: someIndexes dueTo: aSourceEvent
]

{ #category : #'api - selection' }
BrGroupedList >> selectAll [
	"Select all items"

	self
		select: 1
		to: self maxSelectionIndex
		dueTo: nil
]

{ #category : #'api - selection' }
BrGroupedList >> selectAtOrNext: anIndex dueTo: aSourceEvent [
	| anEntity |
	anIndex < 1 ifTrue: [ ^ self ].
	anIndex > self maxSelectionIndex ifTrue: [ ^ self ].
	anEntity := self viewModel entityAt: anIndex.
	anEntity isItem ifTrue: [ ^ selectionModel selectOne: anIndex ].
	self selectAtOrNext: anIndex + 1 dueTo: aSourceEvent
]

{ #category : #'api - selection' }
BrGroupedList >> selectAtOrPrevious: anIndex dueTo: aSourceEvent [
	| anEntity |
	anIndex < 1 ifTrue: [ ^ self ].
	anIndex > self maxSelectionIndex ifTrue: [ ^ self ].
	anEntity := self viewModel entityAt: anIndex.
	anEntity isItem ifTrue: [ ^ selectionModel selectOne: anIndex ].
	self selectAtOrPrevious: anIndex - 1 dueTo: aSourceEvent
]

{ #category : #'api - selection' }
BrGroupedList >> selectFirst [
	self selectAtOrNext: 1 dueTo: nil
]

{ #category : #'api - selection' }
BrGroupedList >> selectLast [
	self selectAtOrPrevious: self maxSelectionIndex dueTo: nil
]

{ #category : #'api - selection' }
BrGroupedList >> selectNext [
	self selectedIndices
		ifEmpty: [ self selectAtOrNext: 1 dueTo: nil ]
		ifNotEmpty: [ :theIndices | self selectAtOrNext: theIndices first + 1 dueTo: nil ]
]

{ #category : #'api - selection' }
BrGroupedList >> selectOne: anIndex [
	self selectOne: anIndex dueTo: nil
]

{ #category : #'api - selection' }
BrGroupedList >> selectOne: anIndex dueTo: aSourceEvent [
	anIndex < 1 ifTrue: [ ^ self ].
	anIndex > self maxSelectionIndex ifTrue: [ ^ self ].
	(self viewModel entityAt: anIndex) isItem
		ifTrue: [ selectionModel selectOne: anIndex dueTo: aSourceEvent ]
]

{ #category : #'api - selection' }
BrGroupedList >> selectPrevious [
	self selectedIndices
		ifEmpty: [ self selectAtOrNext: 1 dueTo: nil ]
		ifNotEmpty: [ :theIndices | self selectAtOrPrevious: theIndices first - 1 dueTo: nil ]
]

{ #category : #'api - selection' }
BrGroupedList >> selectSeveral: someIndexes [
	self selectSeveral: someIndexes dueTo: nil
]

{ #category : #'api - selection' }
BrGroupedList >> selectSeveral: someIndexes dueTo: aSourceEvent [
	| filteredIndexes |
	filteredIndexes := someIndexes
			reject: [ :eachIndex | (self viewModel entityAt: eachIndex) isItem not ].
	selectionModel selectSeveral: filteredIndexes dueTo: aSourceEvent
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
