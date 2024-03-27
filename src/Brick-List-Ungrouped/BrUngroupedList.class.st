Class {
	#name : #BrUngroupedList,
	#superclass : #BrList,
	#category : #'Brick-List-Ungrouped-Elements'
}

{ #category : #accessing }
BrUngroupedList >> defaultListModel [
	^ BrUngroupedListModel new
]

{ #category : #'api - accessing' }
BrUngroupedList >> itemSuchThat: aMatchBlock do: anActionBlock [
	"Attempt to find the first item matching a given block which may involve
	preloading items until such item is found.
	Evaluate an action block synchronously if an item was already preloaded, otherwise schedule
	execution in a UI process"
	<return: #TAsyncPromise>
	| aPromise |
	
	aPromise := self itemsProvider
		itemSuchThat: aMatchBlock
		do: [ :anIndex :isSynchronous |
			anIndex > 0 ifTrue: [ 
				isSynchronous
					ifTrue: [
						anActionBlock value: anIndex.
						^ anIndex asAsyncPromise ]
					ifFalse: [ self enqueueTask: (BlTaskAction new
						action: [ anActionBlock value: anIndex ]) ] ] ].

	self enqueueTask: (BlPromiseTask new promise: aPromise).
	
	^ aPromise
]

{ #category : #'api - accessing' }
BrUngroupedList >> items [
	^ self viewModel items
]

{ #category : #'api - accessing' }
BrUngroupedList >> items: aCollectionOfValues [
	self itemsProvider: (BrSequenceableCollectionItemsProvider new collection: aCollectionOfValues)
]

{ #category : #'api - accessing' }
BrUngroupedList >> itemsProvider [
	^ self viewModel itemsProvider
]

{ #category : #'api - accessing' }
BrUngroupedList >> itemsProvider: aBrAbstractListItemsProvider [
	self viewModel itemsProvider: aBrAbstractListItemsProvider
]

{ #category : #'api - scrolling' }
BrUngroupedList >> scrollToItem: anObject [
	"Request a scrollable widget to scroll to a given item"
	<return: #TAsyncPromise>
		
	^ self scrollToItemSuchThat: [ :eachItem | eachItem = anObject ]
]

{ #category : #'api - scrolling' }
BrUngroupedList >> scrollToItemSuchThat: aMatchBlock [
	<return: #TAsyncPromise>

	^ self
		itemSuchThat: aMatchBlock
		do: [ :anItemIndex | self scrollToIndex: anItemIndex ]
]

{ #category : #'api - scrolling' }
BrUngroupedList >> scrollToItemSuchThat: aMatchBlock offset: anOffset [
	"Scroll the InfiniteELement to make the datasource position visible 
	with the given offset from resolved layout start.
	See {{gtMethod:BlInfiniteLinearLayout>>#scrollToPosition:offset:}}"
	<return: #TAsyncPromise>

	^ self
		itemSuchThat: aMatchBlock
		do: [ :anItemIndex | self scrollToIndex: anItemIndex offset: anOffset ]
]

{ #category : #'api - accessing' }
BrUngroupedList >> stream: anAsyncStream [
	self
		stream: anAsyncStream
		executionConfiguration: BrStreamItemsProvider defaultExecutionConfiguration
]

{ #category : #'api - accessing' }
BrUngroupedList >> stream: anAsyncStream executionConfiguration: anAsyncFutureExecutionConfiguration [
	(self viewModel itemsProvider isKindOf: BrStreamItemsProvider)
		ifTrue: [
			self viewModel itemsProvider
				stream: anAsyncStream;
				executionConfiguration: anAsyncFutureExecutionConfiguration ]
		ifFalse: [ self itemsProvider: (BrStreamItemsProvider new
			stream: anAsyncStream;
			executionConfiguration: anAsyncFutureExecutionConfiguration) ]
]
