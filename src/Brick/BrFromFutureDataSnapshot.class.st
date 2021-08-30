Class {
	#name : 'BrFromFutureDataSnapshot',
	#superclass : 'Object',
	#instVars : [
		'state'
	],
	#classVars : [
		'DataState',
		'ErrorState',
		'PendingState'
	],
	#category : 'Brick-Future - Support'
}

{ #category : 'initialization' }
BrFromFutureDataSnapshot class >> initialize [
	DataState := #data.
	ErrorState := #error.
	PendingState := #pending
]

{ #category : 'accessing' }
BrFromFutureDataSnapshot >> data [
	self
		assert: [ self hasData ]
		description: [ 'Data must be computed, but the state is {1}' format: { state key } ].
		
	^ state value
]

{ #category : 'accessing' }
BrFromFutureDataSnapshot >> error [
	self
		assert: [ self hasError ]
		description: [ 'Expected error but the state is {1}' format: { state key } ].
		
	^ state value
]

{ #category : 'testing' }
BrFromFutureDataSnapshot >> hasData [
	^ state key = DataState
]

{ #category : 'testing' }
BrFromFutureDataSnapshot >> hasError [
	^ state key = ErrorState
]

{ #category : 'accessing' }
BrFromFutureDataSnapshot >> ifSuccess: aDataBlock ifError: anErrorBlock ifPending: aPendingBlock [
	self hasData
		ifTrue: [ ^ aDataBlock cull: self data ].
		
	self hasError
		ifTrue: [ ^ anErrorBlock cull: self error ].
		
	self isPending
		ifTrue: [ ^ aPendingBlock cull: self initialData ].
]

{ #category : 'accessing' }
BrFromFutureDataSnapshot >> ifSuccess: aDataBlock ifPending: aPendingBlock [
	^ self
		ifSuccess: aDataBlock
		ifError: [ nil ]
		ifPending: aPendingBlock
]

{ #category : 'accessing' }
BrFromFutureDataSnapshot >> initialData [
	self
		assert: [ self isPending ]
		description: [ 'Expected to be pending but the state is {1}' format: { state key } ].
		
	^ state value
]

{ #category : 'initialization' }
BrFromFutureDataSnapshot >> initialize [
	super initialize.
	
	state := PendingState -> nil
]

{ #category : 'testing' }
BrFromFutureDataSnapshot >> isPending [
	^ state key = PendingState
]

{ #category : 'initialization' }
BrFromFutureDataSnapshot >> setData: theData [
	state := DataState -> theData
]

{ #category : 'initialization' }
BrFromFutureDataSnapshot >> setError: anError [
	state := ErrorState -> anError
]

{ #category : 'initialization' }
BrFromFutureDataSnapshot >> setPending: anInitialOrPreviousData [
	state := PendingState -> anInitialOrPreviousData
]
