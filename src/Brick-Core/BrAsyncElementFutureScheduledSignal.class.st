Class {
	#name : #BrAsyncElementFutureScheduledSignal,
	#superclass : #BrAsyncElementFutureSignal,
	#instVars : [
		'promise'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #testing }
BrAsyncElementFutureScheduledSignal class >> gtNormalOperationSignal [

	^ true
]

{ #category : #accessing }
BrAsyncElementFutureScheduledSignal >> promise [
	^ promise
]

{ #category : #accessing }
BrAsyncElementFutureScheduledSignal >> promise: anObject [
	promise := anObject
]
