Class {
	#name : #BrTextEditorSegmentSplitterExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Model'
}

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> appendingAdornmentAtEndTextSplit [
	<gtExample>
	| segments text attr |
	text := self simpleText.
	text
		attributes: {attr := BrTextAdornmentDynamicAttribute new
						beAppend;
						stencil: [ BlElement new
								size: 10 @ 10;
								background: Color red ]}
		from: 10
		to: 10.
	segments := self splitterClass new
			split: text
			from: 1
			to: text size.
	self assert: segments size equals: 2.
	self assert: segments first isText.
	self assert: segments first textStart equals: 1.
	self assert: segments first textEnd equals: 11.
	self assert: segments first text asString equals: '1234567890'.
	self assert: (segments second isKindOf: BrTextEditorLineSegmentAdornmentPiece).
	self assert: segments second adornmentAttribute equals: attr.
	^ segments
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> appendingAdornmentTextSplit [
	<gtExample>
	| segments text attr |
	text := self simpleText.
	text
		attributes: {attr := BrTextAdornmentDynamicAttribute new
						beAppend;
						stencil: [ BlElement new
								size: 10 @ 10;
								background: Color red ]}
		from: 3
		to: 3.
	segments := self splitterClass new
			split: text
			from: 1
			to: text size.
	self assert: segments size equals: 3.
	self assert: segments first isText.
	self assert: segments first textStart equals: 1.
	self assert: segments first textEnd equals: 4.
	self assert: segments first text asString equals: '123'.
	self assert: (segments second isKindOf: BrTextEditorLineSegmentAdornmentPiece).
	self assert: segments second adornmentAttribute equals: attr.
	self assert: segments last isText.
	self assert: segments last textStart equals: 4.
	self assert: segments last textEnd equals: 11.
	self assert: segments last text asString equals: '4567890'.
	^ segments
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> appendingInReplacingAdornmentTextSplit [
	<gtExample>
	| segments text replacing appending|
	text := self simpleText.
	text
		attributes: {replacing := BrTextAdornmentDynamicAttribute new
						beReplace;
						stencil: [ BlElement new
								size: 10 @ 10;
								background: Color red ]}
		from: 3
		to: 6.
	text
		attributes: {appending := BrTextAdornmentDynamicAttribute new
						beAppend;
						stencil: [ BlElement new
								size: 10 @ 10;
								background: Color yellow ]}
		from: 4
		to: 4.
	segments := self splitterClass new
			split: text
			from: 1
			to: text size.
	self assert: segments size equals: 4.
	self assert: segments first isText.
	self assert: segments first textStart equals: 1.
	self assert: segments first textEnd equals: 3.
	self assert: segments first text asString equals: '12'.
	self assert: (segments second isKindOf: BrTextEditorLineSegmentAdornmentPiece).
	self assert: segments second adornmentAttribute equals: appending.
	self assert: segments second text asString equals: '34'.
	self assert: (segments third isKindOf: BrTextEditorLineSegmentAdornmentPiece).
	self assert: segments third adornmentAttribute equals: replacing.
	self assert: segments third text asString equals: '56'.
	self assert: segments last isText.
	self assert: segments last textStart equals: 7.
	self assert: segments last textEnd equals: 11.
	self assert: segments last text asString equals: '7890'.
	^ segments
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> cursorTextSplit [
	<gtExample>
	| segments text |
	text := self simpleText.
	text
		attributes: {BrTextCursorAttribute new enterAction: [ :editor |  ]}
		from: 1
		to: 1.
	text
		attributes: {BrTextCursorAttribute new enterAction: [ :editor |  ]}
		from: text size
		to: text size.
	segments := self splitterClass new
			split: text
			from: 1
			to: text size.
	self assert: segments size equals: 3.
	self
		assert: segments first text asString
		equals: (self simpleText asString first: 1).
	self
		assert: segments second text asString
		equals: self simpleText asString allButFirst allButLast.
	self
		assert: segments third text asString
		equals: (self simpleText asString last: 1).
	^ segments
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> emptyTextSplit [
	<gtExample>
	| segments |
	segments := self splitterClass new
			split: '' asRopedText
			from: 1
			to: 0.
	self assert: segments size equals: 1.
	self assert: segments first isText.
	self assert: segments first textStart equals: 1.
	self assert: segments first textEnd equals: 0.
	^ segments
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> noAttributes [
	<gtExample>
	| text pieces |
	text := 'Hello World' asRopedText.
	pieces := self splitterClass new
			split: text
			from: 0
			to: text size.
	self assert: pieces size = 1.
	^ pieces
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> overlayAdornmentTextSplit [
	<gtExample>
	| segments text attr |
	text := self simpleText.
	text
		attributes: {attr := BrTextAdornmentDynamicAttribute new
						beOverlay;
						stencil: [ BlElement new
								size: 10 @ 10;
								background: Color red ]}
		from: 3
		to: 3.
	segments := self splitterClass new
			split: text
			from: 1
			to: text size.
	self assert: segments size equals: 3.
	self assert: segments first isText.
	self assert: segments first textStart equals: 1.
	self assert: segments first textEnd equals: 3.
	self assert: segments first text asString equals: '12'.
	self assert: (segments second isKindOf: BrTextEditorLineSegmentAdornmentPiece).
	self assert: segments second adornmentAttribute equals: attr.
	self assert: segments last isText.
	self assert: segments last textStart equals: 3.
	self assert: segments last textEnd equals: 11.
	self assert: segments last text asString equals: '34567890'.
	^ segments
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> replacingAdornmentTextSplit [
	<gtExample>
	| segments text attr |
	text := self simpleText.
	text
		attributes: {attr := BrTextAdornmentDynamicAttribute new
						beReplace;
						stencil: [ BlElement new
								size: 10 @ 10;
								background: Color red ]}
		from: 3
		to: 4.
	segments := self splitterClass new
			split: text
			from: 1
			to: text size.
	self assert: segments size equals: 3.
	self assert: segments first isText.
	self assert: segments first textStart equals: 1.
	self assert: segments first textEnd equals: 3.
	self assert: segments first text asString equals: '12'.
	self assert: (segments second isKindOf: BrTextEditorLineSegmentAdornmentPiece).
	self assert: segments second adornmentAttribute equals: attr.
	self assert: segments second text asString equals: '34'.
	self assert: segments last isText.
	self assert: segments last textStart equals: 5.
	self assert: segments last textEnd equals: 11.
	self assert: segments last text asString equals: '567890'.
	^ segments
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> replacingAdornmentWithCursorTextSplit [
	<gtExample>
	| segments text attr |
	text := self simpleText.
	text
		attributes: {attr := BrTextAdornmentDynamicAttribute new
						beReplace;
						stencil: [ BlElement new
								size: 10 @ 10;
								background: Color red ]}
		from: 1
		to: text size.
	text
		attributes: {BrTextCursorAttribute new enterAction: [ :editor |  ]}
		from: text size
		to: text size.
	segments := self splitterClass new
			split: text
			from: 1
			to: text size.
	self assert: segments size equals: 1.
	self assert: (segments first isKindOf: BrTextEditorLineSegmentAdornmentPiece).
	self assert: segments first adornmentAttribute equals: attr.
	^ segments
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> simpleStyledTextSplit [
	<gtExample>
	| segments text |
	text := self simpleText.
	text bold.
	(text from: 3 to: 5) foreground: Color red.
	segments := self splitterClass new
			split: text
			from: 1
			to: text size.
	self assert: segments size equals: 1.
	self assert: segments first isText.
	self assert: segments first textStart equals: 1.
	self assert: segments first textEnd equals: text size + 1.
	^ segments
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> simpleText [
	^ '1234567890' asRopedText
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> simpleTextSplit [
	<gtExample>
	| segments text |
	text := self simpleText.
	segments := self splitterClass new
			split: text
			from: 1
			to: text size.
	self assert: segments size equals: 1.
	self assert: segments first isText.
	self assert: segments first textStart equals: 1.
	self assert: segments first textEnd equals: text size + 1.
	^ segments
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> splitterClass [
	^ BrTextEditorSegmentSplitter
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> withAdornments [
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
	pieces := self splitterClass new
			split: text
			from: 0
			to: text size.
	self assert: pieces size = 3.
	^ pieces
]

{ #category : #accessing }
BrTextEditorSegmentSplitterExamples >> withAttributes [
	<gtExample>
	| text pieces |
	text := 'Hello World' asRopedText.
	text
		attributes: {BlTextForegroundAttribute color: Color red}
		from: 3
		to: 5.
	pieces := self splitterClass new
			split: text
			from: 0
			to: text size.
	self assert: pieces size = 1.
	^ pieces
]
