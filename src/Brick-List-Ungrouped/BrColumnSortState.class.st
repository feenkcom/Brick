"
Sorting state of a columned list. Subclasses own direction, header indicator and ordering behavior. Selecting another column starts ascending; selecting the same column reverses direction.
"
Class {
	#name : #BrColumnSortState,
	#superclass : #Object,
	#instVars : [
		'column'
	],
	#category : #'Brick-List-Ungrouped-Models'
}

{ #category : #accessing }
BrColumnSortState >> column [
	^ column
]

{ #category : #accessing }
BrColumnSortState >> column: aColumn [
	column := aColumn
]

{ #category : #headers }
BrColumnSortState >> iconElement [
	^ self subclassResponsibility
]

{ #category : #headers }
BrColumnSortState >> iconElementForColumn: aColumn [
	^ column == aColumn
		ifTrue: [ self iconElement ]
		ifFalse: [ BrColumnUnsortedState new iconElement ]
]

{ #category : #testing }
BrColumnSortState >> isAscending [
	^ false
]

{ #category : #testing }
BrColumnSortState >> isDescending [
	^ false
]

{ #category : #testing }
BrColumnSortState >> isUnsorted [
	^ false
]

{ #category : #transitions }
BrColumnSortState >> nextForColumn: aColumn [
	^ column == aColumn
		ifTrue: [ self reversed ]
		ifFalse: [ BrColumnSortedAscendingState new column: aColumn ]
]

{ #category : #sorting }
BrColumnSortState >> orderedItems: items [
	| indexed sortBlock |
	sortBlock := column sortBlock.
	indexed := items asArray withIndexCollect: [ :item :index | index -> item ].
	indexed := indexed sorted: [ :a :b |
		| ab ba |
		ab := sortBlock value: a value value: b value.
		ba := sortBlock value: b value value: a value.
		ab = ba
			ifTrue: [ a key <= b key ]
			ifFalse: [ self ordersAscending: ab descending: ba ] ].
	^ indexed collect: #value
]

{ #category : #sorting }
BrColumnSortState >> ordersAscending: ascending descending: descending [
	^ self subclassResponsibility
]

{ #category : #transitions }
BrColumnSortState >> reversed [
	^ self subclassResponsibility
]
