Class {
	#name : #BrColumnedLazyList,
	#superclass : #BrColumnedList,
	#category : 'Brick-List - UI'
}

{ #category : #initialization }
BrColumnedLazyList >> defaultListModel [
	^ BrColumnedLazyListModel new
]

{ #category : #accessing }
BrColumnedLazyList >> itemsProvider: anItemsProvider [
	self viewModel itemsProvider: anItemsProvider
]
