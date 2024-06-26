Class {
	#name : #BrAsyncElementPromiseInitializeElementSuccessSignal,
	#superclass : #BrAsyncElementPromiseSignal,
	#instVars : [
		'result',
		'isSynchronous'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementPromiseInitializeElementSuccessSignal >> isSynchronous [

	^ isSynchronous
]

{ #category : #accessing }
BrAsyncElementPromiseInitializeElementSuccessSignal >> isSynchronous: anObject [

	isSynchronous := anObject
]

{ #category : #accessing }
BrAsyncElementPromiseInitializeElementSuccessSignal >> result [

	^ result
]

{ #category : #accessing }
BrAsyncElementPromiseInitializeElementSuccessSignal >> result: anObject [

	result := anObject
]
