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
		'whenDonePromise',
		'shouldFireScheduledEvent'
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

{ #category : #'api - configuring' }
BrAsyncElementFuture >> configureWithPassExceptionHandler [
	futureExecutionConfiguration errorHandler: AsyncPassExceptionHandler new
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
				ifTrue: [ 
					BrAsyncElementFutureAboutToCancelPromiseSignal new 
						elementFuture: self;
						elementUpdater: updater;
						future: future;
						promise: aPromise;
						emit.
					aPromise cancel: futureCancellation ]
				ifFalse: [ 
					BrAsyncElementFutureSkippedFutureSignal new 
						elementFuture: self;
						elementUpdater: updater;
						future: future;
						promise: aPromise;
						skippedFuture: anAsyncFuture asAsyncFuture;
						emit.
					^ self ] ].
		promise := nil.
		whenDonePromise := AsyncManualPromise new.
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
	
	mutex := Mutex new.
	whenPending := nil. "[ :anElement :aData | ]".
	whenSuccess := nil.  "[ :anElement :aData | ]"
	whenError := nil.  "[ :anElement :aData | ]"
	future := nil.
	dataSnapshot := nil.
	previousDataSnapshot := nil.
	futureExecutionConfiguration := AsyncFutureExecutionConfiguration default.
	futureCancellation := AsyncFutureExecutionSoftCancellation uniqueInstance.
	strategy := self defaultStrategy.
	shouldFireScheduledEvent := false
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
		| isPending needsUpdate |
	
		BrAsyncElementFutureReceivedSignal new 
			elementFuture: self;
			elementUpdater: updater;
			future: future;
			existingPromise: promise;
			dataSnapshot: dataSnapshot;
			isPending: (isPending := dataSnapshot ifNotNil: #isPending);
			strategy: strategy;
			needsUpdate: (needsUpdate := strategy needsUpdate: updater element);
			emit.

		future
			ifNil: [ ^ self ].
		
		dataSnapshot
			ifNil: [ ^ self ].
		
		"Do nothing if the data snaphot is no longer pending!"
		isPending
			ifFalse: [ ^ self ].

		needsUpdate
			ifFalse: [ ^ self ].
			
		promise ifNotNil: [ ^ self ].
		
		isFinished := false.
		promise := aPromise := future await: futureExecutionConfiguration.
		BrAsyncElementFutureScheduledSignal new 
			elementFuture: self;
			elementUpdater: updater;
			future: future;
			promise: aPromise;
			emit.
		promise
			then: [ :aResult |
				isFinished := true.
				mutex critical: [
					BrAsyncElementFutureCompletedSuccessfullySignal new
						elementFuture: self;
						elementUpdater: updater;
						future: future;
						promise: aPromise;
						isCurrentPromise: promise == aPromise;
						result: aResult;
						emit.
				
					(promise == aPromise)
						ifTrue: [
							promise := nil.
							whenDonePromise fulfillWithValue: true.
							self privateDataSnapshot: (BrFromFutureDataSnapshot new setData: aResult) ] ] ]
			otherwise: [ :anError |
				isFinished := true.
				mutex critical: [
					BrAsyncElementFutureTerminatedUnsuccessfullySignal new
						elementFuture: self;
						elementUpdater: updater;
						future: future;
						promise: aPromise;
						isCurrentPromise: promise == aPromise;
						exception: anError copy freeze;
						emit.
				
					(promise == aPromise)
						ifTrue: [
							promise := nil.
							whenDonePromise rejectWithError: anError.
							self privateDataSnapshot: (BrFromFutureDataSnapshot new setError: anError) ] ] ] ].

	isFinished
		ifFalse: [
		| anElement |
		anElement := updater element.
			anElement enqueueTask: (BlPromiseTask new promise: aPromise).
			
			"users have to opt-in to fire future scheduled events"
			shouldFireScheduledEvent ifTrue: [
				anElement enqueueTask: (BlTaskAction new action: [
					anElement fireEvent: (BrAsyncElementFutureScheduledEvent new futurePromise: aPromise) ]) ] ]
]

{ #category : #'private - update' }
BrAsyncElementFuture >> privateUpdateElement [
	"Must be called from the UI thread"
	| aNewDataSnapshot |

	mutex critical: [
		previousDataSnapshot = dataSnapshot
			ifTrue: [ 
				BrAsyncElementFutureUpdateElementSkippedSignal new
					elementFuture: self;
					elementUpdater: updater;
					future: future;
					dataSnapshot: dataSnapshot;
					previousDataSnapshot: previousDataSnapshot;
					emit.
				^ self ].
		previousDataSnapshot := aNewDataSnapshot := dataSnapshot ].
		
	BrAsyncElementFutureUpdateElementSignal new
		elementFuture: self;
		elementUpdater: updater;
		future: future;
		dataSnapshot: aNewDataSnapshot;
		emit.
	
	aNewDataSnapshot
		ifSuccess: [ :aData | whenSuccess ifNotNil: [ :aBlock | aBlock cull: updater element cull: aData ] ]
		ifError: [ :anError | whenError
			ifNotNil: [ :aBlock | aBlock cull: updater element cull: anError ]
			ifNil: [ updater element showNotification: anError asNotification ] ]
		ifPending: [ :aData | whenPending ifNotNil: [ :aBlock | aBlock cull: updater element cull: aData ] ]
]

{ #category : #'api - configuring' }
BrAsyncElementFuture >> shouldFireScheduledEvent: aBoolean [
	"Set to true if an element should fire an event when a future is scheduled for execution.
	false by default"

	shouldFireScheduledEvent := aBoolean
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
