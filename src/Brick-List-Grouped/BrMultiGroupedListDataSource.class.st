Class {
	#name : #BrMultiGroupedListDataSource,
	#superclass : #BrGroupedListDataSource,
	#category : #'Brick-List-Grouped-Support'
}

{ #category : #initialization }
BrMultiGroupedListDataSource >> initialize [
	super initialize.

	clickToSelectHandler := BrGroupedListMultiClickSelectHandler new
]
