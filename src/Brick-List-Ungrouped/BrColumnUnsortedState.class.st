"
No column ordering is active. Items retain their current provider order.
"
Class {
	#name : #BrColumnUnsortedState,
	#superclass : #BrColumnSortState,
	#category : #'Brick-List-Ungrouped-Models'
}

{ #category : #headers }
BrColumnUnsortedState >> iconElement [
	^ BlElement new size: 0 @ 0
]

{ #category : #testing }
BrColumnUnsortedState >> isUnsorted [
	^ true
]

{ #category : #transitions }
BrColumnUnsortedState >> nextForColumn: aColumn [
	^ BrColumnSortedAscendingState new column: aColumn
]

{ #category : #sorting }
BrColumnUnsortedState >> orderedItems: items [
	^ items asArray copy
]
