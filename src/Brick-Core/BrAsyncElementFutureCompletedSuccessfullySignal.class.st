Class {
	#name : #BrAsyncElementFutureCompletedSuccessfullySignal,
	#superclass : #BrAsyncElementFutureSignal,
	#instVars : [
		'promise',
		'isCurrentPromise',
		'result'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #testing }
BrAsyncElementFutureCompletedSuccessfullySignal class >> gtNormalOperationSignal [

	^ true
]

{ #category : #accessing }
BrAsyncElementFutureCompletedSuccessfullySignal >> isCurrentPromise [
	^ isCurrentPromise
]

{ #category : #accessing }
BrAsyncElementFutureCompletedSuccessfullySignal >> isCurrentPromise: anObject [
	isCurrentPromise := anObject
]

{ #category : #accessing }
BrAsyncElementFutureCompletedSuccessfullySignal >> promise [
	^ promise
]

{ #category : #accessing }
BrAsyncElementFutureCompletedSuccessfullySignal >> promise: anObject [
	promise := anObject
]

{ #category : #accessing }
BrAsyncElementFutureCompletedSuccessfullySignal >> result [
	^ result
]

{ #category : #accessing }
BrAsyncElementFutureCompletedSuccessfullySignal >> result: anObject [
	result := anObject
]
