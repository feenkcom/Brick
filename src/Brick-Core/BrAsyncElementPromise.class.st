Class {
	#name : #BrAsyncElementPromise,
	#superclass : #Object,
	#instVars : [
		'updater',
		'promise',
		'whenSuccess',
		'whenError',
		'whenPending',
		'dataSnapshot'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #'instance creation' }
BrAsyncElementPromise class >> on: anElement [
	^ self new element: anElement
]

{ #category : #accessing }
BrAsyncElementPromise >> element: anElement [
	updater := BrElementUpdater new
		element: anElement;
		action: (MessageSend receiver: self selector: #privateUpdateElement)
]

{ #category : #initialization }
BrAsyncElementPromise >> initialize [
	super initialize.
	
	whenPending := nil. "[ :anElement :aData | ]".
	whenSuccess := nil.  "[ :anElement :aData | ]"
	whenError := nil.  "[ :anElement :aData | ]"
	promise := nil.
]

{ #category : #'private - update' }
BrAsyncElementPromise >> privateDataSnapshot: aDataSnapshot synchronous: isSynchronous [
	dataSnapshot := aDataSnapshot.
	
	isSynchronous
		ifTrue: [ self privateUpdateElement ]
		ifFalse: [
			(BrAsyncElementPromiseRequestUpdateSignal forElement: updater element) emit.
			updater requestUpdate ]
]

{ #category : #'private - update' }
BrAsyncElementPromise >> privateInitializeElement [
	| aPromise isProcessed aResultPromise |

	"Do nothing if the data snaphot is not longer pending!"
	dataSnapshot isPending
		ifFalse: [ ^ self ].

	isProcessed := false.

	aResultPromise := AsyncPendingPromise new.
	aPromise := promise.
	aPromise
		then: [ :aResult :isSynchronous |
			isProcessed := true.
			(promise == aPromise)
				ifTrue: [
					(BrAsyncElementPromiseInitializeElementSuccessSignal forElement: updater element)
						promise: aPromise;
						result: aResult;
						isSynchronous: isSynchronous;
						emit.
					self
						privateDataSnapshot: (BrFromFutureDataSnapshot new setData: aResult)
						synchronous: isSynchronous ].
			aResultPromise fulfillWithValue: aResult ]
		otherwise: [ :anError |
			isProcessed := true.
			(promise == aPromise)
				ifTrue: [
					(BrAsyncElementPromiseInitializeElementErrorSignal forElement: updater element)
						error: anError;
						promise: aPromise;
						emit.
					self
						privateDataSnapshot: (BrFromFutureDataSnapshot new setError: anError)
						synchronous: false ].
			aResultPromise rejectWithError: anError ].

	(BrAsyncElementPromiseInitializeElementSignal forElement: updater element)
		promise: aPromise;
		isProcessed: isProcessed;
		emit.

	isProcessed ifFalse: [
		"To let the space know that we are waiting for a promise to finish"
		updater element enqueueTask: (BlPromiseTask new promise: aResultPromise).
		self privateUpdateElement ]
]

{ #category : #'private - update' }
BrAsyncElementPromise >> privateUpdateElement [
	"Must be called from the UI thread"

	(BrAsyncElementPromiseElementUpdateSignal forElement: updater element) emit.

	dataSnapshot
		ifSuccess: [ :aData | whenSuccess ifNotNil: [ :aBlock | aBlock cull: updater element cull: aData ] ]
		ifError: [ :anError | whenError ifNotNil: [ :aBlock | aBlock cull: updater element cull: anError ] ]
		ifPending: [ :aData | whenPending ifNotNil: [ :aBlock | aBlock cull: updater element cull: aData ] ]
]

{ #category : #accessing }
BrAsyncElementPromise >> promise: anAsyncPromise [
	self promise: anAsyncPromise initialValue: nil
]

{ #category : #accessing }
BrAsyncElementPromise >> promise: aPromise initialValue: anObject [
	promise := aPromise asAsyncPromise.
	dataSnapshot := BrFromFutureDataSnapshot new setPending: anObject.
	self privateInitializeElement
]

{ #category : #'api - accessing' }
BrAsyncElementPromise >> whenError: anErrorBlock [
	whenError := anErrorBlock
]

{ #category : #'api - accessing' }
BrAsyncElementPromise >> whenPending: aPendingBlock [
	whenPending := aPendingBlock
]

{ #category : #'api - accessing' }
BrAsyncElementPromise >> whenSuccess: aSuccessBlock [
	whenSuccess := aSuccessBlock
]
