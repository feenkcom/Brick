Class {
	#name : #BrFutureScheduledSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'future'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrFutureScheduledSignal >> future [
	^ future
]

{ #category : #'private - update' }
BrFutureScheduledSignal >> future: aFuture [ 
	future := aFuture
]
