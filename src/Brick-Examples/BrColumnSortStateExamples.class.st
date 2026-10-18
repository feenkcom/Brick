"
Examples of the three polymorphic sorting states and their transitions.
"
Class {
	#name : #BrColumnSortStateExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-List'
}

{ #category : #examples }
BrColumnSortStateExamples >> ascending [
	<gtExample>
	| state column |
	column := BrColumn new sortBy: [ :a :b | a <= b ].
	state := self unsorted nextForColumn: column.
	self assert: state isAscending.
	self assert: state isUnsorted not.
	self assert: state column == column.
	self assert: (state orderedItems: #(10 2 30 2)) equals: #(2 2 10 30).
	^ state
]

{ #category : #examples }
BrColumnSortStateExamples >> clearSorting [
	<gtExample>
	| list |
	list := BrColumnedListHeaderExamples new list.
	list selectOne: 1.
	list sortByColumn: list columns first.
	list beUnsorted.
	self assert: list sortState isUnsorted.
	self assert: list sortedColumn isNil.
	self assert: list selectedItems asArray equals: #(10).
	list items: #(30 10 2).
	self assert: list items asArray equals: #(30 10 2).
	^ list
]

{ #category : #examples }
BrColumnSortStateExamples >> descending [
	<gtExample>
	| ascending state |
	ascending := self ascending.
	state := ascending nextForColumn: ascending column.
	self assert: state isDescending.
	self assert: state isAscending not.
	self assert: state isUnsorted not.
	self assert: state column == ascending column.
	self assert: (state orderedItems: #(10 2 30 2)) equals: #(30 10 2 2).
	self assert: (state nextForColumn: state column) isAscending.
	^ state
]

{ #category : #examples }
BrColumnSortStateExamples >> switchColumn [
	<gtExample>
	| state column next |
	state := self descending.
	column := BrColumn new sortBy: [ :a :b | a <= b ].
	next := state nextForColumn: column.
	self assert: next isAscending.
	self assert: next column == column.
	self assert: (next iconElementForColumn: state column) width equals: 0.
	^ next
]

{ #category : #examples }
BrColumnSortStateExamples >> unsorted [
	<gtExample>
	| state |
	state := BrColumnUnsortedState new.
	self assert: state isUnsorted.
	self assert: state isAscending not.
	self assert: state isDescending not.
	self assert: state column isNil.
	self assert: (state orderedItems: #(3 1 2)) equals: #(3 1 2).
	self assert: state iconElement width equals: 0.
	^ state
]
