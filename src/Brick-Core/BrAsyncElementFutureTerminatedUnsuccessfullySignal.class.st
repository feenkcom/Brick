Class {
	#name : #BrAsyncElementFutureTerminatedUnsuccessfullySignal,
	#superclass : #BrAsyncElementFutureSignal,
	#instVars : [
		'promise',
		'isCurrentPromise',
		'exception'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureTerminatedUnsuccessfullySignal >> exception [
	^ exception
]

{ #category : #accessing }
BrAsyncElementFutureTerminatedUnsuccessfullySignal >> exception: anObject [
	exception := anObject
]

{ #category : #accessing }
BrAsyncElementFutureTerminatedUnsuccessfullySignal >> isCurrentPromise [
	^ isCurrentPromise
]

{ #category : #accessing }
BrAsyncElementFutureTerminatedUnsuccessfullySignal >> isCurrentPromise: anObject [
	isCurrentPromise := anObject
]

{ #category : #accessing }
BrAsyncElementFutureTerminatedUnsuccessfullySignal >> promise [
	^ promise
]

{ #category : #accessing }
BrAsyncElementFutureTerminatedUnsuccessfullySignal >> promise: anObject [
	promise := anObject
]
