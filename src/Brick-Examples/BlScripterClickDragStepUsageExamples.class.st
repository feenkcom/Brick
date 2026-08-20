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
	<noTest>
	"It works locally but not on CI"
	| aScripter beforeClickVector whileDragVector |
	beforeClickVector := BlVector x: -380 y: 0.
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

{ #category : #'examples - elements' }
BlScripterClickDragStepUsageExamples >> elementWithEditor [
	<gtExample>
	| editor |
	editor := BrEditor new
			id: #testEditor;
			aptitude: BrGlamorousEditorAptitude;
			text: 'hello world example'.
	^ BrFrame new
			matchParent;
			addChild: editor
]
