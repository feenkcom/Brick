Class {
	#name : #BrItemsProviderNewItemsLoadedEvent,
	#superclass : #Announcement,
	#instVars : [
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
BrItemsProviderNewItemsLoadedEvent >> newItems [

	^ newItems
]

{ #category : #accessing }
BrItemsProviderNewItemsLoadedEvent >> newItems: anObject [

	newItems := anObject
]
