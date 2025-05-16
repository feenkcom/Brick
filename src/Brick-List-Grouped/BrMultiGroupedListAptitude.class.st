Class {
	#name : #BrMultiGroupedListAptitude,
	#superclass : #BrGroupedListAptitude,
	#category : #'Brick-List-Grouped-Aptitudes'
}

{ #category : #initialization }
BrMultiGroupedListAptitude >> initializeListElement [
	super initializeListElement.
	listElement dataSource: BrMultiGroupedListDataSource new
]
