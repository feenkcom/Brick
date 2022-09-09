Class {
	#name : #BrStreamItemsProvider,
	#superclass : #BrItemsProvider,
	#instVars : [
		'monitor',
		'buffer',
		'preloadAmount',
		'loadSinglesUntil',
		'preloadDuration',
		'executionConfiguration'
	],
	#category : #'Brick-! Core - Item Providers'
}

{ #category : #'instance creation' }
BrStreamItemsProvider class >> forCollection: aSequenceableCollection [
	^ self forStream: aSequenceableCollection asAsyncStream
]

{ #category : #'instance creation' }
BrStreamItemsProvider class >> forStream: anAsyncStream [
	^ self new stream: anAsyncStream
]

{ #category : #accessing }
BrStreamItemsProvider >> attachToListModel: aListModel [
	super attachToListModel: aListModel.
	
	self notifyItemsChangedSynchronously: true.
	aListModel dispatchEvent: (BrItemsProviderPromiseEnqueuedEvent new promise: buffer bufferLoadingPromise).
]

{ #category : #accessing }
BrStreamItemsProvider >> currentItems [
	^ buffer
]

{ #category : #initialization }
BrStreamItemsProvider >> defaultExecutionConfiguration [
	^ AsyncFutureExecutionConfiguration new
			highPriority;
			customGroup: #ScrollingList
]

{ #category : #initialization }
BrStreamItemsProvider >> defaultLoadSinglesUntil [
	^ 0
]

{ #category : #accessing }
BrStreamItemsProvider >> defaultPreloadAmount [	
	^ 20
]

{ #category : #accessing }
BrStreamItemsProvider >> defaultPreloadDuration [
	^ 300 milliSeconds
]

{ #category : #accessing }
BrStreamItemsProvider >> executionConfiguration [

	^ executionConfiguration
]

{ #category : #initialization }
BrStreamItemsProvider >> executionConfiguration: anObject [
	executionConfiguration := anObject.
	buffer ifNotNil: [ buffer executionConfiguration: anObject ]
]

{ #category : #'api - loading' }
BrStreamItemsProvider >> finish [
	buffer ifNotNil: [ buffer stop ]
]

{ #category : #initialization }
BrStreamItemsProvider >> initialize [
	super initialize.
	
	monitor := Monitor new.
	executionConfiguration := self defaultExecutionConfiguration
]

{ #category : #accessing }
BrStreamItemsProvider >> isDone [
	^ buffer isDone
]

{ #category : #accessing }
BrStreamItemsProvider >> itemAt: anIndex [
	^ buffer at: anIndex
]

{ #category : #accessing }
BrStreamItemsProvider >> itemCount [
	<return: #Number>

	^ buffer size
]

{ #category : #accessing }
BrStreamItemsProvider >> loadSinglesUntil [
	^ loadSinglesUntil ifNil: [ loadSinglesUntil := self defaultLoadSinglesUntil]
]

{ #category : #initialization }
BrStreamItemsProvider >> loadSinglesUntil: aNumber [
	loadSinglesUntil := aNumber.
	buffer ifNotNil: [ buffer loadSinglesUntil: aNumber ]
]

{ #category : #'private - event handling' }
BrStreamItemsProvider >> onBufferChanged: anAnnouncement [
	self
		notifyItemsLoaded: anAnnouncement newItems size
		at: anAnnouncement index.

	listModel ifNotNil: [ :aListModel | 
		aListModel dispatchEvent: (BrListModelItemsAddedEvent new
				 addedItemsCount: anAnnouncement newItems size;
				 firstAddedItemIndex: anAnnouncement index) ]
]

{ #category : #'private - event handling' }
BrStreamItemsProvider >> onBufferDone: anAnnouncement [
	self notifyItemsDone
]

{ #category : #'private - event handling' }
BrStreamItemsProvider >> onBufferStartedLoading: anAnnouncement [
	| anEvent |
	
	anEvent := BrItemsProviderStartedLoadingEvent new
		itemsProvider: self;
		initialAmountOfItems: anAnnouncement initialAmountOfItems.
	
	self announce: anEvent.
	
	listModel ifNotNil: [ :aListModel | 
		aListModel dispatchEvent: anEvent.
		aListModel dispatchEvent: (BrItemsProviderPromiseEnqueuedEvent new promise: anAnnouncement bufferLoadingPromise). ]
]

{ #category : #accessing }
BrStreamItemsProvider >> preloadAmount [

	^ preloadAmount ifNil: [ preloadAmount := self defaultPreloadAmount ]
]

{ #category : #initialization }
BrStreamItemsProvider >> preloadAmount: aNumber [
	preloadAmount := aNumber.
	buffer ifNotNil: [ buffer preloadAmount: aNumber ]
]

{ #category : #accessing }
BrStreamItemsProvider >> preloadDuration [
	^ preloadDuration ifNil: [ preloadDuration := self defaultPreloadDuration ]
]

{ #category : #initialization }
BrStreamItemsProvider >> preloadDuration: aDuration [
	preloadDuration := aDuration.
	buffer ifNotNil: [ buffer preloadDuration: aDuration ]
]

{ #category : #'api - loading' }
BrStreamItemsProvider >> preloadUntilFoundSuchThat: aBlock [
	<return: #TAsyncPromise>

	^ (buffer preloadUntilFoundSuchThat: aBlock)
		then: [ :anAsyncStreamBufferItem | anAsyncStreamBufferItem index ]
]

{ #category : #'private - accessing' }
BrStreamItemsProvider >> privateSetStreamBuffer: aStreamBuffer [

	monitor critical: [ 
		buffer := aStreamBuffer.
		self notifyItemsChangedSynchronously: false.
		buffer
			when: AsyncStreamBufferStartedLoading
			send: #onBufferStartedLoading:
			to: self.
		buffer
			when: AsyncStreamBufferChanged
			send: #onBufferChanged:
			to: self.
		buffer when: AsyncStreamBufferDone send: #onBufferDone: to: self.
		self isDone ifTrue: [ self notifyItemsDone ] ]
]

{ #category : #'private - accessing' }
BrStreamItemsProvider >> privateSetTransitionBuffer: aStreamTransitionBuffer [
	monitor critical: [
		"We do not notify items changed because the transition buffer has the same items"
		buffer := aStreamTransitionBuffer.

		buffer bufferLoadingPromise then: [
			monitor critical: [
				buffer == aStreamTransitionBuffer
					ifTrue: [ self privateSetStreamBuffer: buffer newBuffer ] ] ] ]
]

{ #category : #accessing }
BrStreamItemsProvider >> sinks [
	^ buffer
		ifNil: [ #() ]
		ifNotNil: [ :aBuffer | aBuffer sinks ]
]

{ #category : #initialization }
BrStreamItemsProvider >> stream: aStream [
	"Change a stream to the given one"

	self
		stream: aStream
		sinks: #()
]

{ #category : #initialization }
BrStreamItemsProvider >> stream: aStream sinks: aCollectionOfSinks [
	"Change a stream to the given one"

	monitor
		critical: [ buffer
				ifNotNil: [ :aPreviousBuffer | 
					aPreviousBuffer unsubscribe: self.
					self
						privateSetTransitionBuffer: (AsyncStreamTransitionBuffer
								forStream: aStream
								previousBuffer: aPreviousBuffer) ]
				ifNil: [ self
						privateSetStreamBuffer: (AsyncSinkStreamBuffer new
								preloadAmount: self preloadAmount;
								preloadDuration: self preloadDuration;
								loadSinglesUntil: self loadSinglesUntil;
								executionConfiguration: self executionConfiguration;
								stream: aStream sinks: aCollectionOfSinks) ] ]
]
