Class {
	#name : #BrListModelItemsChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'viewModel',
		'isSynchronous'
	],
	#category : #'Brick-List - Events'
}

{ #category : #initialization }
BrListModelItemsChangedEvent >> initialize [
	super initialize.
	
	isSynchronous := false
]

{ #category : #accessing }
BrListModelItemsChangedEvent >> isSynchronous [

	^ isSynchronous
]

{ #category : #accessing }
BrListModelItemsChangedEvent >> isSynchronous: anObject [

	isSynchronous := anObject
]

{ #category : #accessing }
BrListModelItemsChangedEvent >> viewModel [
	^ viewModel
]

{ #category : #accessing }
BrListModelItemsChangedEvent >> viewModel: aViewModel [
	viewModel := aViewModel
]
