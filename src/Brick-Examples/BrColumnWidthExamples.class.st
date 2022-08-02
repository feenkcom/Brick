"
# Column width examples

The {{gtClass:BrColumnWidth}} is an abstract class. There are examples for each type of the column width:

- {{gtClass:BrColumnFixedWidthExamples}} to see examples of the fixed column width
- {{gtClass:BrColumnProportionalWidthExamples}} to see examples of the proportional column width
- {{gtClass:BrColumnUndefinedWidthExamples}} to see examples of the undefined column width

"
Class {
	#name : #BrColumnWidthExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-! Model - Column'
}

{ #category : #examples }
BrColumnWidthExamples >> columnWidthIsAbstract [
	<gtExample>
	
	self assert: BrColumnWidth isAbstract.
	
	^ BrColumnWidth isAbstract
]
