Class {
	#name : #BrItemsProviderItemsChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'viewModel',
		'isSynchronous'
	],
	#category : #'Brick-! Core - Item Providers'
}

{ #category : #initialization }
BrItemsProviderItemsChangedEvent >> initialize [
	super initialize.
	
	isSynchronous := false
]

{ #category : #accessing }
BrItemsProviderItemsChangedEvent >> isSynchronous [

	^ isSynchronous
]

{ #category : #accessing }
BrItemsProviderItemsChangedEvent >> isSynchronous: anObject [

	isSynchronous := anObject
]

{ #category : #accessing }
BrItemsProviderItemsChangedEvent >> viewModel [
	^ viewModel
]

{ #category : #accessing }
BrItemsProviderItemsChangedEvent >> viewModel: aViewModel [
	viewModel := aViewModel
]
