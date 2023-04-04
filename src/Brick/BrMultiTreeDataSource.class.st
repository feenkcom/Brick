Class {
	#name : #BrMultiTreeDataSource,
	#superclass : #BrSimpleTreeDataSource,
	#category : #'Brick-Tree - Support'
}

{ #category : #accessing }
BrMultiTreeDataSource >> initialize [
	super initialize.

	clickToSelectHandler := BrMultiTreeClickToSelectHandler new
]
