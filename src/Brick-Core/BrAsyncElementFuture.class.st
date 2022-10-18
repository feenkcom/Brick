Class {
	#name : #BrAsyncElementFuture,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'updater',
		'future',
		'promise',
		'whenSuccess',
		'whenError',
		'whenPending',
		'dataSnapshot',
		'previousDataSnapshot',
		'futureExecutionConfiguration',
		'futureCancellation',
		'strategy',
		'whenDonePromise'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #'instance creation' }
BrAsyncElementFuture class >> on: anElement [
	^ self new element: anElement
]

{ #category : #'api - accessing' }
BrAsyncElementFuture >> cancelHard [
	futureCancellation := AsyncFutureExecutionHardCancellation uniqueInstance
]

{ #category : #'api - accessing' }
BrAsyncElementFuture >> cancelSoft [
	futureCancellation := AsyncFutureExecutionSoftCancellation uniqueInstance
]

{ #category : #initialization }
BrAsyncElementFuture >> defaultStrategy [
	^ BrAsyncElementFutureWhenInSceneStrategy new
]

{ #category : #initialization }
BrAsyncElementFuture >> element: anElement [
	updater ifNotNil: [ :anUpdater |
		anUpdater element == anElement
			ifTrue: [ ^ self ]
			ifFalse: [ self error: 'Can not re-assign the element' ] ].

	updater := BrElementUpdater new
		element: anElement;
		action: (MessageSend receiver: self selector: #privateUpdateElement).
	
	strategy addEventHandlersOn: anElement withFuture: self
]

{ #category : #'api - accessing' }
BrAsyncElementFuture >> executionConfiguration: anAsyncFutureExecutionConfiguration [
	futureExecutionConfiguration := anAsyncFutureExecutionConfiguration
]

{ #category : #'api - future' }
BrAsyncElementFuture >> future: anAsyncFuture [
	"Assign and run a given future cancelling an already running future if it exists"
	self
		future: anAsyncFuture
		initialValue: nil
		shouldCancel: true
]

{ #category : #'api - future' }
BrAsyncElementFuture >> future: anAsyncFuture initialValue: anObject [
	self
		future: anAsyncFuture
		initialValue: anObject
		shouldCancel: true
]

{ #category : #'api - future' }
BrAsyncElementFuture >> future: anAsyncFuture initialValue: anObject shouldCancel: shouldCancel [
	"Cancel the previous future if shouldCancel is true,
	otherwise do not assign a new future if there is one already running"
	mutex critical: [
		| aPreviousDataSnapshot aNewDataSnapshot |
		
		promise ifNotNil: [ :aPromise |
			shouldCancel
				ifTrue: [ aPromise cancel: futureCancellation ]
				ifFalse: [ ^ self ] ].
		promise := nil.
		whenDonePromise := AsyncPendingPromise new.
		future := anAsyncFuture asAsyncFuture.
		aPreviousDataSnapshot := dataSnapshot.
		aNewDataSnapshot := dataSnapshot := BrFromFutureDataSnapshot new setPending: anObject.
		self privateInitializeElement.
		aPreviousDataSnapshot = aNewDataSnapshot
			ifFalse: [ updater requestUpdate ] ]
]

{ #category : #'api - future' }
BrAsyncElementFuture >> futureIfNotRunning: anAsyncFuture [
	"Assign and run a given future only when there is no already running future"
	self
		future: anAsyncFuture
		initialValue: nil
		shouldCancel: false
]

{ #category : #initialization }
BrAsyncElementFuture >> initialize [
	super initialize.
	
	mutex := Monitor new.
	whenPending := nil. "[ :anElement :aData | ]".
	whenSuccess := nil.  "[ :anElement :aData | ]"
	whenError := nil.  "[ :anElement :aData | ]"
	future := nil.
	dataSnapshot := nil.
	previousDataSnapshot := nil.
	futureExecutionConfiguration := AsyncFutureExecutionConfiguration default.
	futureCancellation := AsyncFutureExecutionSoftCancellation uniqueInstance.
	strategy := self defaultStrategy
]

{ #category : #accessing }
BrAsyncElementFuture >> interrupt [

	mutex critical: [ 
		promise ifNotNil: [ promise cancel: futureCancellation ] ]
]

{ #category : #'private - update' }
BrAsyncElementFuture >> onElementAddedToSceneGraph: anEvent [
	self privateInitializeElement
]

{ #category : #accessing }
BrAsyncElementFuture >> pendingPromise [
	"Return a promise that resolves when the current future is computed"
	
	^ mutex critical: [ whenDonePromise ifNil: [ AsyncFulfilledPromise new value: true ] ]
]

{ #category : #'private - update' }
BrAsyncElementFuture >> privateDataSnapshot: aDataSnapshot [
	dataSnapshot = aDataSnapshot
		ifTrue: [ ^ self ].
	dataSnapshot := aDataSnapshot.
	updater requestUpdate
]

{ #category : #'private - update' }
BrAsyncElementFuture >> privateInitializeElement [
	"May be called from any process"
	| aPromise isFinished |

	mutex critical: [	
		future
			ifNil: [ ^ self ].
		
		dataSnapshot
			ifNil: [ ^ self ].
		
		"Do nothing if the data snaphot is no longer pending!"
		dataSnapshot isPending
			ifFalse: [ ^ self ].

		(strategy needsUpdate: updater element)
			ifFalse: [ ^ self ].
			
		promise ifNotNil: [ ^ self ].
		
		isFinished := false.
		promise := aPromise := future await: futureExecutionConfiguration.
		(BrFutureScheduledSignal new future: future) emit.
		promise
			then: [ :aResult |
				isFinished := true.
				mutex critical: [
					(promise == aPromise)
						ifTrue: [
							promise := nil.
							whenDonePromise fulfillWithValue: true.
							self privateDataSnapshot: (BrFromFutureDataSnapshot new setData: aResult) ] ] ]
			otherwise: [ :anError |
				isFinished := true.
				mutex critical: [
					(promise == aPromise)
						ifTrue: [
							promise := nil.
							whenDonePromise rejectWithError: anError.
							self privateDataSnapshot: (BrFromFutureDataSnapshot new setError: anError) ] ] ] ].

	isFinished
		ifFalse: [ updater element enqueueTask: (BlPromiseTask new promise: aPromise) ]
]

{ #category : #'private - update' }
BrAsyncElementFuture >> privateUpdateElement [
	"Must be called from the UI thread"
	| aNewDataSnapshot |

	mutex critical: [
		previousDataSnapshot = dataSnapshot
			ifTrue: [ ^ self ].
		previousDataSnapshot := aNewDataSnapshot := dataSnapshot ].
	
	aNewDataSnapshot
		ifSuccess: [ :aData | whenSuccess ifNotNil: [ :aBlock | aBlock cull: updater element cull: aData ] ]
		ifError: [ :anError | whenError ifNotNil: [ :aBlock | aBlock cull: updater element cull: anError ] ]
		ifPending: [ :aData | whenPending ifNotNil: [ :aBlock | aBlock cull: updater element cull: aData ] ]
]

{ #category : #accessing }
BrAsyncElementFuture >> strategy: aStrategy [
	strategy removeEventHandlersFrom: updater element withFuture: self.
	strategy := aStrategy.
	strategy addEventHandlersOn: updater element withFuture: self
]

{ #category : #'api - accessing' }
BrAsyncElementFuture >> whenError: anErrorBlock [
	whenError := anErrorBlock
]

{ #category : #'api - accessing' }
BrAsyncElementFuture >> whenPending: aPendingBlock [
	whenPending := aPendingBlock
]

{ #category : #'api - accessing' }
BrAsyncElementFuture >> whenSuccess: aSuccessBlock [
	whenSuccess := aSuccessBlock
]
