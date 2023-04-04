Class {
	#name : #BrAsyncElementFutureAboutToCancelPromiseSignal,
	#superclass : #BrAsyncElementFutureSignal,
	#instVars : [
		'promise'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureAboutToCancelPromiseSignal >> promise [
	^ promise
]

{ #category : #accessing }
BrAsyncElementFutureAboutToCancelPromiseSignal >> promise: anObject [
	promise := anObject
]
