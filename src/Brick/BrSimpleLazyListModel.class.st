Class {
	#name : 'BrSimpleLazyListModel',
	#superclass : 'BrSimpleListModel',
	#instVars : [
		'mutex',
		'isRequestingItems',
		'currentRequest'
	],
	#category : 'Brick-List - Model'
}

{ #category : 'testing' }
BrSimpleLazyListModel >> hasMoreItemsToLoad [
	^ self itemCount < self itemsProvider totalItemsCount
]

{ #category : 'initialization' }
BrSimpleLazyListModel >> initialize [
	super initialize.
	mutex := Mutex new.
	isRequestingItems := false.
]

{ #category : 'testing' }
BrSimpleLazyListModel >> isBoundaryNearIndex: anIndex [
	^ self itemCount - anIndex < 10
]

{ #category : 'testing' }
BrSimpleLazyListModel >> isRequestingItems [
	^ mutex critical: [ 
		isRequestingItems ]
]

{ #category : 'api - accessing' }
BrSimpleLazyListModel >> itemAt: anIndex [
	| requestedItem |
	requestedItem := super itemAt: anIndex.
	
	(self shouldRequestNewItemsForIndex: anIndex) ifTrue: [
		self requestNewItems ].
	
	^ requestedItem
]

{ #category : 'accessing' }
BrSimpleLazyListModel >> itemsProvider [
	^ itemsProvider
]

{ #category : 'accessing' }
BrSimpleLazyListModel >> itemsProvider: anItemsProvider [
	| initialItems |
	itemsProvider := anItemsProvider.
	initialItems := itemsProvider totalItemsCount > 0
		ifTrue: [ itemsProvider retrieveItemsFromIndex: 1 ]
		ifFalse: [ #() ].
	self items: initialItems
]

{ #category : 'api - accessing' }
BrSimpleLazyListModel >> loadNewItems [
	^ self itemsProvider 
		retrieveItemsFromIndex: self loadedItems size + 1
]

{ #category : 'accessing' }
BrSimpleLazyListModel >> loadedItems [ 
	^ self items
]

{ #category : 'api - accessing' }
BrSimpleLazyListModel >> requestNewItems [
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
BrSimpleLazyListModel >> shouldRequestNewItemsForIndex: anIndex [
	self isRequestingItems ifTrue: [ ^ false ].
	
	^ self hasMoreItemsToLoad
		and: [ self isBoundaryNearIndex: anIndex ]
]
