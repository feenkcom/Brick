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
		'eventHandler',
		'futureExecutionConfiguration',
		'futureCancellation',
		'strategy'
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

{ #category : #accessing }
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

{ #category : #accessing }
BrAsyncElementFuture >> future: anAsyncFuture [
	self future: anAsyncFuture initialValue: nil
]

{ #category : #accessing }
BrAsyncElementFuture >> future: anAsyncFuture initialValue: anObject [
	mutex critical: [
		| aPreviousDataSnapshot aNewDataSnapshot |
		promise ifNotNil: [ :aPromise | aPromise cancel: futureCancellation ].
		promise := nil.
		future := anAsyncFuture asAsyncFuture.
		aPreviousDataSnapshot := dataSnapshot.		
		aNewDataSnapshot := dataSnapshot := BrFromFutureDataSnapshot new setPending: anObject.
		self privateInitializeElement.
		aPreviousDataSnapshot = aNewDataSnapshot
			ifFalse: [ updater requestUpdate ] ]
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
			
		promise ifNotNil: [ ^self ].
		
		isFinished := false.
		promise := aPromise := future await: futureExecutionConfiguration.
		(BrFutureScheduledSignal new future: future) emit.
		promise
			then: [ :aResult |
				isFinished := true.
				(promise == aPromise)
					ifTrue: [ self privateDataSnapshot: (BrFromFutureDataSnapshot new setData: aResult) ] ]
			otherwise: [ :anError |
				isFinished := true.
				(promise == aPromise)
					ifTrue: [ self privateDataSnapshot: (BrFromFutureDataSnapshot new setError: anError) ] ] ].

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
	strategy := aStrategy
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
