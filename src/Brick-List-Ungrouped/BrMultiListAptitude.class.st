Class {
	#name : #BrMultiListAptitude,
	#superclass : #BrSimpleListAptitude,
	#category : #'Brick-List-Ungrouped-Aptitudes'
}

{ #category : #accessing }
BrMultiListAptitude >> initializeListElement [
	super initializeListElement.
	listElement dataSource: BrMultiListDataSource new
]
