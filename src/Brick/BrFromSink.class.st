Class {
	#name : #BrFromSink,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TAsyncSink',
	#classTraits : 'TBrLayoutResizable classTrait + TAsyncSink classTrait',
	#instVars : [
		'updater',
		'collection',
		'recent',
		'dataSnapshot',
		'elementStencil',
		'elementDataBinder',
		'element'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #'api - accessing' }
BrFromSink >> dataBinder: aFromFutureDataBinder [
	elementDataBinder := aFromFutureDataBinder asStencilBuilder: BrFromFutureDataBinder
]

{ #category : #initialization }
BrFromSink >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
BrFromSink >> initialize [
	super initialize.

	collection := AsyncSharedOrderedCollection new.
	recent := AsyncSharedOrderedCollection new.
	dataSnapshot := BrFromFutureDataSnapshot new setPending: (BrFromStreamData new allValues: collection; newValues: #()).

	updater := BrElementUpdater new.
	updater element: self selector: #privateUpdateElement
]

{ #category : #'hooks - children' }
BrFromSink >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	self privateUpdateElement
]

{ #category : #'api - sink' }
BrFromSink >> pollClose: anAsynchronousContext [
	"Flush any remaining output and close this sink, if necessary.
	Returns Poll::Ready(true) when no buffered items remain and the sink has been successfully closed.
	Returns Poll::Pending if there is more work left to do, in which case the current task is scheduled (via cx.waker().wake_by_ref()) to wake up when poll_close should be called again.
	If this function encounters an error, the sink should be considered to have failed permanently, and no more Sink methods should be called."
	<return: #AsyncPoll>
	
	dataSnapshot := BrFromFutureDataSnapshot new setData: (BrFromStreamData new allValues: collection; newValues: #()).
	updater requestUpdate.
	
	^ AsyncPoll ready: true
]

{ #category : #'api - sink' }
BrFromSink >> pollFlush: anAsynchronousContext [
	"Flush any remaining output from this sink.
	Returns Poll::Ready(true) when no buffered items remain. If this value is returned then it is guaranteed that all previous values sent via #startSend: have been flushed.
	Returns Poll::Pending if there is more work left to do, in which case the current task is scheduled (via waker) to wake up when #pollFlush: should be called again.
	In most cases, if the sink encounters an error, the sink will permanently be unable to receive items."
	<return: #AsyncPoll>

	^ AsyncPoll ready: true
]

{ #category : #'api - sink' }
BrFromSink >> pollReady: anAsynchronousContext [
	"Attempts to prepare the Sink to receive a value.
	This method must be called and return Poll::Ready(true) prior to each call to start_send.
	This method returns Poll::Ready once the underlying sink is ready to receive data. If this method returns Poll::Pending, the current task is registered to be notified (via waker) when #pollReady: should be called again.
	In most cases, if the sink encounters an error, the sink will permanently be unable to receive items."
	<return: #AsyncPoll>
	
	^ AsyncPoll ready: true
]

{ #category : #'private - update' }
BrFromSink >> privateUpdateElement [
	| aRecentData aDataSnapshot |
	
	element ifNil: [ element := elementStencil asElement ].
	
	recent critical: [
		aRecentData := recent asArray.
		recent removeAll ].
	
	aDataSnapshot := dataSnapshot.

	aDataSnapshot
		ifSuccess: [ aDataSnapshot data newValues: aRecentData ]
		ifPending: [ aDataSnapshot initialData newValues: aRecentData ].

	elementDataBinder 
		element: element;
		data: aDataSnapshot;
		build.

	(self hasChild: element)
		ifTrue: [ ^ self ].

	element removeFromParent.
	self addChild: element
]

{ #category : #'api - sink' }
BrFromSink >> startSend: anObject [
	"Begin the process of sending a value to the sink. Each call to this function must be preceded by a successful call to pollReady which returned Poll::Ready(true).
	As the name suggests, this method only begins the process of sending the item. If the sink employs buffering, the item isn't fully processed until the buffer is fully flushed. Since sinks are designed to work with asynchronous I/O, the process of actually writing out the data to an underlying object takes place asynchronously. You must use #pollFlush: or #pollClose: in order to guarantee completion of a send.
	Implementations of #pollReady: and #startSend: will usually involve flushing behind the scenes in order to make room for new messages. It is only necessary to call #pollFlush: if you need to guarantee that all of the items placed into the Sink have been sent.
	In most cases, if the sink encounters an error, the sink will permanently be unable to receive items."
	
	collection add: anObject.
	recent add: anObject.
	updater requestUpdate
]

{ #category : #'api - accessing' }
BrFromSink >> stencil: aStencil [
	elementStencil := aStencil asStencil
]
