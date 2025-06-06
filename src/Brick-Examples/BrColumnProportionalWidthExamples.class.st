Class {
	#name : #BrColumnProportionalWidthExamples,
	#superclass : #BrColumnWidthExamples,
	#category : #'Brick-Examples-! Model - Column'
}

{ #category : #examples }
BrColumnProportionalWidthExamples >> applyOnElement [
	<gtExample>
	<return: #BlElement>
	| anElement aColumnWidth |
	aColumnWidth := BrColumnProportionalWidth new weight: 0.5.

	anElement := BlElement new
			background: Color lightGray;
			border: (BlBorder paint: Color gray width: 2);
			size: 50 @ 50.

	aColumnWidth applyOn: anElement.

	self
		assert: (anElement states hasState: BrLayoutHorizontalResizerState matchParent).
	self
		assert: anElement constraints horizontal resizer
		equals: BlLayoutResizer matchParent.
	self
		assert: anElement constraints vertical resizer
		equals: (BlLayoutResizer exact: 50).
	self assert: anElement constraints linear weight equals: 0.5.
	self assert: anElement constraints frame horizontal weight equals: 0.5.

	^ anElement
]

{ #category : #examples }
BrColumnProportionalWidthExamples >> default [
	<gtExample>
	<return: #BrColumnProportionalWidth>
	| aColumnWidth |
	aColumnWidth := BrColumnProportionalWidth new.

	self assert: aColumnWidth weight equals: 1.0.

	^ aColumnWidth
]

{ #category : #examples }
BrColumnProportionalWidthExamples >> equalsAndHash [
	<gtExample>
	<return: #True>
	| aColumnWidth anotherColumnWidth |
	aColumnWidth := BrColumnProportionalWidth new weight: 0.5.
	anotherColumnWidth := BrColumnProportionalWidth new weight: 0.5.

	self assert: aColumnWidth equals: anotherColumnWidth.
	self assert: aColumnWidth hash equals: anotherColumnWidth hash.

	^ aColumnWidth = anotherColumnWidth
]

{ #category : #examples }
BrColumnProportionalWidthExamples >> notEquals [
	<gtExample>
	<return: #False>
	| aColumnWidth anotherColumnWidth |
	aColumnWidth := BrColumnProportionalWidth new weight: 0.2.
	anotherColumnWidth := BrColumnProportionalWidth new weight: 0.4.

	self assert: (aColumnWidth = anotherColumnWidth) not.

	^ aColumnWidth = anotherColumnWidth
]

{ #category : #examples }
BrColumnProportionalWidthExamples >> setWeight [
	<gtExample>
	<return: #BrColumnProportionalWidth>
	| aColumnWidth |
	aColumnWidth := BrColumnProportionalWidth new weight: 0.2.
	self assert: aColumnWidth weight equals: 0.2.

	aColumnWidth weight: 0.5.
	self assert: aColumnWidth weight equals: 0.5.

	^ aColumnWidth
]
