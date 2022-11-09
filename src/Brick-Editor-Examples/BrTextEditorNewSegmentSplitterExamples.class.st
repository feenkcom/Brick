Class {
	#name : #BrTextEditorNewSegmentSplitterExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Model'
}

{ #category : #accessing }
BrTextEditorNewSegmentSplitterExamples >> noAttributes [
	<gtExample>
	| text pieces |
	text := 'Hello World' asRopedText.
	pieces := BrTextEditorNewSegmentSplitter new
			split: text
			from: 0
			to: text size.
	self assert: pieces size = 1.
	^ pieces
]

{ #category : #accessing }
BrTextEditorNewSegmentSplitterExamples >> withAdornments [
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
	pieces := BrTextEditorNewSegmentSplitter new
			split: text
			from: 0
			to: text size.
	self assert: pieces size = 4.
	^ pieces
]

{ #category : #accessing }
BrTextEditorNewSegmentSplitterExamples >> withAttributes [
	<gtExample>
	| text pieces |
	text := 'Hello World' asRopedText.
	text
		attributes: {BlTextForegroundAttribute color: Color red}
		from: 3
		to: 5.
	pieces := BrTextEditorNewSegmentSplitter new
			split: text
			from: 0
			to: text size.
	self assert: pieces size = 1.
	^ pieces
]
