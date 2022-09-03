Class {
	#name : #BrItemsProviderNewItemsLoadedEvent,
	#superclass : #Announcement,
	#instVars : [
		'itemsProvider',
		'newItems',
		'index'
	],
	#category : #'Brick-! Core - Item Providers'
}

{ #category : #accessing }
BrItemsProviderNewItemsLoadedEvent >> index [

	^ index
]

{ #category : #accessing }
BrItemsProviderNewItemsLoadedEvent >> index: anObject [

	index := anObject
]

{ #category : #accessing }
BrItemsProviderNewItemsLoadedEvent >> itemsProvider [

	^ itemsProvider
]

{ #category : #accessing }
BrItemsProviderNewItemsLoadedEvent >> itemsProvider: anObject [

	itemsProvider := anObject
]

{ #category : #accessing }
BrItemsProviderNewItemsLoadedEvent >> newItems [

	^ newItems
]

{ #category : #accessing }
BrItemsProviderNewItemsLoadedEvent >> newItems: anObject [

	newItems := anObject
]
