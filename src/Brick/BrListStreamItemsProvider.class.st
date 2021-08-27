Class {
	#name : 'BrListStreamItemsProvider',
	#superclass : 'BrAbstractListItemsProvider',
	#instVars : [
		'items',
		'mutex',
		'stream',
		'promise'
	],
	#category : 'Brick-List - Model'
}

{ #category : 'instance creation' }
BrListStreamItemsProvider class >> forCollection: aSequenceableCollection [
	^ self forStream: aSequenceableCollection asAsyncStream
]

{ #category : 'instance creation' }
BrListStreamItemsProvider class >> forStream: anAsyncStream [
	^ self new stream: anAsyncStream
]

{ #category : 'accessing' }
BrListStreamItemsProvider >> attachToListModel: aListModel [
	super attachToListModel: aListModel.
	
	aListModel dispatchEvent: (BrListModelItemsChangedEvent new viewModel: aListModel).

	(self shouldRequestNewItemsForIndex: 1)
		ifTrue: [ self requestNewItems ]
]

{ #category : 'accessing' }
BrListStreamItemsProvider >> currentItems [
	^ items
]

{ #category : 'testing' }
BrListStreamItemsProvider >> hasMoreItemsToLoad [
	^ stream isDone not
]

{ #category : 'initialization' }
BrListStreamItemsProvider >> initialize [
	super initialize.
	
	items := #().
	mutex := Monitor new.
	stream := AsyncEmptyStream new
]

{ #category : 'testing' }
BrListStreamItemsProvider >> isBoundaryNearIndex: anIndex [
	^ (self loadedItemsCount - anIndex) < 10
]

{ #category : 'testing' }
BrListStreamItemsProvider >> isRequestingItems [
	^ mutex critical: [
		promise notNil and: [ promise isFinished not ] ]
]

{ #category : 'accessing' }
BrListStreamItemsProvider >> itemAt: anIndex [
	| requestedItem |

	requestedItem := items at: anIndex.

	(self shouldRequestNewItemsForIndex: anIndex) ifTrue: [
		self requestNewItems ].

	^ requestedItem
]

{ #category : 'accessing' }
BrListStreamItemsProvider >> itemCount [
	<return: #Number>

	^ items size
]

{ #category : 'accessing' }
BrListStreamItemsProvider >> loadedItemsCount [
	^ items size
]

{ #category : 'api - accessing' }
BrListStreamItemsProvider >> requestNewItems [
	mutex critical: [ 
		promise := (self stream take: 100) collect await.
		promise
			onSuccessDo: [ :aResult |
				mutex critical: [ items := items, aResult ].
				listModel dispatchEvent: (BrListModelItemsChangedEvent new viewModel: listModel). ];
			onFailureDo: [ :anException |
				
			] ]
]

{ #category : 'testing' }
BrListStreamItemsProvider >> shouldRequestNewItemsForIndex: anIndex [
	self isRequestingItems
		ifTrue: [ ^ false ].
	
	^ self hasMoreItemsToLoad
		and: [ self isBoundaryNearIndex: anIndex ]
]

{ #category : 'accessing' }
BrListStreamItemsProvider >> stream [

	^ stream
]

{ #category : 'accessing' }
BrListStreamItemsProvider >> stream: aStream [
	stream := AsyncFuseStream stream: aStream
]
