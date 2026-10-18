"
Stable ascending ordering of domain items by a column comparator.
"
Class {
	#name : #BrColumnSortedAscendingState,
	#superclass : #BrColumnSortState,
	#category : #'Brick-List-Ungrouped-Models'
}

{ #category : #headers }
BrColumnSortedAscendingState >> iconElement [
	^ BrGlamorousVectorIcons up asElement
		background: BrGlamorousColors defaultButtonTextColor
]

{ #category : #testing }
BrColumnSortedAscendingState >> isAscending [
	^ true
]

{ #category : #sorting }
BrColumnSortedAscendingState >> ordersAscending: ascending descending: descending [
	^ ascending
]

{ #category : #transitions }
BrColumnSortedAscendingState >> reversed [
	^ BrColumnSortedDescendingState new column: column
]
