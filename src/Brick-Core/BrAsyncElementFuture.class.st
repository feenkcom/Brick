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
		'futureCancellation'
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

{ #category : #accessing }
BrAsyncElementFuture >> element: anElement [
	updater ifNotNil: [ :anUpdater |
		anUpdater element == anElement
			ifTrue: [ ^ self ]
			ifFalse: [ self error: 'Can not re-assign the element' ] ].

	updater := BrElementUpdater new
		element: anElement;
		action: (MessageSend receiver: self selector: #privateUpdateElement).

	eventHandler := BlEventHandler new
		eventClass: BlElementAddedToSceneGraphEvent;
		action: (MessageSend receiver: self selector: #onElementAddedToSceneGraph:).

	anElement addEventHandler: eventHandler
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

		updater element isAttachedToSceneGraph
			ifFalse: [ ^ self ].
		
		isFinished := false.
		promise := aPromise := future await: futureExecutionConfiguration.
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
