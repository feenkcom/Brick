"
Fired by an element when an async future is scheduled for execution.
"
Class {
	#name : #BrAsyncElementFutureScheduledEvent,
	#superclass : #BlEvent,
	#instVars : [
		'futurePromise'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureScheduledEvent >> futurePromise [
	^ futurePromise
]

{ #category : #accessing }
BrAsyncElementFutureScheduledEvent >> futurePromise: anObject [
	futurePromise := anObject
]
