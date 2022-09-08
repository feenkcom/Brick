Class {
	#name : #BrItemsProviderDoneEvent,
	#superclass : #BlEvent,
	#instVars : [
		'itemsProvider'
	],
	#category : #'Brick-! Core - Item Providers'
}

{ #category : #accessing }
BrItemsProviderDoneEvent >> itemsProvider [

	^ itemsProvider
]

{ #category : #accessing }
BrItemsProviderDoneEvent >> itemsProvider: anObject [

	itemsProvider := anObject
]
