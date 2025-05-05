Class {
	#name : #BrEditorShortcutExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Shortcuts'
}

{ #category : #accessing }
BrEditorShortcutExamples >> deleteOneLetterAfterCursorWithSelection [
	<gtExample>
	<return: #BrEditor>
	| anEditorElement anEditor |
	anEditorElement := BrTextEditorOperatorExamples new editorOnMultilineText.
	anEditor := anEditorElement editor.

	anEditor selecter
		from: 3 to: 7;
		select.
	anEditor navigator
		moveTo: 3;
		apply.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 3 to: 7).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {3}).

	BrEditorShortcut deleteOneLetterAfterCursor
		performOnEditor: anEditor
		element: anEditorElement
		dueTo: nil.

	self assert: (anEditor text from: 3 to: 4) asString equals: 'sr'.
	self assert: anEditor selection equals: BlCompositeSelection new.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {3}).

	^ anEditorElement
]

{ #category : #accessing }
BrEditorShortcutExamples >> deleteOneLetterAfterCursorWithSelectionBeforeCursor [
	<gtExample>
	<return: #BrEditor>
	| anEditorElement anEditor |
	anEditorElement := BrTextEditorOperatorExamples new editorOnMultilineText.
	anEditor := anEditorElement editor.

	anEditor selecter
		from: 3 to: 7;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 3 to: 7).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {7}).

	BrEditorShortcut deleteOneLetterAfterCursor
		performOnEditor: anEditor
		element: anEditorElement
		dueTo: nil.

	self assert: (anEditor text from: 3 to: 4) asString equals: 'sr'.
	self assert: anEditor selection equals: BlCompositeSelection new.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {3}).

	^ anEditorElement
]

{ #category : #accessing }
BrEditorShortcutExamples >> deleteOneLetterBeforeCursorWithSelection [
	<gtExample>
	<return: #BrEditor>
	| anEditorElement anEditor |
	anEditorElement := BrTextEditorOperatorExamples new editorOnMultilineText.
	anEditor := anEditorElement editor.

	anEditor selecter
		from: 3 to: 7;
		select.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 3 to: 7).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {7}).

	BrEditorShortcut deleteOneLetterBeforeCursor
		performOnEditor: anEditor
		element: anEditorElement
		dueTo: nil.

	self assert: (anEditor text from: 3 to: 4) asString equals: 'sr'.
	self assert: anEditor selection equals: BlCompositeSelection new.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {3}).

	^ anEditorElement
]

{ #category : #accessing }
BrEditorShortcutExamples >> deleteOneLetterBeforeCursorWithSelectionAfterCursor [
	<gtExample>
	<return: #BrEditor>
	| anEditorElement anEditor |
	anEditorElement := BrTextEditorOperatorExamples new editorOnMultilineText.
	anEditor := anEditorElement editor.

	anEditor selecter
		from: 3 to: 7;
		select.
	anEditor navigator
		moveTo: 3;
		apply.

	self
		assert: anEditor selection
		equals: (BlCompositeSelection new select: 3 to: 7).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {3}).

	BrEditorShortcut deleteOneLetterBeforeCursor
		performOnEditor: anEditor
		element: anEditorElement
		dueTo: nil.

	self assert: (anEditor text from: 3 to: 4) asString equals: 'sr'.
	self assert: anEditor selection equals: BlCompositeSelection new.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {3}).

	^ anEditorElement
]

{ #category : #accessing }
BrEditorShortcutExamples >> deleteWordAfterCursor [
	<gtExample>
	<return: #BrEditor>
	| anEditorElement anEditor |
	anEditorElement := BrTextEditorOperatorExamples new editorOnMultilineText.
	anEditor := anEditorElement editor.

	anEditor navigator
		moveTo: 51;
		apply.

	BrEditorShortcut deleteNextWord
		performOnEditor: anEditor
		element: anEditorElement
		dueTo: nil.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {51}).
	self
		assert: (anEditor text from: 43 to: 64) asString
		equals: 'with sand in my hands!'.

	BrEditorShortcut deleteNextWord
		performOnEditor: anEditor
		element: anEditorElement
		dueTo: nil.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {51}).
	self
		assert: (anEditor text from: 43 to: 63) asString
		equals: 'with sandin my hands!'.

	BrEditorShortcut deleteNextWord
		performOnEditor: anEditor
		element: anEditorElement
		dueTo: nil.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {51}).
	self
		assert: (anEditor text from: 43 to: 61) asString
		equals: 'with sand my hands!'.

	^ anEditorElement
]

{ #category : #accessing }
BrEditorShortcutExamples >> deleteWordBeforeCursor [
	<gtExample>
	<return: #BrEditor>
	| anEditorElement anEditor |
	anEditorElement := BrTextEditorOperatorExamples new editorOnMultilineText.
	anEditor := anEditorElement editor.

	anEditor navigator
		moveTo: 51;
		apply.

	BrEditorShortcut deletePreviousWord
		performOnEditor: anEditor
		element: anEditorElement
		dueTo: nil.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {47}).
	self
		assert: (anEditor text from: 43 to: 63) asString
		equals: 'with als in my hands!'.

	BrEditorShortcut deletePreviousWord
		performOnEditor: anEditor
		element: anEditorElement
		dueTo: nil.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {46}).
	self
		assert: (anEditor text from: 43 to: 62) asString
		equals: 'withals in my hands!'.

	BrEditorShortcut deletePreviousWord
		performOnEditor: anEditor
		element: anEditorElement
		dueTo: nil.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: {42}).
	self
		assert: (anEditor text from: 43 to: 58) asString
		equals: 'als in my hands!'.

	^ anEditorElement
]
