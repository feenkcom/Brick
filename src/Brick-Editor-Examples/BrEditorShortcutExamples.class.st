Class {
	#name : #BrEditorShortcutExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-Shortcuts'
}

{ #category : #accessing }
BrEditorShortcutExamples >> deleteOneLetterAfterCursorWithSelection [
	<gtExample>
	| anEditorElement anEditor |
	
	anEditorElement := BrTextEditorOperatorExamples new editorOnMultilineText.
	anEditor := anEditorElement editor.
	
	anEditor selecter
		from: 3 to: 7;
		select.
	anEditor navigator
		moveTo: 3;
		apply.
		
	self assert: anEditor selection equals: (BlCompositeSelection new select: 3 to: 7).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { 3 }).
	
	BrEditorDeleteOneLetterAfterCursorShortcut new
		performOnEditor: anEditor element: anEditorElement dueTo: nil.
	
	self assert: (anEditor text from: 3 to: 4) asString equals: 'sr'.
	self assert: anEditor selection equals: (BlCompositeSelection new).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { 3 }).
	
	^ anEditorElement
]

{ #category : #accessing }
BrEditorShortcutExamples >> deleteOneLetterAfterCursorWithSelectionBeforeCursor [
	<gtExample>
	| anEditorElement anEditor |
	
	anEditorElement := BrTextEditorOperatorExamples new editorOnMultilineText.
	anEditor := anEditorElement editor.
	
	anEditor selecter
		from: 3 to: 7;
		select.
		
	self assert: anEditor selection equals: (BlCompositeSelection new select: 3 to: 7).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { 7 }).
	
	BrEditorDeleteOneLetterAfterCursorShortcut new
		performOnEditor: anEditor element: anEditorElement dueTo: nil.
	
	self assert: (anEditor text from: 3 to: 4) asString equals: 'sr'.
	self assert: anEditor selection equals: (BlCompositeSelection new).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { 3 }).
	
	^ anEditorElement
]

{ #category : #accessing }
BrEditorShortcutExamples >> deleteOneLetterBeforeCursorWithSelection [
	<gtExample>
	| anEditorElement anEditor |
	
	anEditorElement := BrTextEditorOperatorExamples new editorOnMultilineText.
	anEditor := anEditorElement editor.
	
	anEditor selecter
		from: 3 to: 7;
		select.
		
	self assert: anEditor selection equals: (BlCompositeSelection new select: 3 to: 7).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { 7 }).
	
	BrEditorDeleteOneLetterBeforeCursorShortcut new
		performOnEditor: anEditor element: anEditorElement dueTo: nil.
	
	self assert: (anEditor text from: 3 to: 4) asString equals: 'sr'.
	self assert: anEditor selection equals: (BlCompositeSelection new).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { 3 }).
	
	^ anEditorElement
]

{ #category : #accessing }
BrEditorShortcutExamples >> deleteOneLetterBeforeCursorWithSelectionAfterCursor [
	<gtExample>
	| anEditorElement anEditor |
	
	anEditorElement := BrTextEditorOperatorExamples new editorOnMultilineText.
	anEditor := anEditorElement editor.
	
	anEditor selecter
		from: 3 to: 7;
		select.
	anEditor navigator
		moveTo: 3;
		apply.
		
	self assert: anEditor selection equals: (BlCompositeSelection new select: 3 to: 7).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { 3 }).
	
	BrEditorDeleteOneLetterBeforeCursorShortcut new
		performOnEditor: anEditor element: anEditorElement dueTo: nil.
	
	self assert: (anEditor text from: 3 to: 4) asString equals: 'sr'.
	self assert: anEditor selection equals: (BlCompositeSelection new).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { 3 }).
	
	^ anEditorElement
]
