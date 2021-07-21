Class {
	#name : #BrListModelItemsChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'viewModel'
	],
	#category : 'Brick-List - Events'
}

{ #category : #accessing }
BrListModelItemsChangedEvent >> viewModel [
	^ viewModel
]

{ #category : #accessing }
BrListModelItemsChangedEvent >> viewModel: aViewModel [
	viewModel := aViewModel
]
