"
Stable descending ordering of domain items by a column comparator.
"
Class {
	#name : #BrColumnSortedDescendingState,
	#superclass : #BrColumnSortState,
	#category : #'Brick-List-Ungrouped-Models'
}

{ #category : #headers }
BrColumnSortedDescendingState >> iconElement [
	^ BrGlamorousVectorIcons smallDownwards asElement
		background: BrGlamorousColors defaultButtonTextColor
]

{ #category : #testing }
BrColumnSortedDescendingState >> isDescending [
	^ true
]

{ #category : #sorting }
BrColumnSortedDescendingState >> ordersAscending: ascending descending: descending [
	^ descending
]

{ #category : #transitions }
BrColumnSortedDescendingState >> reversed [
	^ BrColumnSortedAscendingState new column: column
]
