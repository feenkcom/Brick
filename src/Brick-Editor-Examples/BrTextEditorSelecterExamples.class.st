Class {
	#name : #BrTextEditorSelecterExamples,
	#superclass : #BrTextEditorOperatorExamples,
	#category : #'Brick-Editor-Examples-Operators'
}

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> drag_select_backward_over_opening_single_quote [
	"Double-click a word and drag backward to right before an opening quote:
	the selection must start exactly at the quote, not at the previous string"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self
			editorFor: self textForDragSelection
			afterDragSelectingFrom: 36
			to: 23.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 23 to: 38).
	self assert: anEditor editor selectedText asString equals: '''/etc/x_y'' code'.

	^ anEditor
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> drag_select_forward_over_closing_parenthesis [
	"Double-click a word and drag forward to right after a closing parenthesis:
	the selection must end exactly after the parenthesis"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self
			editorFor: 'a: (MxWriter foo: 1) b: 2'
			afterDragSelectingFrom: 7
			to: 20.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 4 to: 20).
	self assert: anEditor editor selectedText asString equals: 'MxWriter foo: 1)'.

	^ anEditor
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> drag_select_forward_over_closing_single_quote [
	"Double-click a word and drag forward to right after a closing quote:
	the selection must end exactly after the quote, not at the next string"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self
			editorFor: self textForDragSelection
			afterDragSelectingFrom: 14
			to: 33.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 11 to: 33).
	self
		assert: anEditor editor selectedText asString
		equals: 'MxWriter c: ''/etc/x_y'''.

	^ anEditor
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> drag_select_forward_over_opening_single_quote [
	"Double-click a word and drag forward to right after an opening quote:
	the selection must end exactly after the quote, not at the end of the string"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self
			editorFor: self textForDragSelection
			afterDragSelectingFrom: 14
			to: 24.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 11 to: 24).
	self assert: anEditor editor selectedText asString equals: 'MxWriter c: '''.

	^ anEditor
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> drag_select_forward_to_just_before_closing_single_quote [
	"Double-click a word inside a string and drag forward to right before the closing quote:
	the selection must not jump back to the start of the string"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self
			editorFor: 'x := ''line one two''.'
			afterDragSelectingFrom: 13
			to: 18.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 11 to: 18).
	self assert: anEditor editor selectedText asString equals: 'one two'.

	^ anEditor
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> editorFor: aText afterDragSelectingFrom: aStartCursorIndex to: anEndCursorIndex [
	"Using real mouse events: double-click at aStartCursorIndex and, keeping the
	button pressed, drag to anEndCursorIndex, then release the button"

	<return: #BrEditor>
	| anEditor aScripter aStartPosition aMiddlePosition anEndPosition |
	anEditor := self editorFor: aText.
	aScripter := BlScripter new
			element: anEditor;
			yourself.
	aScripter pulse.

	aStartPosition := self
			globalPositionOfCursorIndex: aStartCursorIndex
			in: anEditor.
	anEndPosition := self
			globalPositionOfCursorIndex: anEndCursorIndex
			in: anEditor.
	aMiddlePosition := (aStartPosition + anEndPosition) / 2.

	BlSpace simulateMouseDownOn: anEditor at: aStartPosition.
	aScripter pulse.
	BlSpace simulateMouseUpOn: anEditor at: aStartPosition.
	aScripter pulse.
	BlSpace simulateMouseDownOn: anEditor at: aStartPosition.
	aScripter pulse.
	BlSpace
		simulateMouseMoveOn: anEditor
		from: aStartPosition
		to: aMiddlePosition.
	aScripter pulse.
	BlSpace
		simulateMouseMoveOn: anEditor
		from: aMiddlePosition
		to: anEndPosition.
	aScripter pulse.
	BlSpace simulateMouseUpOn: anEditor at: anEndPosition.
	aScripter pulse.

	^ anEditor
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> globalPositionOfCursorIndex: aCursorIndex in: anEditor [
	"Answer a position in the space at which anEditor resolves to aCursorIndex.
	Meant for single-line texts: scan the middle of the line horizontally"

	| y xs |
	y := anEditor height / 2.
	xs := (0 to: (anEditor width * 4) asInteger)
			collect: [ :k | k / 4 ]
			thenSelect: [ :x | 
				(anEditor editor navigator
					findTextIndexAtScreenPosition: x @ y
					ifAbsent: [ nil ]) = aCursorIndex ].
	self
		assert: xs notEmpty
		description: [ 'No screen position for cursor index ' , aCursorIndex printString ].
	^ anEditor localPointToGlobal: ((xs first + xs last) / 2) @ y
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> quote_roles_in_smalltalk_code [
	"Quotes open or close a string or comment depending on the text before them.
	Apostrophes in comments and quotes of character literals are neither"

	<gtExample>
	<return: #BrEditor>
	| aText anEditor aSelecter theRoles |
	aText := 'foo "don''t" ^ ''it''''s'' , $'' asString , $" asString'.
	anEditor := self editorFor: aText.
	aSelecter := anEditor editor selecter.
	theRoles := (1 to: aText size)
			select: [ :anIndex | '''"' includes: (aText at: anIndex) ]
			thenCollect: [ :anIndex | anIndex -> (aSelecter quoteRoleAt: anIndex) ].	"comment: 5 and 11, apostrophe in the comment: 9, string with an escaped quote: 15 to 21,
	character literals: 26 and 40"
	self
		assert: theRoles asArray
		equals: {5 -> #open.
				9 -> #none.
				11 -> #close.
				15 -> #open.
				18 -> #close.
				19 -> #open.
				21 -> #close.
				26 -> #none.
				40 -> #none}.

	^ anEditor
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> select_after_apostrophe_in_comment [
	"An apostrophe inside a comment is not a string delimiter"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: self textWithApostropheInComment.
	anEditor selecter
		selectionUnitAt: 9;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 9 to: 10).
	self assert: anEditor editor selectedText asString equals: 't'.

	^ anEditor
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> select_after_apostrophe_in_prose [
	"Apostrophes between letters (it's, Bob's) are not string delimiters"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: self textWithApostrophesInProse.
	anEditor selecter
		selectionUnitAt: 3;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 3 to: 4).
	self assert: anEditor editor selectedText asString equals: 's'.

	^ anEditor
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> select_after_closing_single_quote [
	"Double-clicking right after a closing quote must not pair it with the
	opening quote of the next string"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: self textWithTwoSingleQuotedStrings.
	anEditor selecter
		selectionUnitAt: 11;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 11 to: 12).
	self assert: anEditor editor selectedText asString equals: ' '.

	^ anEditor
]

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

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> select_before_opening_single_quote [
	"Double-clicking right before an opening quote must not pair it with the
	closing quote of the previous string"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: self textWithTwoSingleQuotedStrings.
	anEditor selecter
		selectionUnitAt: 15;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 15 to: 16).
	self assert: anEditor editor selectedText asString equals: ''''.

	^ anEditor
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> select_before_opening_single_quote_after_apostrophe_in_comment [
	"An apostrophe inside a comment must not be paired with the opening quote of a string"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: self textWithApostropheInComment.
	anEditor selecter
		selectionUnitAt: 14;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 14 to: 15).
	self assert: anEditor editor selectedText asString equals: ''''.

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

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> select_double_quotes_in_prose_with_apostrophes [
	"Apostrophes before a double-quoted region must not hide it"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: self textWithApostrophesInProse.
	anEditor selecter
		selectionUnitAt: 12;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 12 to: 18).
	self assert: anEditor editor selectedText asString equals: 'quoted'.

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

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> select_single_quotes_after_stray_quote [
	"An unpaired quote earlier in the text (here a backslash escape) must not
	prevent selecting a later string"

	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: 'x = ''it\''s'' + ''abc'''.
	anEditor selecter
		selectionUnitAt: 15;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 15 to: 18).
	self assert: anEditor editor selectedText asString equals: 'abc'.

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

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> textForDragSelection [
	^ 'a: ''ok'' b: MxWriter c: ''/etc/x_y'' code: 1. d: ''cfg'''
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> textWithApostropheInComment [
	^ 'foo "don''t" ^ ''abc'''
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> textWithApostrophesInProse [
	^ 'it''s Bob''s "quoted" text'
]

{ #category : #'examples - delimiters' }
BrTextEditorSelecterExamples >> textWithTwoSingleQuotedStrings [
	^ 'a: ''not ok'' b: ''etc'' c: 1'
]
