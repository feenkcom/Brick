Class {
	#name : 'BrSimpleLazyListModel',
	#superclass : 'BrSimpleListModel',
	#instVars : [
		'itemsProvider',
		'mutex',
		'isRequestingItems',
		'currentRequest'
	],
	#category : 'Brick-List - Model'
}

{ #category : 'initialization' }
BrSimpleLazyListModel >> initialize [
	super initialize.
	mutex := Mutex new.
	isRequestingItems := false.
]

{ #category : 'testing' }
BrSimpleLazyListModel >> isBoundaryNearIndex: anIndex [
	^ anIndex < (self itemCount - 100)
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
		self requestNewItemsForIndex: anIndex ].
	
	^ requestedItem
]

{ #category : 'accessing' }
BrSimpleLazyListModel >> itemsProvider [
	^ itemsProvider
]

{ #category : 'accessing' }
BrSimpleLazyListModel >> itemsProvider: anObject [
	itemsProvider := anObject
]

{ #category : 'api - accessing' }
BrSimpleLazyListModel >> loadNewItemsFromLastIndex: anIndex [
	^ self itemsProvider loadNewItemsFromLastIndex: anIndex.
	
]

{ #category : 'accessing' }
BrSimpleLazyListModel >> loadedItems [ 
	^ self items
]

{ #category : 'api - accessing' }
BrSimpleLazyListModel >> requestNewItemsForIndex: anIndex [
	mutex critical: [ 
		currentRequest := BlTktWorkerProvider highUICPUBoundPool
			future: [ 
				self loadNewItemsFromLastIndex: anIndex ] ].
		
	currentRequest
		onSuccessDo: [ :aResult | 
			items addAll: aResult.
			mutex critical: [ isRequestingItems := false ] ];
		onFailureDo: [ :anException | 
			mutex critical: [ isRequestingItems := false ] ] 
]

{ #category : 'testing' }
BrSimpleLazyListModel >> shouldRequestNewItemsForIndex: anIndex [
	self isRequestingItems ifTrue: [ ^ false ].
	
	^ (self itemsProvider hasItemsAfterIndex: anIndex)
		and: [ self isBoundaryNearIndex: anIndex ]
]
