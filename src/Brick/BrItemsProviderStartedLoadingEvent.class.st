Class {
	#name : #BrItemsProviderStartedLoadingEvent,
	#superclass : #BlEvent,
	#instVars : [
		'itemsProvider',
		'initialAmountOfItems'
	],
	#category : #'Brick-! Core - Item Providers'
}

{ #category : #accessing }
BrItemsProviderStartedLoadingEvent >> initialAmountOfItems [

	^ initialAmountOfItems
]

{ #category : #accessing }
BrItemsProviderStartedLoadingEvent >> initialAmountOfItems: anObject [

	initialAmountOfItems := anObject
]

{ #category : #accessing }
BrItemsProviderStartedLoadingEvent >> itemsProvider [

	^ itemsProvider
]

{ #category : #accessing }
BrItemsProviderStartedLoadingEvent >> itemsProvider: anObject [

	itemsProvider := anObject
]
