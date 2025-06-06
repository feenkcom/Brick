Class {
	#name : #BrTextEditorSelecterExamples,
	#superclass : #BrTextEditorOperatorExamples,
	#category : #'Brick-Editor-Examples-Operators'
}

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_all_in_empty [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnEmptyText.

	anEditor selecter all select.

	self assert: anEditor cursors isEmpty.
	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_all_in_empty_with_curor [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnEmptyText.

	anEditor navigator
		addAt: 0;
		apply.

	self assert: anEditor cursors isNotEmpty.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self assert: anEditor selection isEmpty.

	anEditor selecter all select.

	self assert: anEditor cursors isNotEmpty.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_all_reduced [
	"There was a bug, that if a new text is smaller than the existing selection, then things can go wrong"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor selecter all select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 0 to: self multilineText size).
	self
		assert: anEditor cursors
		equals: (BrTextEditorCursor atAll: {self multilineText size}).

	anEditor text: 'hello'.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 0 to: 5).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {5}).

	anEditor selecter all select.

	anEditor text: 'hi'.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 0 to: 2).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {2}).

	^ anEditor
]

{ #category : #'examples - word' }
BrTextEditorSelecterExamples >> select_braces [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnTextWithDelimiters.
	anEditor selecter
		selectionUnitAt: 126;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 126 to: 137).
	self assert: anEditor editor selectedText asString equals: 'also braces'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(137)).

	^ anEditor
]

{ #category : #'examples - word' }
BrTextEditorSelecterExamples >> select_braces_end [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnTextWithDelimiters.
	anEditor selecter
		selectionUnitAt: 137;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 126 to: 137).
	self assert: anEditor editor selectedText asString equals: 'also braces'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(137)).

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_brackets [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnTextWithDelimiters.
	anEditor selecter
		selectionUnitAt: 106;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 106 to: 118).
	self assert: anEditor editor selectedText asString equals: 'brackets too'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(118)).

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_brackets_end [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnTextWithDelimiters.
	anEditor selecter
		selectionUnitAt: 118;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 106 to: 118).
	self assert: anEditor editor selectedText asString equals: 'brackets too'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(118)).

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_double_quotes [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnTextWithDelimiters.
	anEditor selecter
		selectionUnitAt: 10;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 10 to: 22).
	self assert: anEditor editor selectedText asString equals: 'Hello, world'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(22)).

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_double_quotes_end [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnTextWithDelimiters.
	anEditor selecter
		selectionUnitAt: 22;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 10 to: 22).
	self assert: anEditor editor selectedText asString equals: 'Hello, world'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(22)).

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_extendSelectionWithNoCursor [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor selecter
		extendToIndex: 5;
		select.

	^ anEditor
]

{ #category : #'examples - from to' }
BrTextEditorSelecterExamples >> select_from_0_to_5 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.

	anEditor selecter
		from: 0 to: 5;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 0 to: 5).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(5)).

	^ anEditor
]

{ #category : #'examples - from to' }
BrTextEditorSelecterExamples >> select_from_0_to_5_in_steps [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.

	anEditor selecter
		from: 0 to: 1;
		select;
		from: 1 to: 2;
		select;
		from: 2 to: 3;
		select;
		from: 3 to: 4;
		select;
		from: 4 to: 5;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 0 to: 5).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(5)).

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneDown_at_6 [
	<gtExample>
	<noTest>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 6.
	
	anEditor selecter
		moveOneDown;
		select.
	
	self 
		assert: anEditor selection 
		equals: (BlCompositeSelection new select: 6 to: 36).
	
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(36)).
	
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneDown_at_6_thenUp [
	<gtExample>
	<noTest>
	| anEditor |

	anEditor := self select_moveOneDown_at_6.
	
	anEditor selecter
		moveOneUp;
		select.
	
	self 
		assert: anEditor selection isEmpty.
	
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(6)).
	
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneLeft_at_0 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 0.
	anEditor selecter
		moveOneToLeft;
		select.
	self assert: anEditor selection isEmpty.
	self assert: anEditor editor selectedText asString equals: ''.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(0)).
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneLeft_at_4 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 4.

	anEditor selecter
		moveOneToLeft;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 3 to: 4).
	self assert: anEditor editor selectedText asString equals: 'u'.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(3)).


	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneLeft_at_4_extendToNextWordEnd [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self select_moveOneLeft_at_4.

	anEditor selecter
		extendToNextWordEnd;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 4 to: 8).
	self assert: anEditor editor selectedText asString equals: 'mmer'.

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneRight_at_6 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 6.
	anEditor selecter
		moveOneToRight;
		select.
	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 6 to: 7).
	self assert: anEditor editor selectedText asString equals: 'e'.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(7)).
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneRight_at_6_extendToNextWordEnd [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self select_moveOneRight_at_6.

	anEditor selecter
		extendToNextWordEnd;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 6 to: 8).
	self assert: anEditor editor selectedText asString equals: 'er'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(8)).

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneRight_at_6_extendToNextWordEnd_twice [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self select_moveOneRight_at_6_extendToNextWordEnd.
	anEditor selecter
		extendToNextWordEnd;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 6 to: 9).
	self assert: anEditor editor selectedText asString equals: 'er '.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(9)).

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneRight_at_6_extendToPreviousWordStart [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self select_moveOneRight_at_6.
	anEditor selecter
		extendToPreviousWordStart;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 2 to: 6).
	self assert: anEditor editor selectedText asString equals: 'summ'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(2)).

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneRight_at_6_extendToPreviousWordStart_twice [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self select_moveOneRight_at_6_extendToPreviousWordStart.
	anEditor selecter
		extendToPreviousWordStart;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 1 to: 6).
	self assert: anEditor editor selectedText asString equals: ' summ'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(1)).

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneRight_at_End [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: anEditor text size.
	anEditor selecter
		moveOneToRight;
		select.
	self assert: anEditor selection isEmpty.
	self assert: anEditor editor selectedText asString equals: ''.
	self
		assert: anEditor cursors
		equals: (BrTextEditorCursor atAll: {anEditor text size}).

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneUp_at_35 [
	<gtExample>
	<noTest>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 35.
	
	anEditor selecter
		moveOneUp;
		select.
	
	self 
		assert: anEditor selection 
		equals: (BlCompositeSelection new select: 6 to: 35).
	
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(6)).
	
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveOneUp_at_35_thenDown [
	<gtExample>
	<noTest>
	| anEditor |

	anEditor := self select_moveOneUp_at_35.
	
	anEditor selecter
		moveOneDown;
		select.
	
	self 
		assert: anEditor selection  isEmpty.
	
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(35)).
	
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveTwiceLeft_at_1 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 1.

	anEditor selecter moveOneToLeft select.

	anEditor editor moveCursorTo: 0.

	anEditor selecter
		moveOneToLeft;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 0 to: 1).
	self assert: anEditor editor selectedText asString equals: 'A'.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(0)).
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorSelecterExamples >> select_moveTwiceRight_at_End [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: anEditor text size - 1.
	anEditor selecter
		moveOneToRight;
		select.
	anEditor editor moveCursorTo: anEditor text size.

	anEditor selecter
		moveOneToRight;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: anEditor text size - 1 to: anEditor text size).
	self assert: anEditor editor selectedText asString equals: '.'.

	self
		assert: anEditor cursors
		equals: (BrTextEditorCursor atAll: {anEditor text size}).

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_nested_parentheses [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnTextWithDelimiters.
	anEditor selecter
		selectionUnitAt: 44;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 44 to: 80).
	self
		assert: anEditor editor selectedText asString
		equals: '(nesting should work, also) (really)'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(80)).

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_nested_parentheses_end [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnTextWithDelimiters.
	anEditor selecter
		selectionUnitAt: 80;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 44 to: 80).
	self
		assert: anEditor editor selectedText asString
		equals: '(nesting should work, also) (really)'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(80)).

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_parentheses [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnTextWithDelimiters.
	anEditor selecter
		selectionUnitAt: 40;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 26 to: 40).
	self assert: anEditor editor selectedText asString equals: 'really, he did'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(40)).

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_single_quotes [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnTextWithDelimiters.
	anEditor selecter
		selectionUnitAt: 84;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 84 to: 102).
	self assert: anEditor editor selectedText asString equals: 'single quotes also'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(102)).

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorSelecterExamples >> select_single_quotes_end [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnTextWithDelimiters.
	anEditor selecter
		selectionUnitAt: 102;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 84 to: 102).
	self assert: anEditor editor selectedText asString equals: 'single quotes also'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(102)).

	^ anEditor
]

{ #category : #'examples - word' }
BrTextEditorSelecterExamples >> select_word_at_0 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor selecter
		selectionUnitAt: 0;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 0 to: 1).
	self assert: anEditor editor selectedText asString equals: 'A'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(1)).

	^ anEditor
]

{ #category : #'examples - word' }
BrTextEditorSelecterExamples >> select_word_at_1 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor selecter
		selectionUnitAt: 1;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 1 to: 2).
	self assert: anEditor editor selectedText asString equals: ' '.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(2)).

	^ anEditor
]

{ #category : #'examples - word' }
BrTextEditorSelecterExamples >> select_word_at_1_on_empty_text [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnEmptyText.
	anEditor selecter
		selectionUnitAt: 1;
		select.

	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - word' }
BrTextEditorSelecterExamples >> select_word_at_2 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor selecter
		selectionUnitAt: 2;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 2 to: 8).
	self assert: anEditor editor selectedText asString equals: 'summer'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(8)).

	^ anEditor
]

{ #category : #'examples - word' }
BrTextEditorSelecterExamples >> select_word_at_2_and_10 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor selecter
		selectionUnitAt: 2;
		selectionUnitAt: 10;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new
				select: 2 to: 8;
				select: 9 to: 14).
	self assert: anEditor editor selectedText asString equals: 'summer river'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(8 14)).

	^ anEditor
]
