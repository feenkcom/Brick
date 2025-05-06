Class {
	#name : #BrTextEditorCompositeInputFilterExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Model'
}

{ #category : #examples }
BrTextEditorCompositeInputFilterExamples >> simpleInputFilter [
	<gtExample>
	<return: #BrTextEditorCompositeInputFilter>
	| filter |
	filter := BrTextEditorCompositeInputFilter new
			addFilter: BrTextEditorNoSpaceInputFilter new;
			addFilter: BrTextEditorNoLineBreakInputFilter new.

	self
		assert: (filter
				filter: ' hi there
	')
		equals: 'hithere'.

	^ filter
]
