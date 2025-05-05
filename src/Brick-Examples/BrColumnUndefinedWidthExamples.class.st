Class {
	#name : #BrColumnUndefinedWidthExamples,
	#superclass : #BrColumnWidthExamples,
	#category : #'Brick-Examples-! Model - Column'
}

{ #category : #examples }
BrColumnUndefinedWidthExamples >> applyOnElement [
	<gtExample>
	<return: #BlElement>
	| anElement aColumnWidth |
	aColumnWidth := BrColumnUndefinedWidth new.

	anElement := BlElement new
			background: Color lightGray;
			border: (BlBorder paint: Color gray width: 2);
			size: 50 @ 50.

	aColumnWidth applyOn: anElement.

	self
		assert: anElement constraints horizontal resizer
		equals: (BlLayoutResizer exact: 50).
	self
		assert: anElement constraints vertical resizer
		equals: (BlLayoutResizer exact: 50).

	^ anElement
]

{ #category : #accessing }
BrColumnUndefinedWidthExamples >> default [
	<gtExample>
	<return: #BrColumnUndefinedWidth>
	| aColumnWidth |
	aColumnWidth := BrColumnUndefinedWidth new.

	^ aColumnWidth
]

{ #category : #examples }
BrColumnUndefinedWidthExamples >> equalsAndHash [
	<gtExample>
	<return: #True>
	| aColumnWidth anotherColumnWidth |
	aColumnWidth := BrColumnUndefinedWidth new.
	anotherColumnWidth := BrColumnUndefinedWidth new.

	self assert: aColumnWidth equals: anotherColumnWidth.
	self assert: aColumnWidth hash equals: anotherColumnWidth hash.

	^ aColumnWidth = anotherColumnWidth
]

{ #category : #examples }
BrColumnUndefinedWidthExamples >> notEquals [
	<gtExample>
	<return: #False>
	| aColumnWidth anotherColumnWidth |
	aColumnWidth := BrColumnUndefinedWidth new.
	anotherColumnWidth := BrColumnProportionalWidth new weight: 0.4.

	self assert: (aColumnWidth = anotherColumnWidth) not.

	^ aColumnWidth = anotherColumnWidth
]
