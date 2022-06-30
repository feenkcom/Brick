Class {
	#name : #BrTextEditorLineSegmentSplitterExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Model'
}

{ #category : #accessing }
BrTextEditorLineSegmentSplitterExamples >> noAttributes [
	<gtExample>
	| text pieces |
	text := 'Hello World' asRopedText.
	pieces := BrTextEditorLineSegmentSplitter new
			split: text
			from: 0
			to: text size.
	self assert: pieces size = 3.
	^ pieces
]

{ #category : #accessing }
BrTextEditorLineSegmentSplitterExamples >> withAdornments [
	<gtExample>
	| text pieces |
	text := 'Hello World' asRopedText.
	text
		attributes: {BrTextAdornmentDynamicAttribute new
					beAppend;
					stencil: [ BlElement new
							size: 10 @ 10;
							background: Color red ]}
		from: 3
		to: 3.
	pieces := BrTextEditorLineSegmentSplitter new
			split: text
			from: 0
			to: text size.
	self assert: pieces size = 5.
	^ pieces
]

{ #category : #accessing }
BrTextEditorLineSegmentSplitterExamples >> withAttributes [
	<gtExample>
	| text pieces |
	text := 'Hello World' asRopedText.
	text
		attributes: {BlTextForegroundAttribute color: Color red}
		from: 3
		to: 5.
	pieces := BrTextEditorLineSegmentSplitter new
			split: text
			from: 0
			to: text size.
	self assert: pieces size = 3.
	^ pieces
]

{ #category : #accessing }
BrTextEditorLineSegmentSplitterExamples >> withStartingAdornment [
	<gtExample>
	| text pieces |
	text := 'Hello World' asRopedText.
	text
		attributes: {BrTextAdornmentDynamicAttribute new
					beAppend;
					stencil: [ BlElement new
							size: 10 @ 10;
							background: Color red ]}
		from: 0
		to: 0.
	pieces := BrTextEditorLineSegmentSplitter new
			split: text
			from: 0
			to: text size.
	self assert: pieces size = 4.
	^ pieces
]
