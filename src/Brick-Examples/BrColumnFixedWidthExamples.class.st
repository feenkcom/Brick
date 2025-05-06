Class {
	#name : #BrColumnFixedWidthExamples,
	#superclass : #BrColumnWidthExamples,
	#category : #'Brick-Examples-! Model - Column'
}

{ #category : #examples }
BrColumnFixedWidthExamples >> applyOnElement [
	<gtExample>
	<return: #BlElement>
	| anElement aColumnWidth |
	aColumnWidth := BrColumnFixedWidth new width: 300.

	anElement := BlElement new
			background: Color lightGray;
			border: (BlBorder paint: Color gray width: 2);
			size: 50 @ 50.

	aColumnWidth applyOn: anElement.

	self assert: (anElement states hasState: BrLayoutHorizontalResizerState exact).
	self
		assert: anElement constraints horizontal resizer
		equals: (BlLayoutResizer exact: 300.0).
	self
		assert: anElement constraints vertical resizer
		equals: (BlLayoutResizer exact: 50.0).

	^ anElement
]

{ #category : #examples }
BrColumnFixedWidthExamples >> default [
	<gtExample>
	<return: #BrColumnFixedWidth>
	| aColumnWidth |
	aColumnWidth := BrColumnFixedWidth new.

	self assert: aColumnWidth width equals: 200.

	^ aColumnWidth
]

{ #category : #examples }
BrColumnFixedWidthExamples >> equalsAndHash [
	<gtExample>
	<return: #True>
	| aColumnWidth anotherColumnWidth |
	aColumnWidth := BrColumnFixedWidth new width: 300.
	anotherColumnWidth := BrColumnFixedWidth new width: 300.

	self assert: aColumnWidth equals: anotherColumnWidth.
	self assert: aColumnWidth hash equals: anotherColumnWidth hash.

	^ aColumnWidth = anotherColumnWidth
]

{ #category : #examples }
BrColumnFixedWidthExamples >> notEquals [
	<gtExample>
	<return: #False>
	| aColumnWidth anotherColumnWidth |
	aColumnWidth := BrColumnFixedWidth new width: 300.
	anotherColumnWidth := BrColumnFixedWidth new width: 400.

	self assert: (aColumnWidth = anotherColumnWidth) not.

	^ aColumnWidth = anotherColumnWidth
]

{ #category : #examples }
BrColumnFixedWidthExamples >> setWidth [
	<gtExample>
	<return: #BrColumnFixedWidth>
	| aColumnWidth |
	aColumnWidth := BrColumnFixedWidth new width: 300.
	self assert: aColumnWidth width equals: 300.

	aColumnWidth width: 400.
	self assert: aColumnWidth width equals: 400.

	^ aColumnWidth
]
