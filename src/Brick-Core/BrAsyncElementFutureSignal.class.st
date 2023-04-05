Class {
	#name : #BrAsyncElementFutureSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'element',
		'elementFuture',
		'future',
		'elementSpace',
		'elementUpdater'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureSignal >> element [
	^ element
]

{ #category : #accessing }
BrAsyncElementFutureSignal >> elementFuture [
	^ elementFuture
]

{ #category : #'private - update' }
BrAsyncElementFutureSignal >> elementFuture: aFuture [ 
	elementFuture := aFuture
]

{ #category : #accessing }
BrAsyncElementFutureSignal >> elementSpace [
	^ elementSpace
]

{ #category : #accessing }
BrAsyncElementFutureSignal >> elementUpdater [
	^ elementUpdater
]

{ #category : #accessing }
BrAsyncElementFutureSignal >> elementUpdater: anUpdater [
	elementUpdater := anUpdater.
	element := anUpdater ifNotNil: #element.
	elementSpace := element ifNotNil: #space
]

{ #category : #accessing }
BrAsyncElementFutureSignal >> future [
	^ future
]

{ #category : #accessing }
BrAsyncElementFutureSignal >> future: anObject [
	future := anObject
]

{ #category : #testing }
BrAsyncElementFutureSignal >> isElementInSpace [
	^ elementSpace isNotNil
]

{ #category : #printing }
BrAsyncElementFutureSignal >> printOneLineContentsOn: stream [
	stream print: element.
	self isElementInSpace ifFalse: [ 
		stream nextPutAll: ' is not in space' ].
	stream nextPutAll: ', updaterID: '.
	stream print: elementUpdater identityHash.
	super printOneLineContentsOn: stream
]
