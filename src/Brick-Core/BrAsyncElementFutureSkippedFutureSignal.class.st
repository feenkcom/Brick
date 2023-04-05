Class {
	#name : #BrAsyncElementFutureSkippedFutureSignal,
	#superclass : #BrAsyncElementFutureSignal,
	#instVars : [
		'promise',
		'skippedFuture'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureSkippedFutureSignal >> promise [
	^ promise
]

{ #category : #accessing }
BrAsyncElementFutureSkippedFutureSignal >> promise: anObject [
	promise := anObject
]

{ #category : #accessing }
BrAsyncElementFutureSkippedFutureSignal >> skippedFuture [
	^ skippedFuture
]

{ #category : #accessing }
BrAsyncElementFutureSkippedFutureSignal >> skippedFuture: anObject [
	skippedFuture := anObject
]
