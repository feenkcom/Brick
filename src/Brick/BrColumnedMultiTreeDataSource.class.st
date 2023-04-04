Class {
	#name : #BrColumnedMultiTreeDataSource,
	#superclass : #BrColumnedTreeDataSource,
	#category : #'Brick-Tree - Support'
}

{ #category : #accessing }
BrColumnedMultiTreeDataSource >> initialize [
	super initialize.

	clickToSelectHandler := BrMultiTreeClickToSelectHandler new
]
