Class {
	#name : #BlScripterClickDragStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Brick-Examples-Examples'
}

{ #category : #'examples - scripter' }
BlScripterClickDragStepUsageExamples >> doubleClickDragToSelectMultipleWords [
	"Demonstrates double-clicking dragging in an editor to select multiple words.
	As the curser moves onto a new word it snaps to select the whole word."
	<gtExample>
	| aScripter beforeClickVector whileDragVector |
	beforeClickVector := BlVector x: -65 y: 0.
	whileDragVector := BlVector x: 50 y: 0.
	aScripter := self scripter.
	aScripter element: self elementWithEditor.
	aScripter clickDragStep: 
			[:s |
			s
				label: 'Simple Click Behaviour';
				id: #testEditor;
				// BrTextEditorParagraphElement;
				beforeClickMoveBy: beforeClickVector;
				whileDragMoveBy: whileDragVector].
	aScripter assertStep: 
			[:s |
			s
				label: 'Partial words selected';
				id: #testEditor;
				value: [:anEditor | anEditor editor selectedText asString]
					equals: ['llo wo']].
	aScripter clickDragStep: 
			[:s |
			s
				label: 'Double Click Behaviour';
				id: #testEditor;
				// BrTextEditorParagraphElement;
				beforeClickMoveBy: beforeClickVector;
				whileDragMoveBy: whileDragVector;
				useDoubleClick].
	aScripter assertStep: 
			[:s |
			s
				label: 'Whole words selected, no partial word';
				id: #testEditor;
				value: [:anEditor | anEditor editor selectedText asString]
					equals: ['hello world']].
	^aScripter
]

{ #category : #examples }
BlScripterClickDragStepUsageExamples >> elementWithEditor [
	<gtExample>
	| editor |
	editor := BrEditor new.
	editor id: #testEditor.
	editor aptitude: BrEditorAptitude new.
	editor padding: BlInsets empty.
	editor fitContent.
	editor text: ('hello world example' asRopedText
				lineSpacing: 5;
				paragraphMargin: (BlInsets all: 15);
				wordPadding: (BlInsets top: 3 bottom: 3);
				yourself).
	editor editor segmentBuilder
		wordStencil: [ :aPiece |
			| aTextElement |
			aTextElement := BrTextEditableWordPieceStencilBuilder new
				segmentPiece: aPiece;
				asElement.
			aTextElement measurer: (BlTextElementMockedMeasurer new
				ascent: -20;
				descent: 20;
				glyphWidth: 10;
				glyphHeight: 40).
			aTextElement measurer textOffset: aPiece textStart.
			aTextElement ].
	editor requestFocus.
	editor forceLayout.
	^ BrFrame new
			matchParent;
			addChild: editor
]
