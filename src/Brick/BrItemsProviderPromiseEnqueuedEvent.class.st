Class {
	#name : #BrItemsProviderPromiseEnqueuedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'promise'
	],
	#category : #'Brick-! Core - Item Providers'
}

{ #category : #accessing }
BrItemsProviderPromiseEnqueuedEvent >> promise [

	^ promise
]

{ #category : #accessing }
BrItemsProviderPromiseEnqueuedEvent >> promise: anObject [

	promise := anObject
]
