Class {
	#name : 'BrColumnedStreamListModel',
	#superclass : 'BrColumnedListModel',
	#instVars : [
		'mutex',
		'isRequestingItems',
		'currentRequest',
		'stream'
	],
	#category : 'Brick-List - Model'
}

{ #category : 'testing' }
BrColumnedStreamListModel >> hasMoreItemsToLoad [
	^ stream isDone not
]

{ #category : 'initialization' }
BrColumnedStreamListModel >> initialize [
	super initialize.
	mutex := Mutex new.
	isRequestingItems := false.
]

{ #category : 'testing' }
BrColumnedStreamListModel >> isBoundaryNearIndex: anIndex [
	^ self itemCount - anIndex < 10
]

{ #category : 'testing' }
BrColumnedStreamListModel >> isRequestingItems [
	^ mutex critical: [ 
		isRequestingItems ]
]

{ #category : 'api - accessing' }
BrColumnedStreamListModel >> itemAt: anIndex [
	| requestedItem |

	requestedItem := super itemAt: anIndex.

	(self shouldRequestNewItemsForIndex: anIndex) ifTrue: [
		self requestNewItems ].

	^ requestedItem
]

{ #category : 'accessing' }
BrColumnedStreamListModel >> itemsProvider [
	^ stream
]

{ #category : 'api - accessing' }
BrColumnedStreamListModel >> loadNewItems [
	^ (self stream take: 100) collect wait
]

{ #category : 'accessing' }
BrColumnedStreamListModel >> loadedItems [ 
	^ self items
]

{ #category : 'api - accessing' }
BrColumnedStreamListModel >> requestNewItems [
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
BrColumnedStreamListModel >> shouldRequestNewItemsForIndex: anIndex [
	self isRequestingItems ifTrue: [ ^ false ].
	
	^ self hasMoreItemsToLoad
		and: [ self isBoundaryNearIndex: anIndex ]
]

{ #category : 'accessing' }
BrColumnedStreamListModel >> stream [
	^ stream
]

{ #category : 'accessing' }
BrColumnedStreamListModel >> stream: aStream [
	| initialItems |
	stream := AsyncFuseStream stream: aStream.
]
