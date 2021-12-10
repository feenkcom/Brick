Class {
	#name : #BrAsyncElementPromiseInitializeElementSignal,
	#superclass : #BrAsyncElementPromiseSignal,
	#instVars : [
		'isProcessed'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #'private - update' }
BrAsyncElementPromiseInitializeElementSignal >> isProcessed: aBoolean [ 
	isProcessed := aBoolean
]
