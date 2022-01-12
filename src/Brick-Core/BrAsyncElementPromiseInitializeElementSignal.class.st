Class {
	#name : #BrAsyncElementPromiseInitializeElementSignal,
	#superclass : #BrAsyncElementPromiseSignal,
	#instVars : [
		'isProcessed'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #'private - update' }
BrAsyncElementPromiseInitializeElementSignal >> isProcessed: aBoolean [ 
	isProcessed := aBoolean
]
