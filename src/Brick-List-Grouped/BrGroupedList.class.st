Class {
	#name : #BrGroupedList,
	#superclass : #BrList,
	#instVars : [
		'updater'
	],
	#category : #'Brick-List-Grouped-Elements'
}

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
BrGroupedList >> groupSuchThat: aGroupMatchBlock itemSuchThat: anItemMatchBlock do: anActionBlock [
	"Attempt to find the first group and group item matching given blocks 
	which may involve preloading items until such item is found.
	Evaluate an action block synchronously if an item was already preloaded,
	otherwise schedule execution in a UI process"

	<return: #TAsyncPromise>
	| aPromise |
	aPromise := self viewModel groups
		groupSuchThat: aGroupMatchBlock
		itemSuchThat: anItemMatchBlock
		do: [ :anItemIndex :isSynchronous |
			anItemIndex > 0 
				ifTrue: [ 
					isSynchronous
						ifTrue: [
							anActionBlock cull: anItemIndex.
							^ anItemIndex asAsyncPromise ]
						ifFalse: [ self enqueueTask: (BlTaskAction new
							action: [ anActionBlock value: anItemIndex ]).
							anItemIndex ] ]
				ifFalse: [ anItemIndex ] ].

	self enqueueTask: (BlPromiseTask new promise: aPromise).
	
	^ aPromise
]

{ #category : #'api - accessing' }
BrGroupedList >> groups: aCollectionOfBrGroup [
	self groupsProvider: (BrSequenceableCollectionItemsProvider new collection: aCollectionOfBrGroup)
]

{ #category : #'api - accessing' }
BrGroupedList >> groupsProvider: aBrAbstractListItemsProvider [
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

	self aptitude: BrGroupedListAptitude + BrGlamorousListWithScrollbarAptitude.
		
	updater := BrElementUpdater new
		element: self
		selector: #onGroupsChanged.

	self when: BrGroupedListGroupsChanged do: [ updater requestUpdate ]
]

{ #category : #'private - event handling' }
BrGroupedList >> onGroupsChanged [
	"Is sent when the structure of the groups has been changed.
	This event handler is called at most once per frame from a UI process"
	
	^ self viewModel processLoadedData
]

{ #category : #'api - scrolling' }
BrGroupedList >> scrollToGroupDomainObject: aGroupDomainObject item: anItem [
	"Scroll the InfiniteELement to make the group's item position visible.
	See {{gtMethod:BlInfiniteLinearLayout>>#scrollToPosition:}}"

	<return: #TAsyncPromise>
	^ self
		scrollToGroupSuchThat: [ :aGroup | aGroup domainObject = aGroupDomainObject ]
		itemSuchThat: [ :eachItem | eachItem = anItem ]
]

{ #category : #'api - scrolling' }
BrGroupedList >> scrollToGroupDomainObject: aGroupDomainObject item: anItem offset: anOffset [
	"Scroll the InfiniteELement to make the group's item position visible 
	with the given offset from resolved layout start.
	See {{gtMethod:BlInfiniteLinearLayout>>#scrollToPosition:offset:}}"
	
	<return: #TAsyncPromise>
	^ self
		scrollToGroupSuchThat: [ :aGroup | aGroup domainObject = aGroupDomainObject ]
		itemSuchThat: [ :eachItem | eachItem = anItem ]
		offset: anOffset
]

{ #category : #'api - scrolling' }
BrGroupedList >> scrollToGroupSuchThat: aGroupMatchBlock itemSuchThat: anItemMatchBlock [
	"Scroll the InfiniteELement to make the group's item position visible.
	See {{gtMethod:BlInfiniteLinearLayout>>#scrollToPosition:}}"

	<return: #TAsyncPromise>
	^ self
		groupSuchThat: aGroupMatchBlock
		itemSuchThat: anItemMatchBlock
		do: [ :anItemIndex | self scrollToIndex: anItemIndex ]
]

{ #category : #'api - scrolling' }
BrGroupedList >> scrollToGroupSuchThat: aGroupMatchBlock itemSuchThat: anItemMatchBlock offset: anOffset [
	"Scroll the InfiniteELement to make the group's item position visible 
	with the given offset from resolved layout start.
	See {{gtMethod:BlInfiniteLinearLayout>>#scrollToPosition:offset:}}"

	<return: #TAsyncPromise>
	^ self
		groupSuchThat: aGroupMatchBlock
		itemSuchThat: anItemMatchBlock
		do: [ :anItemIndex | self scrollToIndex: anItemIndex offset: anOffset ]
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
	self groupsProvider: (BrStreamItemsProvider new
		stream: anAsyncStream;
		executionConfiguration: anAsyncFutureExecutionConfiguration)
]
