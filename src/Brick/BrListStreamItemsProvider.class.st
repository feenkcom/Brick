Class {
	#name : #BrListStreamItemsProvider,
	#superclass : #BrAbstractListItemsProvider,
	#instVars : [
		'monitor',
		'buffer',
		'preloadAmount',
		'loadSinglesUntil',
		'preloadDuration'
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
	
	self notifyItemsChangedSynchronously: true.
	aListModel dispatchEvent: (BrListModelPromiseEnqueuedEvent new promise: buffer bufferLoadingPromise).
]

{ #category : #accessing }
BrListStreamItemsProvider >> currentItems [
	^ buffer
]

{ #category : #initialization }
BrListStreamItemsProvider >> defaultLoadSinglesUntil [
	^ 0
]

{ #category : #accessing }
BrListStreamItemsProvider >> defaultPreloadAmount [	
	^ 20
]

{ #category : #accessing }
BrListStreamItemsProvider >> defaultPreloadDuration [
	^ 300 milliseconds
]

{ #category : #initialization }
BrListStreamItemsProvider >> initialize [
	super initialize.
	
	monitor := Monitor new
]

{ #category : #accessing }
BrListStreamItemsProvider >> isDone [
	^ buffer isDone
]

{ #category : #accessing }
BrListStreamItemsProvider >> itemAt: anIndex [
	^ buffer at: anIndex
]

{ #category : #accessing }
BrListStreamItemsProvider >> itemCount [
	<return: #Number>

	^ buffer size
]

{ #category : #accessing }
BrListStreamItemsProvider >> loadSinglesUntil [
	^ loadSinglesUntil ifNil: [ loadSinglesUntil := self defaultLoadSinglesUntil]
]

{ #category : #initialization }
BrListStreamItemsProvider >> loadSinglesUntil: aNumber [
	loadSinglesUntil := aNumber.
	buffer ifNotNil: [ buffer loadSinglesUntil: aNumber ]
]

{ #category : #'private - event handling' }
BrListStreamItemsProvider >> onBufferChanged: anAnnouncement [

	listModel ifNotNil: [ :aListModel | 
		aListModel dispatchEvent: (BrListModelItemsAddedEvent new
				 addedItemsCount: anAnnouncement newItems size;
				 firstAddedItemIndex: anAnnouncement index) ]
]

{ #category : #'private - event handling' }
BrListStreamItemsProvider >> onBufferDone: anAnnouncement [

	listModel dispatchEvent: BrListItemsProviderDoneEvent new
]

{ #category : #'private - event handling' }
BrListStreamItemsProvider >> onBufferStartedLoading: anAnnouncement [

	listModel ifNotNil: [ :aListModel | 
		aListModel dispatchEvent: BrListItemsProviderStartedLoadingEvent new ]
]

{ #category : #accessing }
BrListStreamItemsProvider >> preloadAmount [

	^ preloadAmount ifNil: [ preloadAmount := self defaultPreloadAmount ]
]

{ #category : #initialization }
BrListStreamItemsProvider >> preloadAmount: aNumber [
	preloadAmount := aNumber.
	buffer ifNotNil: [ buffer preloadAmount: aNumber ]
]

{ #category : #accessing }
BrListStreamItemsProvider >> preloadDuration [
	^ preloadDuration ifNil: [ preloadDuration := self defaultPreloadDuration ]
]

{ #category : #initialization }
BrListStreamItemsProvider >> preloadDuration: aDuration [
	preloadDuration := aDuration.
	buffer ifNotNil: [ buffer preloadDuration: aDuration ]
]

{ #category : #'api - loading' }
BrListStreamItemsProvider >> preloadUntilFoundSuchThat: aBlock [
	<return: #TAsyncPromise>

	^ (buffer preloadUntilFoundSuchThat: aBlock)
		then: [ :anAsyncStreamBufferItem | anAsyncStreamBufferItem index ]
]

{ #category : #'private - accessing' }
BrListStreamItemsProvider >> privateSetStreamBuffer: aStreamBuffer [

	monitor critical: [ 
		buffer := aStreamBuffer
			          preloadAmount: self preloadAmount;
			          loadSinglesUntil: self loadSinglesUntil.
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
		self isDone ifTrue: [ 
			listModel ifNotNil: [ 
				listModel dispatchEvent: BrListItemsProviderDoneEvent new ] ] ]
]

{ #category : #'private - accessing' }
BrListStreamItemsProvider >> privateSetTransitionBuffer: aStreamTransitionBuffer [
	monitor critical: [
		"We do not notify items changed because the transition buffer has the same items"
		buffer := aStreamTransitionBuffer.

		buffer bufferLoadingPromise then: [
			monitor critical: [
				buffer == aStreamTransitionBuffer
					ifTrue: [ self privateSetStreamBuffer: buffer newBuffer ] ] ] ]
]

{ #category : #initialization }
BrListStreamItemsProvider >> stream: aStream [
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
						privateSetStreamBuffer: (AsyncStreamBuffer new
								preloadAmount: self preloadAmount;
								preloadDuration: self preloadDuration;
								loadSinglesUntil: self loadSinglesUntil;
								executionConfiguration: (AsyncFutureExecutionConfiguration new
										highPriority;
										customGroup: #ScrollingList);
								stream: aStream) ] ]
]
