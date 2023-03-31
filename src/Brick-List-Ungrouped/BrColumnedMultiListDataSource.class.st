Class {
	#name : #BrColumnedMultiListDataSource,
	#superclass : #BrColumnedListDataSource,
	#category : #'Brick-List-Ungrouped-Support'
}

{ #category : #accessing }
BrColumnedMultiListDataSource >> initialize [
	super initialize.

	clickToSelectHandler := BrListMultiClickSelectHandler new
]
