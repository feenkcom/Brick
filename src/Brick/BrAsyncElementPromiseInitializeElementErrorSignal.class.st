Class {
	#name : #BrAsyncElementPromiseInitializeElementErrorSignal,
	#superclass : #BrAsyncElementPromiseSignal,
	#instVars : [
		'error'
	],
	#category : #'Brick-Future - Support'
}

{ #category : #accessing }
BrAsyncElementPromiseInitializeElementErrorSignal >> error [

	^ error
]

{ #category : #accessing }
BrAsyncElementPromiseInitializeElementErrorSignal >> error: anObject [

	error := anObject
]
