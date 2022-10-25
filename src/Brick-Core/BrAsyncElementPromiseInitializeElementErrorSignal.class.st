Class {
	#name : #BrAsyncElementPromiseInitializeElementErrorSignal,
	#superclass : #BrAsyncElementPromiseSignal,
	#instVars : [
		'error'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementPromiseInitializeElementErrorSignal >> error [

	^ error
]

{ #category : #accessing }
BrAsyncElementPromiseInitializeElementErrorSignal >> error: anObject [

	error := anObject
]
