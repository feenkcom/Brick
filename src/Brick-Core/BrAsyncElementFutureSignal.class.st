Class {
	#name : #BrAsyncElementFutureSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'element',
		'elementFuture',
		'future',
		'isElementAttachedToSpace',
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
BrAsyncElementFutureSignal >> elementUpdater [
	^ elementUpdater
]

{ #category : #accessing }
BrAsyncElementFutureSignal >> elementUpdater: anUpdater [
	elementUpdater := anUpdater.
	element := anUpdater ifNotNil: #element.
	isElementAttachedToSpace := element
		ifNotNil: [ :anElement | anElement isAttachedToSceneGraph ]
		ifNil: [ false ]
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
BrAsyncElementFutureSignal >> isElementAttachedToSpace [
	^ isElementAttachedToSpace
]

{ #category : #printing }
BrAsyncElementFutureSignal >> printOneLineContentsOn: stream [
	stream print: element.
	self isElementAttachedToSpace ifFalse: [ 
		stream nextPutAll: ' is not in space' ].
	stream nextPutAll: ', updaterID: '.
	stream print: elementUpdater identityHash.
	super printOneLineContentsOn: stream
]
