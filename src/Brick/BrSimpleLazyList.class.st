Class {
	#name : #BrSimpleLazyList,
	#superclass : #BrSimpleList,
	#category : 'Brick-List - UI'
}

{ #category : #initialization }
BrSimpleLazyList >> defaultListModel [
	^ BrSimpleLazyListModel new
]

{ #category : #accessing }
BrSimpleLazyList >> itemsProvider: anItemsProvider [
	self viewModel itemsProvider: anItemsProvider
]
