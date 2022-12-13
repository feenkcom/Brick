Class {
	#name : #BrAsyncElementSink,
	#superclass : #Object,
	#traits : 'TAsyncSink',
	#classTraits : 'TAsyncSink classTrait',
	#instVars : [
		'updater',
		'sink',
		'whenSuccess',
		'whenPending',
		'isClosed'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #'instance creation' }
BrAsyncElementSink class >> on: anElement [
	^ self new element: anElement
]

{ #category : #'api - sink' }
BrAsyncElementSink >> cleanSink [
	"Resets the sink to its original state"
	
	sink cleanSink.
	isClosed := false.
	updater requestUpdate
]

{ #category : #initialization }
BrAsyncElementSink >> element: anElement [
	updater := BrElementUpdater new
		element: anElement;
		action: (MessageSend receiver: self selector: #privateUpdateElement).

	sink := AsyncDrainSink new.
	isClosed := false
]

{ #category : #'api - accessing' }
BrAsyncElementSink >> forwardStream: anAsyncStream [
	"Forward a given stream into the sink, closing the sink afterwards"
	<return: #TAsyncPromise>
	| aPromise |
	
	aPromise := (anAsyncStream forward: self) asAsyncPromise.
	updater element enqueueTask: (BlPromiseTask new promise: aPromise).
	^ aPromise
]

{ #category : #initialization }
BrAsyncElementSink >> initialize [
	super initialize.
	
	whenPending := nil. "[ :anElement :aData | ]".
	whenSuccess := nil.  "[ :anElement :aData | ]"
]

{ #category : #'api - sink' }
BrAsyncElementSink >> pollClose: anAsynchronousContext [
	"Flush any remaining output and close this sink, if necessary.
	Returns Poll::Ready(true) when no buffered items remain and the sink has been successfully closed.
	Returns Poll::Pending if there is more work left to do, in which case the current task is scheduled (via cx.waker().wake_by_ref()) to wake up when poll_close should be called again.
	If this function encounters an error, the sink should be considered to have failed permanently, and no more Sink methods should be called."
	<return: #AsyncPoll>
	
	^ (sink pollClose: anAsynchronousContext)
		ifReady: [ :aReadyPoll |
			isClosed := true.
			whenSuccess ifNotNil: [ updater requestUpdate ].
			aReadyPoll ]
		ifPending: [ :aPendingPoll | aPendingPoll ]
]

{ #category : #'api - sink' }
BrAsyncElementSink >> pollFlush: anAsynchronousContext [
	"Flush any remaining output from this sink.
	Returns Poll::Ready(true) when no buffered items remain. If this value is returned then it is guaranteed that all previous values sent via #startSend: have been flushed.
	Returns Poll::Pending if there is more work left to do, in which case the current task is scheduled (via waker) to wake up when #pollFlush: should be called again.
	In most cases, if the sink encounters an error, the sink will permanently be unable to receive items."
	<return: #AsyncPoll>

	^ sink pollFlush: anAsynchronousContext
]

{ #category : #'api - sink' }
BrAsyncElementSink >> pollReady: anAsynchronousContext [
	"Attempts to prepare the Sink to receive a value.
	This method must be called and return Poll::Ready(true) prior to each call to start_send.
	This method returns Poll::Ready once the underlying sink is ready to receive data. If this method returns Poll::Pending, the current task is registered to be notified (via waker) when #pollReady: should be called again.
	In most cases, if the sink encounters an error, the sink will permanently be unable to receive items."
	<return: #AsyncPoll>
	
	^ sink pollReady: anAsynchronousContext
]

{ #category : #'private - update' }
BrAsyncElementSink >> privateUpdateElement [	
	whenPending ifNotNil: [ :aBlock | aBlock cull: updater element cull: sink ].
	isClosed
		ifTrue: [ whenSuccess ifNotNil: [ :aBlock | aBlock cull: updater element cull: sink ] ]
]

{ #category : #'api - accessing' }
BrAsyncElementSink >> sink [
	^ sink
]

{ #category : #'api - accessing' }
BrAsyncElementSink >> sink: anAsyncSink [
	sink := anAsyncSink
]

{ #category : #'api - sink' }
BrAsyncElementSink >> startSend: anObject [
	"Begin the process of sending a value to the sink. Each call to this function must be preceded by a successful call to pollReady which returned Poll::Ready(true).
	As the name suggests, this method only begins the process of sending the item. If the sink employs buffering, the item isn't fully processed until the buffer is fully flushed. Since sinks are designed to work with asynchronous I/O, the process of actually writing out the data to an underlying object takes place asynchronously. You must use #pollFlush: or #pollClose: in order to guarantee completion of a send.
	Implementations of #pollReady: and #startSend: will usually involve flushing behind the scenes in order to make room for new messages. It is only necessary to call #pollFlush: if you need to guarantee that all of the items placed into the Sink have been sent.
	In most cases, if the sink encounters an error, the sink will permanently be unable to receive items."

	sink startSend: anObject.
	whenPending ifNotNil: [ updater requestUpdate ]
]

{ #category : #'api - accessing' }
BrAsyncElementSink >> whenPending: aPendingBlock [
	whenPending := aPendingBlock
]

{ #category : #'api - accessing' }
BrAsyncElementSink >> whenSuccess: aSuccessBlock [
	whenSuccess := aSuccessBlock
]

{ #category : #'api - accessing' }
BrAsyncElementSink >> whenUpdate: anUpdateBlock [
	self
		whenPending: anUpdateBlock;
		whenSuccess: anUpdateBlock
]
