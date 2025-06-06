Class {
	#name : #BrExpanderExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Expander'
}

{ #category : #'examples - with text' }
BrExpanderExamples >> expanderWithText [
	<gtExample>
	<return: #BrExpander>
	| anExpander aText |
	aText := 'I am the first line of the text' , String cr , 'I am the second line'.

	anExpander := BrExpander new
			vFitContent;
			hExact: 300;
			collapse;
			margin: (BlInsets all: 10);
			aptitude: BrGlamorousExpanderAptitude new;
			header: [ BrEditorElement new
					editor: (BrTextEditorModel new text: aText lines first asRopedText) ];
			content: [ BrEditorElement new editor: (BrTextEditorModel new text: aText asRopedText) ].

	^ anExpander
]
