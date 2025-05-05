Class {
	#name : #BrTextEditorParagraphAttributesExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples'
}

{ #category : #'instance creation' }
BrTextEditorParagraphAttributesExamples >> editorElement [
	<gtExample>
	<return: #BrEditorElement>
	| textEditor editorElement |
	textEditor := BrTextEditorModel new.
	editorElement := BrEditorElement new.
	editorElement editor: textEditor.
	editorElement
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].

	^ editorElement
]

{ #category : #examples }
BrTextEditorParagraphAttributesExamples >> helloEditor [
	<gtExample>
	<return: #BrEditorElement>
	| anEditorElement aSegment |
	anEditorElement := self editorElement.
	anEditorElement editor text: self helloText.

	anEditorElement forceLayout.

	self
		assert: anEditorElement editor segmentCollector computedSegmentsCount
		equals: 1.

	aSegment := anEditorElement editor segmentCollector cachedSegmentAt: 1.

	self assert: aSegment lineSpacing equals: 20.
	self assert: aSegment wordPadding equals: (BlInsets top: 10 bottom: 10).
	self
		assert: aSegment paragraphMargin
		equals: (BlInsets
				top: 15
				left: 20
				bottom: 15
				right: 20).

	^ anEditorElement
]

{ #category : #examples }
BrTextEditorParagraphAttributesExamples >> helloText [
	<gtExample>
	<return: #BlRunRopedText>
	| aText |
	aText := 'Hello' asRopedText
			fontSize: 20;
			lineSpacing: 20;
			wordPadding: (BlInsets top: 10 bottom: 10);
			paragraphMargin: (BlInsets
					top: 15
					left: 20
					bottom: 15
					right: 20).

	self
		assert: aText iterator attributes
		equals: {BlFontSizeAttribute size: 20.
				BrTextParagraphLineSpacingAttribute lineSpacing: 20.
				BrTextParagraphWordPaddingAttribute
					wordPadding: (BlInsets top: 10 bottom: 10).
				BrTextParagraphMarginAttribute
					paragraphMargin: (BlInsets
							top: 15
							left: 20
							bottom: 15
							right: 20)}.

	^ aText
]
