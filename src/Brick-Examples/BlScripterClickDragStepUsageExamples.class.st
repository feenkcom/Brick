Class {
	#name : #BlScripterClickDragStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'Brick-Examples-Examples'
}

{ #category : #examples }
BlScripterClickDragStepUsageExamples >> doubleClickDragToSelectMultipleWords [
	"Demonstrates double-clicking dragging in an editor to select multiple words.
	As the curser moves onto a new word it snaps to select the whole word.

	The click positions are computed from the paragraph's actual cursor geometry
	(BrTextEditorParagraphElement>>#cursorRectangleForCharacter:) instead of
	hard-coded pixel offsets - hard-coded offsets were found to be unreliable
	across platforms, since even with a deterministic BlTextElementMockedMeasurer
	the exact pixel where a click resolves to a given character can differ
	slightly between platforms.

	This variant clicks 30% into the target character rather than exactly on its
	boundary, as a margin against the click-position query and the mouse
	hit-test not agreeing to the last bit of floating-point precision on every
	platform. Compare with #doubleClickDragToSelectMultipleWordsAtExactBoundary,
	which omits that margin.

	These two examples are meant to differ only in that one detail, so together
	they work as a diagnostic pair: if one of them starts failing on some
	platform while the other keeps passing, that tells us which of the two
	strategies is the fragile one there. Review the difference at that point and
	remove whichever one turns out to be unreliable, keeping only the survivor."
	<gtExample>
	^ self doubleClickDragToSelectMultipleWordsWithBias: 0.3
]

{ #category : #examples }
BlScripterClickDragStepUsageExamples >> doubleClickDragToSelectMultipleWordsAtExactBoundary [
	"See the comment on #doubleClickDragToSelectMultipleWords - same scenario,
	but clicking exactly on the character boundary instead of 30% into it."
	<gtExample>
	^ self doubleClickDragToSelectMultipleWordsWithBias: 0.0
]

{ #category : #private }
BlScripterClickDragStepUsageExamples >> doubleClickDragToSelectMultipleWordsWithBias: aBiasFraction [
	<return: #BlScripter>
	| aScripter anElement paragraphElement beforeClickVector whileDragVector
	  startCursorX endCursorX charWidth frameCenterX textLength |
	aScripter := self scripter.
	anElement := self elementWithEditor.
	aScripter element: anElement.

	paragraphElement := anElement
		allChildrenBreadthFirstDetect: [ :e | e isKindOf: BrTextEditorParagraphElement ]
		ifFound: [ :e | e ]
		ifNone: [ self error: 'BrTextEditorParagraphElement not found' ].
	paragraphElement topMostParent forceLayout.

	textLength := paragraphElement text size.
	"cursorRectangleForCharacter: is expressed relative to the text content,
	not to paragraphElement bounds (which also includes the paragraph margin) -
	staying inside this one frame and using the text's own midpoint as the
	reference point keeps that constant offset from ever entering the maths."
	frameCenterX := (paragraphElement cursorRectangleForCharacter: textLength) origin x / 2.
	charWidth := (paragraphElement cursorRectangleForCharacter: 3) origin x
		- (paragraphElement cursorRectangleForCharacter: 2) origin x.
	startCursorX := (paragraphElement cursorRectangleForCharacter: 2) origin x + (charWidth * aBiasFraction).
	endCursorX := (paragraphElement cursorRectangleForCharacter: 8) origin x - (charWidth * aBiasFraction).

	beforeClickVector := BlVector x: startCursorX - frameCenterX y: 0.
	whileDragVector := BlVector x: endCursorX - startCursorX y: 0.

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
	^ BrFrame new
			matchParent;
			addChild: editor
]
