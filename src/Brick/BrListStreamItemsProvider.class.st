Class {
	#name : #BrListStreamItemsProvider,
	#superclass : #BrAbstractListItemsProvider,
	#instVars : [
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
	
	aListModel dispatchEvent: (BrListModelItemsChangedEvent new viewModel: aListModel)
]

{ #category : #accessing }
BrListStreamItemsProvider >> currentItems [
	^ buffer
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
	listModel dispatchEvent: (BrListModelItemsAddedEvent new
		addedItemsCount: anAnnouncement newItems size;
		firstAddedItemIndex: anAnnouncement index)
]

{ #category : #accessing }
BrListStreamItemsProvider >> preloadAmount [
	^ 20
]

{ #category : #initialization }
BrListStreamItemsProvider >> preloadAmount: aNumber [
	
]

{ #category : #initialization }
BrListStreamItemsProvider >> stream: aStream [
	buffer := AsyncStreamBuffer forStream: aStream.
	buffer
		when: AsyncStreamBufferChanged
		send: #onBufferChanged:
		to: self
]
