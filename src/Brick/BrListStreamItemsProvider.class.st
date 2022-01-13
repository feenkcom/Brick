Class {
	#name : #BrListStreamItemsProvider,
	#superclass : #BrAbstractListItemsProvider,
	#instVars : [
		'monitor',
		'buffer'
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
BrListStreamItemsProvider >> initialize [
	super initialize.
	
	monitor := Monitor new
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

{ #category : #'private - event handling' }
BrListStreamItemsProvider >> onBufferChanged: anAnnouncement [
	listModel
		ifNotNil: [ :aListModel |
			aListModel dispatchEvent: (BrListModelItemsAddedEvent new
				addedItemsCount: anAnnouncement newItems size;
				firstAddedItemIndex: anAnnouncement index) ]
]

{ #category : #accessing }
BrListStreamItemsProvider >> preloadAmount [
	^ 20
]

{ #category : #initialization }
BrListStreamItemsProvider >> preloadAmount: aNumber [
	
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
		buffer := aStreamBuffer.
		self notifyItemsChangedSynchronously: false.		
		buffer
			when: AsyncStreamBufferChanged
			send: #onBufferChanged:
			to: self ]
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

	monitor critical: [
		buffer
			ifNotNil: [ :aPreviousBuffer |
				aPreviousBuffer unsubscribe: self.
				self privateSetTransitionBuffer: (AsyncStreamTransitionBuffer forStream: aStream previousBuffer: aPreviousBuffer) ]
			ifNil: [ self privateSetStreamBuffer: (AsyncStreamBuffer new
				executionConfiguration: (AsyncFutureExecutionConfiguration new highPriority; customGroup: #ScrollingList);
				stream: aStream) ] ]
]
