Class {
	#name : #BrListStreamItemsProvider,
	#superclass : #BrAbstractListItemsProvider,
	#instVars : [
		'items',
		'mutex',
		'stream',
		'promise',
		'preloadAmount'
	],
	#category : #'Brick-List - Model'
}

{ #category : #'instance creation' }
BrListStreamItemsProvider class >> forCollection: aSequenceableCollection [
	^ self forStream: aSequenceableCollection asAsyncStream
]

{ #category : #'instance creation' }
BrListStreamItemsProvider class >> forStream: anAsyncStream [
	^ self new stream: anAsyncStream
]

{ #category : #accessing }
BrListStreamItemsProvider >> attachToListModel: aListModel [
	super attachToListModel: aListModel.
	
	aListModel dispatchEvent: (BrListModelItemsChangedEvent new viewModel: aListModel).

	(self shouldRequestNewItemsForIndex: 1)
		ifTrue: [ self requestNewItems ]
]

{ #category : #accessing }
BrListStreamItemsProvider >> currentItems [
	^ items
]

{ #category : #testing }
BrListStreamItemsProvider >> hasMoreItemsToLoad [
	^ stream isDone not
]

{ #category : #initialization }
BrListStreamItemsProvider >> initialize [
	super initialize.
	
	items := #().
	mutex := Monitor new.
	stream := AsyncEmptyStream new.
	preloadAmount := 100
]

{ #category : #testing }
BrListStreamItemsProvider >> isBoundaryNearIndex: anIndex [
	| itemsUntilEdge percentageLeftUntilEdge | 

	itemsUntilEdge := self loadedItemsCount - anIndex.
	(itemsUntilEdge > self preloadAmount)
		ifTrue: [ ^ false ].

	percentageLeftUntilEdge := (itemsUntilEdge / self preloadAmount) * 100.0.
	^ percentageLeftUntilEdge < 20
]

{ #category : #testing }
BrListStreamItemsProvider >> isRequestingItems [
	^ mutex critical: [
		promise notNil and: [ promise isFinished not ] ]
]

{ #category : #accessing }
BrListStreamItemsProvider >> itemAt: anIndex [
	| requestedItem |

	requestedItem := items at: anIndex.

	(self shouldRequestNewItemsForIndex: anIndex) ifTrue: [
		self requestNewItems ].

	^ requestedItem
]

{ #category : #accessing }
BrListStreamItemsProvider >> itemCount [
	<return: #Number>

	^ items size
]

{ #category : #accessing }
BrListStreamItemsProvider >> loadedItemsCount [
	^ items size
]

{ #category : #accessing }
BrListStreamItemsProvider >> preloadAmount [

	^ preloadAmount
]

{ #category : #initialization }
BrListStreamItemsProvider >> preloadAmount: aNumber [
	preloadAmount := aNumber
]

{ #category : #'api - accessing' }
BrListStreamItemsProvider >> requestNewItems [
	mutex critical: [ 
		promise := (self stream take: self preloadAmount) toArray await.
		promise
			onSuccessDo: [ :aResult |
				mutex critical: [ items := items, aResult ].
				listModel dispatchEvent: (BrListModelItemsChangedEvent new viewModel: listModel). ];
			onFailureDo: [ :anException |
				"Logging the error on the transcript only shows the exception, not where it came from.
				Emit the exception as well so that it can be found with a beacon logger (which includes the stack)."
				anException emit.
				NonInteractiveTranscript stderr
					nextPutAll: anException printString;
					cr;
					flush ] ]
]

{ #category : #testing }
BrListStreamItemsProvider >> shouldRequestNewItemsForIndex: anIndex [
	self isRequestingItems
		ifTrue: [ ^ false ].
	
	^ self hasMoreItemsToLoad
		and: [ self isBoundaryNearIndex: anIndex ]
]

{ #category : #accessing }
BrListStreamItemsProvider >> stream [

	^ stream
]

{ #category : #initialization }
BrListStreamItemsProvider >> stream: aStream [
	stream := AsyncFuseStream stream: aStream
]
