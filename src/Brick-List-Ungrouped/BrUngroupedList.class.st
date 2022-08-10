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
BrUngroupedList >> items [
	^ self viewModel items
]

{ #category : #'api - accessing' }
BrUngroupedList >> items: aCollectionOfValues [
	self itemsProvider: (BrSequenceableCollectionItemsProvider new collection: aCollectionOfValues)
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
BrUngroupedList >> scrollToItemSuchThat: aBlock [
	<return: #TAsyncPromise>

	^ (self viewModel itemsProvider preloadUntilFoundSuchThat: aBlock)
		then: [ :anItemIndex | self enqueueTask: (BlTaskAction new
			action: [ self scrollToIndex: anItemIndex ]) ]
]

{ #category : #'api - accessing' }
BrUngroupedList >> stream: anAsyncStream [
	self itemsProvider: (BrStreamItemsProvider new stream: anAsyncStream)
]
