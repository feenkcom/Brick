Class {
	#name : 'BrColumnedLazyListModel',
	#superclass : 'BrColumnedListModel',
	#instVars : [
		'mutex',
		'isRequestingItems',
		'currentRequest'
	],
	#category : 'Brick-List - Model'
}

{ #category : 'testing' }
BrColumnedLazyListModel >> hasMoreItemsToLoad [
	^ self itemCount < self itemsProvider totalItemsCount
]

{ #category : 'initialization' }
BrColumnedLazyListModel >> initialize [
	super initialize.
	mutex := Mutex new.
	isRequestingItems := false.
]

{ #category : 'testing' }
BrColumnedLazyListModel >> isBoundaryNearIndex: anIndex [
	^ self itemCount - anIndex < 10
]

{ #category : 'testing' }
BrColumnedLazyListModel >> isRequestingItems [
	^ mutex critical: [ 
		isRequestingItems ]
]

{ #category : 'api - accessing' }
BrColumnedLazyListModel >> itemAt: anIndex [
	| requestedItem |
	requestedItem := super itemAt: anIndex.
	
	(self shouldRequestNewItemsForIndex: anIndex) ifTrue: [
		self requestNewItems ].
	
	^ requestedItem
]

{ #category : 'accessing' }
BrColumnedLazyListModel >> itemsProvider [
	^ itemsProvider
]

{ #category : 'accessing' }
BrColumnedLazyListModel >> itemsProvider: anItemsProvider [
	| initialItems |
	itemsProvider := anItemsProvider.
	initialItems := itemsProvider totalItemsCount > 0
		ifTrue: [ itemsProvider retrieveItemsFromIndex: 1 ]
		ifFalse: [ #() ].
	self items: initialItems
]

{ #category : 'api - accessing' }
BrColumnedLazyListModel >> loadNewItems [
	^ self itemsProvider 
		retrieveItemsFromIndex: self loadedItems size + 1
]

{ #category : 'accessing' }
BrColumnedLazyListModel >> loadedItems [ 
	^ self items
]

{ #category : 'api - accessing' }
BrColumnedLazyListModel >> requestNewItems [
	"mutex critical: [ 
		isRequestingItems := true.
		currentRequest := BlTktWorkerProvider highUICPUBoundPool
			future: [ self loadNewItems ] ].
		
	currentRequest
		onSuccessDo: [ :aResult | 
			self items: items, aResult.
			mutex critical: [ isRequestingItems := false ] ];
		onFailureDo: [ :anException | 
			mutex critical: [ isRequestingItems := false ] ].
		
	currentRequest waitForCompletion: 10 seconds"
	
	self items: items, self loadNewItems
	
]

{ #category : 'testing' }
BrColumnedLazyListModel >> shouldRequestNewItemsForIndex: anIndex [
	self isRequestingItems ifTrue: [ ^ false ].
	
	^ self hasMoreItemsToLoad
		and: [ self isBoundaryNearIndex: anIndex ]
]
