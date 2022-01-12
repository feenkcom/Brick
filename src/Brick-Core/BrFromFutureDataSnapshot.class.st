Class {
	#name : #BrFromFutureDataSnapshot,
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#classVars : [
		'DataState',
		'ErrorState',
		'PendingState'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #initialization }
BrFromFutureDataSnapshot class >> initialize [
	DataState := #data.
	ErrorState := #error.
	PendingState := #pending
]

{ #category : #comparing }
BrFromFutureDataSnapshot >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ state = anObject state
]

{ #category : #accessing }
BrFromFutureDataSnapshot >> data [
	self
		assert: [ self hasData ]
		description: [ 'Data must be computed, but the state is {1}' format: { state key } ].
		
	^ state value
]

{ #category : #accessing }
BrFromFutureDataSnapshot >> error [
	self
		assert: [ self hasError ]
		description: [ 'Expected error but the state is {1}' format: { state key } ].
		
	^ state value
]

{ #category : #testing }
BrFromFutureDataSnapshot >> hasData [
	^ state key = DataState
]

{ #category : #testing }
BrFromFutureDataSnapshot >> hasError [
	^ state key = ErrorState
]

{ #category : #comparing }
BrFromFutureDataSnapshot >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ state hash
]

{ #category : #accessing }
BrFromFutureDataSnapshot >> ifError: anErrorBlock [		
	self hasError
		ifTrue: [ ^ anErrorBlock cull: self error ]
]

{ #category : #accessing }
BrFromFutureDataSnapshot >> ifSuccess: aDataBlock ifError: anErrorBlock ifPending: aPendingBlock [
	self hasData
		ifTrue: [ ^ aDataBlock cull: self data ].
		
	self hasError
		ifTrue: [ ^ anErrorBlock cull: self error ].
		
	self isPending
		ifTrue: [ ^ aPendingBlock cull: self initialData ].
]

{ #category : #accessing }
BrFromFutureDataSnapshot >> ifSuccess: aDataBlock ifPending: aPendingBlock [
	^ self
		ifSuccess: aDataBlock
		ifError: [ nil ]
		ifPending: aPendingBlock
]

{ #category : #accessing }
BrFromFutureDataSnapshot >> initialData [
	self
		assert: [ self isPending ]
		description: [ 'Expected to be pending but the state is {1}' format: { state key } ].
		
	^ state value
]

{ #category : #initialization }
BrFromFutureDataSnapshot >> initialize [
	super initialize.
	
	state := PendingState -> nil
]

{ #category : #testing }
BrFromFutureDataSnapshot >> isPending [
	^ state key = PendingState
]

{ #category : #testing }
BrFromFutureDataSnapshot >> isSuccess [
	^ state key = DataState
]

{ #category : #initialization }
BrFromFutureDataSnapshot >> setData: theData [
	state := DataState -> theData
]

{ #category : #initialization }
BrFromFutureDataSnapshot >> setError: anError [
	state := ErrorState -> anError
]

{ #category : #initialization }
BrFromFutureDataSnapshot >> setPending: anInitialOrPreviousData [
	state := PendingState -> anInitialOrPreviousData
]

{ #category : #accessing }
BrFromFutureDataSnapshot >> state [

	^ state
]
