Class {
	#name : #BrAsyncElementFutureReceivedSignal,
	#superclass : #BrAsyncElementFutureSignal,
	#instVars : [
		'existingPromise',
		'dataSnapshot',
		'isPending',
		'strategy',
		'needsUpdate'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #testing }
BrAsyncElementFutureReceivedSignal class >> gtNormalOperationSignal [

	^ true
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> dataSnapshot [
	^ dataSnapshot
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> dataSnapshot: anObject [
	dataSnapshot := anObject
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> existingPromise [
	^ existingPromise
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> existingPromise: anObject [
	existingPromise := anObject
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> isPending [
	^ isPending
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> isPending: anObject [
	isPending := anObject
]

{ #category : #testing }
BrAsyncElementFutureReceivedSignal >> isSkipped [
	"Logic implemented in 
	{{gtMethod: BrAsyncElementFuture>>#privateInitializeElement }}"

	^ self isSkippedDueToMissingFuture
		or: [ self isSkippedDueToMissingDataSnapshot
			or: [ self isSkippedDueToPendingDataSnapshot
				or: [ self isSkippedDueToRequestedUpdate or: [ 
					self isSkippedDueToExistingPromise ] ] ] ]
]

{ #category : #testing }
BrAsyncElementFutureReceivedSignal >> isSkippedDueToExistingPromise [
	^ existingPromise isNotNil
]

{ #category : #testing }
BrAsyncElementFutureReceivedSignal >> isSkippedDueToMissingDataSnapshot [
	^ dataSnapshot isNil
]

{ #category : #testing }
BrAsyncElementFutureReceivedSignal >> isSkippedDueToMissingFuture [
	^ future isNil
]

{ #category : #testing }
BrAsyncElementFutureReceivedSignal >> isSkippedDueToPendingDataSnapshot [
	^ isPending == false
]

{ #category : #testing }
BrAsyncElementFutureReceivedSignal >> isSkippedDueToRequestedUpdate [
	^ needsUpdate == false
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> needsUpdate [
	^ needsUpdate
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> needsUpdate: anObject [
	needsUpdate := anObject
]

{ #category : #printing }
BrAsyncElementFutureReceivedSignal >> printOneLineContentsOn: stream [
	self isSkipped 
		ifTrue: [ stream 
			nextPutAll: 'SKIPPED('; 
			nextPutAll: self skipReason;
			nextPut: $);
			space ]
		ifFalse: [ stream nextPutAll: 'PROCESSED ' ].
	super printOneLineContentsOn: stream
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> skipReason [
	<return: #String or: nil>
	^ self skipReasonDictionary associations
		detect: [ :anAssoc | anAssoc value = true ] 
		ifFound: [ :anAssoc | anAssoc key copyReplaceAll: 'Due to ' with: '' ]
		ifNone: [ '?' ]
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> skipReasonDictionary [
	| anUpdateName |
	anUpdateName := self isElementAttachedToSpace
		ifTrue: [ 'Due to requested update' ]
		ifFalse: [ 'Due to requested update (element not in space)' ].

	^ OrderedDictionary new
		at: 'Due to missing future' put: self isSkippedDueToMissingFuture;
		at: 'Due to missing data snapshot'
			put: self isSkippedDueToMissingDataSnapshot;
		at: 'Due to pending data snapshot'
			put: self isSkippedDueToPendingDataSnapshot;
		at: anUpdateName put: self isSkippedDueToRequestedUpdate;
		at: 'Due to existing promise' put: self isSkippedDueToExistingPromise;
		yourself
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> strategy [
	^ strategy
]

{ #category : #accessing }
BrAsyncElementFutureReceivedSignal >> strategy: anObject [
	strategy := anObject
]
