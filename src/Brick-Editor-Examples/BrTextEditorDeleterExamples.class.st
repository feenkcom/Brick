Class {
	#name : #BrTextEditorDeleterExamples,
	#superclass : #BrTextEditorOperatorExamples,
	#category : #'Brick-Editor-Examples-Operators'
}

{ #category : #'examples - deletion special' }
BrTextEditorDeleterExamples >> backwardsDeleteCrlf [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnCrlfText.
	anEditor navigator
		moveTo: 4;
		apply.
	anEditor deleter
		oneBeforeCursor;
		delete.
	self assert: anEditor text asString equals: '1234'.
	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_0_cursorAt_0_selection_0_to_0 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 0.
	anEditor editor select: 0 to: 0.

	anEditor deleter
		from: 0 to: 0;
		delete.

	self assert: anEditor text asString equals: self multilineText asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_0_cursorAt_0_selection_0_to_10 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 0.
	anEditor editor select: 0 to: 10.

	anEditor deleter
		from: 0 to: 0;
		delete.

	self assert: anEditor text asString equals: self multilineText asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 0 to: 10).

	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_1_cursorAt_0_selection_0_to_10 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 0.
	anEditor editor select: 0 to: 10.

	anEditor deleter
		from: 0 to: 1;
		delete.

	self
		assert: anEditor text asString
		equals: (self multilineText from: 2 to: self multilineText size) asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 0 to: 9).

	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_28_cursorAt_0_selection_0_to_10 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 0.
	anEditor editor select: 0 to: 10.

	anEditor deleter
		from: 0 to: 28;
		delete.

	self
		assert: anEditor text asString
		equals: (self multilineText from: 29 to: self multilineText size) asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_28_cursorAt_0_selection_0_to_28 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 0.
	anEditor editor select: 0 to: 28.

	anEditor deleter
		from: 0 to: 28;
		delete.

	self
		assert: anEditor text asString
		equals: (self multilineText from: 29 to: self multilineText size) asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_28_cursorAt_0_selection_0_to_29 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 0.
	anEditor editor select: 0 to: 29.

	anEditor deleter
		from: 0 to: 28;
		delete.

	self
		assert: anEditor text asString
		equals: (self multilineText from: 29 to: self multilineText size) asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 0 to: 1).

	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_28_cursorAt_0_selection_0_to_38 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 0.
	anEditor editor select: 0 to: 38.

	anEditor deleter
		from: 0 to: 28;
		delete.

	self
		assert: anEditor text asString
		equals: (self multilineText from: 29 to: self multilineText size) asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 0 to: 10).

	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_28_cursorAt_0_selection_0_to_38_and_48_to_50 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 0.
	anEditor editor select: 0 to: 38.
	anEditor editor select: 48 to: 50.

	anEditor deleter
		from: 0 to: 28;
		delete.

	self
		assert: anEditor text asString
		equals: (self multilineText from: 29 to: self multilineText size) asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self
		assert: anEditor selection
		equals: (BlCompositeSelection new
				select: 0 to: 10;
				select: 20 to: 22).

	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_28_cursorAt_10_selection_0_to_10 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 10.
	anEditor editor select: 0 to: 10.

	anEditor deleter
		from: 0 to: 28;
		delete.

	self
		assert: anEditor text asString
		equals: (self multilineText from: 29 to: self multilineText size) asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_28_cursorAt_28_selection_0_to_10 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 28.
	anEditor editor select: 0 to: 10.

	anEditor deleter
		from: 0 to: 28;
		delete.

	self
		assert: anEditor text asString
		equals: (self multilineText from: 29 to: self multilineText size) asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0}.
	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_28_cursorAt_29_selection_0_to_10 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 29.
	anEditor editor select: 0 to: 10.

	anEditor deleter
		from: 0 to: 28;
		delete.

	self
		assert: anEditor text asString
		equals: (self multilineText from: 29 to: self multilineText size) asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 1}.
	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - deletion' }
BrTextEditorDeleterExamples >> delete_0_to_28_cursorAt_38_selection_0_to_10 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 38.
	anEditor editor select: 0 to: 10.

	anEditor deleter
		from: 0 to: 28;
		delete.

	self
		assert: anEditor text asString
		equals: (self multilineText from: 29 to: self multilineText size) asString.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 10}.
	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - deletion special' }
BrTextEditorDeleterExamples >> delete_0_to_5_from_HelloCr [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: 'hello' , String cr.

	anEditor deleter
		from: 0 to: 5;
		delete.

	self assert: anEditor text asString equals: String cr.

	^ anEditor
]

{ #category : #'examples - deletion special' }
BrTextEditorDeleterExamples >> forwardDeleteCrlf [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorOnCrlfText.
	anEditor navigator
		moveTo: 2;
		apply.
	anEditor deleter
		oneAfterCursor;
		delete.
	self assert: anEditor text asString equals: '1234'.
	^ anEditor
]

{ #category : #'examples - deletion special' }
BrTextEditorDeleterExamples >> surroundings_delete_at_0_from_parenthesis_open_close [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: '()'.
	anEditor navigator
		addAt: 0;
		apply.

	anEditor deleter
		surroundings: {'(' -> ')'};
		delete.

	self assert: anEditor text asString equals: '()'.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(0)).

	^ anEditor
]

{ #category : #'examples - deletion special' }
BrTextEditorDeleterExamples >> surroundings_delete_at_1_from_parenthesis_open_close [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: '()'.
	anEditor navigator
		addAt: 1;
		apply.

	anEditor deleter
		surroundings: {'(' -> ')'};
		delete.

	self assert: anEditor text asString equals: ''.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(0)).

	^ anEditor
]

{ #category : #'examples - deletion special' }
BrTextEditorDeleterExamples >> surroundings_delete_at_1_from_parenthesis_open_close_close [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: '())'.
	anEditor navigator
		addAt: 1;
		apply.

	anEditor deleter
		surroundings: {'(' -> ')'};
		delete.

	self assert: anEditor text asString equals: ')'.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(0)).

	^ anEditor
]

{ #category : #'examples - deletion special' }
BrTextEditorDeleterExamples >> surroundings_delete_at_2_from_parenthesis_open_close [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: '()'.
	anEditor navigator
		addAt: 2;
		apply.

	anEditor deleter
		surroundings: {'(' -> ')'};
		delete.

	self assert: anEditor text asString equals: '()'.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(2)).

	^ anEditor
]

{ #category : #'examples - deletion special' }
BrTextEditorDeleterExamples >> surroundings_delete_at_2_from_parenthesis_open_close_selected_1_to_2 [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: '()'.

	anEditor selecter
		from: 1 to: 2;
		select.

	anEditor navigator
		addAt: 2;
		apply.

	anEditor deleter
		surroundings: {'(' -> ')'};
		delete.

	self assert: anEditor text asString equals: '()'.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(2)).

	^ anEditor
]

{ #category : #'examples - deletion special' }
BrTextEditorDeleterExamples >> surroundings_delete_at_2_from_parenthesis_open_open_close [
	<gtExample>
	<return: #BrEditor>
	| anEditor |
	anEditor := self editorFor: '(()'.
	anEditor navigator
		addAt: 2;
		apply.

	anEditor deleter
		surroundings: {'(' -> ')'};
		delete.

	self assert: anEditor text asString equals: '('.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(1)).

	^ anEditor
]
