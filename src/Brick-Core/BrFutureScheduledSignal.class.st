Class {
	#name : #BrFutureScheduledSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'future'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #testing }
BrFutureScheduledSignal class >> gtNormalOperationSignal [

	^ true
]

{ #category : #accessing }
BrFutureScheduledSignal >> future [
	^ future
]

{ #category : #'private - update' }
BrFutureScheduledSignal >> future: aFuture [ 
	future := aFuture
]
