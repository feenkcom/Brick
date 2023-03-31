Class {
	#name : #BrMultiListDataSource,
	#superclass : #BrSimpleListDataSource,
	#category : #'Brick-List-Ungrouped-Support'
}

{ #category : #accessing }
BrMultiListDataSource >> initialize [
	super initialize.

	clickToSelectHandler := BrListMultiClickSelectHandler new
]
