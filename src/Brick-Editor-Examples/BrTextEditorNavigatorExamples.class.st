Class {
	#name : #BrTextEditorNavigatorExamples,
	#superclass : #BrTextEditorOperatorExamples,
	#category : #'Brick-Editor-Examples-Operators'
}

{ #category : #'examples - showroom' }
BrTextEditorNavigatorExamples >> assertEditor: anEditor cursorIsAt: position [
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: position}
]

{ #category : #'examples - move to' }
BrTextEditorNavigatorExamples >> assertEvents: eventRecord addCursorAt: pos [
	self
		assert: (eventRecord addedEvents collect: #cursor) asArray
		equals: {BrTextEditorSingleCursor new position: pos}
]

{ #category : #'examples - move down' }
BrTextEditorNavigatorExamples >> assertEvents: eventRecord moveCursorFrom: from to: to [
	self
		assert: eventRecord movedEvents first cursor
		equals: (BrTextEditorSingleCursor new position: to).
	self assert: eventRecord movedEvents first oldIndex equals: from.
	self assert: eventRecord movedEvents first newIndex equals: to
]

{ #category : #'examples - move to' }
BrTextEditorNavigatorExamples >> assertEvents: eventRecord removeCursorAt: pos [
	self
		assert: (eventRecord removedEvents collect: #cursor) asArray
		equals: {BrTextEditorSingleCursor new position: pos}
]

{ #category : #'private - utility' }
BrTextEditorNavigatorExamples >> connectEventRecordTo: anEditor [
	| eventRecord |
	eventRecord := BrTextEditorNavigatorExamplesEventRecord new.

	anEditor navigator
		whenAdded: [ :anEvent | eventRecord addedEvents add: anEvent ];
		whenMoved: [ :anEvent | eventRecord movedEvents add: anEvent ];
		whenRemoved: [ :anEvent | eventRecord removedEvents add: anEvent ].
	^ eventRecord
]

{ #category : #'examples - showroom' }
BrTextEditorNavigatorExamples >> cursor_addAt0_moveNextWord_in_something [
	<gtExample>
	| anEditor |
	anEditor := self editorOnSomeThing.
	anEditor navigator
		moveTo: 0;
		apply.
	self assertEditor: anEditor cursorIsAt: 0.

	anEditor navigator
		moveToEndNextWord;
		apply.
	self assertEditor: anEditor cursorIsAt: 4.
	^ anEditor
]

{ #category : #'examples - showroom' }
BrTextEditorNavigatorExamples >> cursor_addAt0_moveNextWord_twice_in_something [
	<gtExample>
	| anEditor |
	anEditor := self cursor_addAt0_moveNextWord_in_something.

	anEditor navigator
		moveToEndNextWord;
		apply.
	self assertEditor: anEditor cursorIsAt: 9.

	^ anEditor
]

{ #category : #'examples - showroom' }
BrTextEditorNavigatorExamples >> cursor_addAt9_movePreviousWord_in_something [
	<gtExample>
	| anEditor |
	anEditor := self editorOnSomeThing.
	anEditor navigator
		moveTo: 9;
		apply.
	self assertEditor: anEditor cursorIsAt: 9.

	anEditor navigator
		moveToStartPreviousWord;
		apply.
	self assertEditor: anEditor cursorIsAt: 4.
	^ anEditor
]

{ #category : #'examples - showroom' }
BrTextEditorNavigatorExamples >> cursor_addAt9_movePreviousWord_twice_in_something [
	<gtExample>
	| anEditor |
	anEditor := self cursor_addAt9_movePreviousWord_in_something.

	anEditor navigator
		moveToStartPreviousWord;
		apply.
	self assertEditor: anEditor cursorIsAt: 0.
	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorNavigatorExamples >> cursor_add_at_0_and_0_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		addAt: 0;
		addAt: 0;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self assertEvents: eventRecord addCursorAt: 0.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorNavigatorExamples >> cursor_add_at_0_and_1_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		addAt: 0;
		addAt: 1;
		apply;
		unsubscribe.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0.
				BrTextEditorSingleCursor new position: 1}.
	self assert: eventRecord addedEvents size equals: 2.
	self
		assert: (eventRecord addedEvents collect: #cursor) asArray
		equals: {BrTextEditorSingleCursor new position: 0.
				BrTextEditorSingleCursor new position: 1}.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorNavigatorExamples >> cursor_add_at_0_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		addAt: 0;
		apply;
		unsubscribe.
	anEditor forceLayout.
	self assertEditor: anEditor cursorIsAt: 0.
	self assertEvents: eventRecord addCursorAt: 0.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorNavigatorExamples >> cursor_add_at_1_and_0_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		addAt: 1;
		addAt: 0;
		apply;
		unsubscribe.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0.
				BrTextEditorSingleCursor new position: 1}.
	self assert: eventRecord addedEvents size equals: 2.
	self
		assert: (eventRecord addedEvents collect: #cursor) asArray
		equals: {BrTextEditorSingleCursor new position: 0.
				BrTextEditorSingleCursor new position: 1}.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - performance' }
BrTextEditorNavigatorExamples >> cursor_add_at_1_does_not_rebuild_editor [
	<gtExample>
	| anEditor thePreviousSegments theNewSegments thePreviousTextPieces theNewTextPieces |
	anEditor := self editorOnMultilineText.

	thePreviousSegments := anEditor children
			select: [ :eachChild | eachChild isKindOf: BrTextEditorSegmentElement ].
	self assert: thePreviousSegments size equals: 11.

	thePreviousTextPieces := thePreviousSegments
			flatCollect: [ :eachSegment | eachSegment children asArray ].
	self assert: thePreviousTextPieces size equals: 11.

	anEditor navigator
		addAt: 1;
		apply.

	anEditor forceLayout.
	self assertEditor: anEditor cursorIsAt: 1.

	theNewSegments := anEditor children
			select: [ :eachChild | eachChild isKindOf: BrTextEditorSegmentElement ].
	self assert: theNewSegments size equals: 11.

	theNewTextPieces := theNewSegments
			flatCollect: [ :eachSegment | eachSegment children select: [:each | each isKindOf: BlTextElement  ]].
	self assert: theNewTextPieces size equals: 11.

	self assert: thePreviousSegments equals: theNewSegments.
	self assert: thePreviousTextPieces equals: theNewTextPieces.

	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorNavigatorExamples >> cursor_add_at_1_in_cursors_at_0 [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		addAt: 1;
		apply;
		unsubscribe.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0.
				BrTextEditorSingleCursor new position: 1}.
	self assertEvents: eventRecord addCursorAt: 1.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorNavigatorExamples >> cursor_add_at_1_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		addAt: 1;
		apply;
		unsubscribe.
	anEditor forceLayout.
	self assertEditor: anEditor cursorIsAt: 1.
	self assertEvents: eventRecord addCursorAt: 1.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorNavigatorExamples >> cursor_add_at_2_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		addAt: 2;
		apply;
		unsubscribe.
	anEditor forceLayout.
	self assertEditor: anEditor cursorIsAt: 2.
	self assertEvents: eventRecord addCursorAt: 2.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorNavigatorExamples >> cursor_add_at_68_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		addAt: 68;
		apply;
		unsubscribe.
	anEditor forceLayout.
	self assertEditor: anEditor cursorIsAt: 68.
	self assertEvents: eventRecord addCursorAt: 68.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorNavigatorExamples >> cursor_add_at_8_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		addAt: 8;
		apply;
		unsubscribe.
	self
		assert: anEditor cursors allCursors
		equals: {BrTextEditorSingleCursor new position: 0.
				BrTextEditorSingleCursor new position: 8}.
	self assertEvents: eventRecord addCursorAt: 8.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - no duplication' }
BrTextEditorNavigatorExamples >> cursor_is_not_duplicated [
	<gtExample>
	| anEditor thePiecesWithCursor |
	
	anEditor := self editorFor: 'Hello World'.
	
	anEditor navigator
		moveTo: 6;
		apply.
	anEditor forceLayout.
	
	thePiecesWithCursor := self piecesWithCursorIn: anEditor.
	self assert: thePiecesWithCursor size equals: 1.
	self assert: thePiecesWithCursor first text asString equals: 'Hello World'.
	
	anEditor deleter
		oneBeforeCursor;
		delete.		
	anEditor forceLayout.
	
	thePiecesWithCursor := self piecesWithCursorIn: anEditor.
	self assert: thePiecesWithCursor size equals: 1.
	self assert: thePiecesWithCursor first text asString equals: 'HelloWorld'.
	
	anEditor inserter
		atCursor;
		string: 'O';
		insert.
	anEditor forceLayout.
	
	thePiecesWithCursor := self piecesWithCursorIn: anEditor.
	self assert: thePiecesWithCursor size equals: 1.
	self assert: thePiecesWithCursor first text asString equals: 'HelloOWorld'.
	
	^ anEditor
]

{ #category : #'examples - no duplication' }
BrTextEditorNavigatorExamples >> cursor_is_not_duplicated_bulk [
	<gtExample>
	| anEditor thePiecesWithCursor |
	
	anEditor := self editorFor: 'Hello World'.
	
	anEditor navigator
		moveTo: 6;
		apply.
	
	anEditor deleter
		oneBeforeCursor;
		delete.		
	anEditor forceLayout.
	
	thePiecesWithCursor := self piecesWithCursorIn: anEditor.
	self assert: thePiecesWithCursor size equals: 1.
	self assert: thePiecesWithCursor first text asString equals: 'HelloWorld'.
	
	anEditor inserter
		atCursor;
		string: 'O';
		insert.
	anEditor forceLayout.
	
	thePiecesWithCursor := self piecesWithCursorIn: anEditor.
	self assert: thePiecesWithCursor size equals: 1.
	self assert: thePiecesWithCursor first text asString equals: 'HelloOWorld'.
	
	^ anEditor
]

{ #category : #'examples - no duplication' }
BrTextEditorNavigatorExamples >> cursor_is_not_duplicated_bulk_full [
	<gtExample>
	| anEditor thePiecesWithCursor |
	
	anEditor := self editorFor: 'Hello World'.
	
	anEditor navigator
		moveTo: 6;
		apply.
	
	anEditor deleter
		oneBeforeCursor;
		delete.		

	anEditor inserter
		atCursor;
		string: 'O';
		insert.
	anEditor forceLayout.
	
	thePiecesWithCursor := self piecesWithCursorIn: anEditor.
	self assert: thePiecesWithCursor size equals: 1.
	self assert: thePiecesWithCursor first text asString equals: 'HelloOWorld'.
	
	^ anEditor
]

{ #category : #accessing }
BrTextEditorNavigatorExamples >> cursor_is_not_on_last_line [
	<gtExample>
	| anEditor aNavigator |
	anEditor := self editorOnMultilineText.
	aNavigator := anEditor editor navigator 
		moveTo: 186; 
		apply;
		unsubscribe.
	self assert: (aNavigator isCursorOnTheLastLine: anEditor editor cursors cursors anyOne) not.
	^ anEditor
]

{ #category : #accessing }
BrTextEditorNavigatorExamples >> cursor_is_on_last_line_when_at_the_end [
	<gtExample>
	| anEditor aNavigator |
	anEditor := self editorOnMultilineText.
	aNavigator := anEditor editor navigator 
		moveTo: 202; 
		apply;
		unsubscribe.
	self assert: (aNavigator isCursorOnTheLastLine: anEditor editor cursors cursors anyOne).
	^ anEditor
]

{ #category : #accessing }
BrTextEditorNavigatorExamples >> cursor_is_on_last_line_when_before_the_first_character [
	<gtExample>
	| anEditor aNavigator |
	anEditor := self editorOnMultilineText.
	aNavigator := anEditor editor navigator 
		moveTo: 187; 
		apply;
		unsubscribe.
	self assert: (aNavigator isCursorOnTheLastLine: anEditor editor cursors cursors anyOne).
	^ anEditor
]

{ #category : #'examples - crlf handling' }
BrTextEditorNavigatorExamples >> cursor_moveAcrossCRLF [
	<gtExample>
	| anEditor |
	anEditor := self editorOnCrlfText.
	anEditor navigator
		moveTo: 2;
		apply.
	anEditor navigator
		moveRight;
		apply.
	self assertEditor: anEditor cursorIsAt: 4.
	anEditor navigator
		moveLeft;
		apply.
	self assertEditor: anEditor cursorIsAt: 2.
	^ anEditor
]

{ #category : #'examples - crlf handling' }
BrTextEditorNavigatorExamples >> cursor_moveAcrossFoldedText [
	<gtExample>
	| anEditor |
	anEditor := self editorOnFoldedText.
	anEditor navigator
		moveTo: 0;
		apply.
	anEditor navigator
		moveRight;
		apply.
	self assertEditor: anEditor cursorIsAt: 1.
	anEditor navigator
		moveRight;
		apply.
	self assertEditor: anEditor cursorIsAt: 31.
	anEditor navigator
		moveLeft;
		apply.
	self assertEditor: anEditor cursorIsAt: 1.
	^ anEditor
]

{ #category : #'examples - move down' }
BrTextEditorNavigatorExamples >> cursor_moveDown_in_cursors_at_190 [
	<gtExample>
	| anEditor eventRecord theReachBoundaryEvents |
	anEditor := self cursor_moveTo_190_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	theReachBoundaryEvents := OrderedCollection new.
	anEditor navigator
		whenReachedBoundary: [ :anEvent | theReachBoundaryEvents add: anEvent ];
		moveDown;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 202.
	self
		assertEvents: eventRecord
		moveCursorFrom: 190
		to: 202.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	self assert: theReachBoundaryEvents size equals: 1.
	self
		assert: theReachBoundaryEvents first cursor
		equals: (BrTextEditorSingleCursor new position: 202).
	self assert: theReachBoundaryEvents first isBottom.
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToLineEnd_in_cursors_at_0 [
	<gtExample>
	<label: 'Cursor before the first character of the line should move to the end'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineEnd;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 28.
	self
		assertEvents: eventRecord
		moveCursorFrom: 0
		to: 28.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToLineEnd_in_cursors_at_1 [
	<gtExample>
	<label: 'Cursor after the first character of the line should move to the end'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	anEditor navigator
		moveTo: 1;
		apply.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineEnd;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 28.
	self
		assertEvents: eventRecord
		moveCursorFrom: 1
		to: 28.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToLineEnd_in_cursors_at_201 [
	<gtExample>
	<label: 'Cursor before the last character of the whole text should not move'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	anEditor navigator
		moveTo: 201;
		apply.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineEnd;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 202.
	self
		assertEvents: eventRecord
		moveCursorFrom: 201
		to: 202.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToLineEnd_in_cursors_at_202 [
	<gtExample>
	<label: 'Cursor after the last character of the whole text should not move'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	anEditor navigator
		moveTo: 202;
		apply.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineEnd;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 202.
	self assert: eventRecord addedEvents isEmpty.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToLineEnd_in_cursors_at_27 [
	<gtExample>
	<label: 'Cursor before the last character of the line should move to the end'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	anEditor navigator
		moveTo: 27;
		apply.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineEnd;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 28.
	self
		assertEvents: eventRecord
		moveCursorFrom: 27
		to: 28.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToLineEnd_in_cursors_at_28 [
	<gtExample>
	<label: 'Cursor after the last character of the line should not move'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	anEditor navigator
		moveTo: 28;
		apply.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineEnd;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 28.
	self assert: eventRecord addedEvents isEmpty.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToLineEnd_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineEnd;
		apply;
		unsubscribe.
	self assert: anEditor cursors isEmpty.
	self assert: eventRecord addedEvents isEmpty.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line start' }
BrTextEditorNavigatorExamples >> cursor_moveToLineStart_in_cursors_at_0 [
	<gtExample>
	<label: 'Cursor before the first character should not be moved'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineStart;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self assert: eventRecord addedEvents isEmpty.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line start' }
BrTextEditorNavigatorExamples >> cursor_moveToLineStart_in_cursors_at_1 [
	<gtExample>
	<label: 'Cursor after the first character moves before the start of the text'>
	| anEditor eventRecord |
	anEditor := self cursor_moveTo_1_in_cursors_at_0.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineStart;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self
		assertEvents: eventRecord
		moveCursorFrom: 1
		to: 0.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line start' }
BrTextEditorNavigatorExamples >> cursor_moveToLineStart_in_cursors_at_27 [
	<gtExample>
	<label: 'Cursor before the last character of the line should move to the start'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	anEditor navigator
		moveTo: 27;
		apply.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineStart;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self
		assertEvents: eventRecord
		moveCursorFrom: 27
		to: 0.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line start' }
BrTextEditorNavigatorExamples >> cursor_moveToLineStart_in_cursors_at_28 [
	<gtExample>
	<label: 'Cursor after the last character of the line should move to to the start'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	anEditor navigator
		moveTo: 28;
		apply.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineStart;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self
		assertEvents: eventRecord
		moveCursorFrom: 28
		to: 0.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line start' }
BrTextEditorNavigatorExamples >> cursor_moveToLineStart_in_cursors_at_29 [
	<gtExample>
	<label: 'Cursor before the first character of the line should not move'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	anEditor navigator
		moveTo: 29;
		apply.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineStart;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 29.
	self assert: eventRecord addedEvents isEmpty.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line start' }
BrTextEditorNavigatorExamples >> cursor_moveToLineStart_in_cursors_at_30 [
	<gtExample>
	<label: 'Cursor after the first character of the line should move to the start of that line'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	anEditor navigator
		moveTo: 30;
		apply.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineStart;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 29.
	self
		assertEvents: eventRecord
		moveCursorFrom: 30
		to: 29.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line start' }
BrTextEditorNavigatorExamples >> cursor_moveToLineStart_in_cursors_at_40 [
	<gtExample>
	<label: 'Cursor before the last character of the line should move to the start of that line'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	anEditor navigator
		moveTo: 40;
		apply.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineStart;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 29.
	self
		assertEvents: eventRecord
		moveCursorFrom: 40
		to: 29.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line start' }
BrTextEditorNavigatorExamples >> cursor_moveToLineStart_in_cursors_at_41 [
	<gtExample>
	<label: 'Cursor after the last character of the line should move to the start of that line'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	anEditor navigator
		moveTo: 41;
		apply.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineStart;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 29.
	self
		assertEvents: eventRecord
		moveCursorFrom: 41
		to: 29.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line start' }
BrTextEditorNavigatorExamples >> cursor_moveToLineStart_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToLineStart;
		apply;
		unsubscribe.
	self assert: anEditor cursors isEmpty.
	self assert: eventRecord addedEvents isEmpty.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToNextWord_in_cursors_at_0 [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToEndNextWord;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 2.
	self
		assertEvents: eventRecord
		moveCursorFrom: 0
		to: 2.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToNextWord_in_cursors_at_1 [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_1_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToEndNextWord;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 2.
	self
		assertEvents: eventRecord
		moveCursorFrom: 1
		to: 2.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToPreviousWord_in_cursors_at_1 [
	<gtExample>
	<label: 'Cursor before the first character of the line should move to the end'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_1_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToStartPreviousWord;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self
		assertEvents: eventRecord
		moveCursorFrom: 1
		to: 0.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToPreviousWord_in_cursors_at_2 [
	<gtExample>
	<label: 'Cursor before the first character of the line should move to the end'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_2_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToStartPreviousWord;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self
		assertEvents: eventRecord
		moveCursorFrom: 2
		to: 0.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to line end' }
BrTextEditorNavigatorExamples >> cursor_moveToPreviousWord_in_cursors_at_8 [
	<gtExample>
	<label: 'Cursor before the first character of the line should move to the end'>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_8_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToStartPreviousWord;
		apply;
		unsubscribe.
	self
		assert: (anEditor cursors allCursors
				includes: (BrTextEditorSingleCursor new position: 0)).
	self
		assert: (anEditor cursors allCursors
				includes: (BrTextEditorSingleCursor new position: 2)).
	self
		assertEvents: eventRecord
		moveCursorFrom: 8
		to: 2.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to screen' }
BrTextEditorNavigatorExamples >> cursor_moveToScreen_1_left_half_in_empty [
	<gtExample>
	<label: 'Click on the left half of the first character'>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToScreenPosition: (self paragraphMargin left + (self glyphWidth / 2.0) - 1)
				@ (self paragraphMargin top + (self glyphHeight / 2.0));
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self assert: eventRecord addedEvents size equals: 1.
	self
		assert: (eventRecord addedEvents collect: #cursor) asArray
		equals: (BrTextEditorCursor atAll: #(0)) allCursors.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to screen' }
BrTextEditorNavigatorExamples >> cursor_moveToScreen_1_left_in_empty [
	<gtExample>
	<label: 'Click on a whitespace to the left from the first character'>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToScreenPosition: (self paragraphMargin left / 2.0)
				@ (self paragraphMargin top + (self glyphHeight / 2.0));
		apply;
		unsubscribe.
	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(0)).
	self assert: eventRecord addedEvents size equals: 1.
	self
		assert: (eventRecord addedEvents collect: #cursor) asArray
		equals: (BrTextEditorCursor atAll: #(0)) allCursors.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to screen' }
BrTextEditorNavigatorExamples >> cursor_moveToScreen_1_middle_in_empty [
	<gtExample>
	<label: 'Click right in the middle of the first character'>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToScreenPosition: (self paragraphMargin left + (self glyphWidth / 2.0))
				@ (self paragraphMargin top + (self glyphHeight / 2.0));
		apply;
		unsubscribe.
	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(1)).
	self assert: eventRecord addedEvents size equals: 1.
	self
		assert: (eventRecord addedEvents collect: #cursor) asArray
		equals: (BrTextEditorCursor atAll: #(1)) allCursors.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to screen' }
BrTextEditorNavigatorExamples >> cursor_moveToScreen_1_right_half_in_empty [
	<gtExample>
	<label: 'Click on the right half of the first character'>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToScreenPosition: (self paragraphMargin left + (self glyphWidth / 2.0) + 1)
				@ (self paragraphMargin top + (self glyphHeight / 2.0));
		apply;
		unsubscribe.
	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(1)).
	self assert: eventRecord addedEvents size equals: 1.
	self
		assert: (eventRecord addedEvents collect: #cursor) asArray
		equals: (BrTextEditorCursor atAll: #(1)) allCursors.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to screen' }
BrTextEditorNavigatorExamples >> cursor_moveToScreen_41_right_in_empty [
	<gtExample>
	<noTest>
	<label: 'Click on the right half of the 41th character'>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveToScreenPosition: 96 @ 64;
		apply;
		unsubscribe.
	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(41)).
	self assert: eventRecord addedEvents size equals: 1.
	self
		assert: (eventRecord addedEvents collect: #cursor) asArray
		equals: (BrTextEditorCursor atAll: #(41)) allCursors.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to' }
BrTextEditorNavigatorExamples >> cursor_moveTo_0_in_cursors_at_0_and_1 [
	<gtExample>
	| anEditor eventRecord |
	"even though it is a move event, what actually happens is we need to delete one cursor at (1) because the other one is already at the target position"
	anEditor := self cursor_add_at_0_and_1_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveTo: 0;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#addedEvents}).
	self assertEvents: eventRecord removeCursorAt: 1.
	^ anEditor
]

{ #category : #'examples - move to' }
BrTextEditorNavigatorExamples >> cursor_moveTo_0_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveTo: 0;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self assertEvents: eventRecord addCursorAt: 0.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to' }
BrTextEditorNavigatorExamples >> cursor_moveTo_190_in_empty [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self editorOnMultilineText.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveTo: 190;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 190.
	self assertEvents: eventRecord addCursorAt: 190.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to' }
BrTextEditorNavigatorExamples >> cursor_moveTo_1_in_cursors_at_0 [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveTo: 1;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 1.
	self
		assertEvents: eventRecord
		moveCursorFrom: 0
		to: 1.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move to' }
BrTextEditorNavigatorExamples >> cursor_moveTo_2_in_cursors_at_0_and_1 [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_and_1_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveTo: 2;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 2.
	self assert: eventRecord addedEvents isEmpty.
	self
		assertEvents: eventRecord
		moveCursorFrom: 0
		to: 2.
	self assertEvents: eventRecord removeCursorAt: 1.
	^ anEditor
]

{ #category : #'examples - move to' }
BrTextEditorNavigatorExamples >> cursor_moveTo_67_in_cursors_at_68 [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_68_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		moveTo: 67;
		apply;
		unsubscribe.
	anEditor forceLayout.
	self assertEditor: anEditor cursorIsAt: 67.
	self
		assertEvents: eventRecord
		moveCursorFrom: 68
		to: 67.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	^ anEditor
]

{ #category : #'examples - move up' }
BrTextEditorNavigatorExamples >> cursor_moveUp_in_cursors_at_1 [
	<gtExample>
	| anEditor theReachBoundaryEvents eventRecord |
	anEditor := self cursor_add_at_1_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	theReachBoundaryEvents := OrderedCollection new.
	anEditor navigator
		whenReachedBoundary: [ :anEvent | theReachBoundaryEvents add: anEvent ];
		moveUp;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self
		assertEvents: eventRecord
		moveCursorFrom: 1
		to: 0.
	self
		assert: (eventRecord
				noEventsOfTypes: {#addedEvents.
						#removedEvents}).
	self assert: theReachBoundaryEvents size equals: 1.
	self
		assert: theReachBoundaryEvents first cursor
		equals: (BrTextEditorSingleCursor new position: 0).
	self assert: theReachBoundaryEvents first isTop.
	^ anEditor
]

{ #category : #'examples - performance' }
BrTextEditorNavigatorExamples >> cursor_move_from_1_to_2_does_not_rebuild_editor [
	<gtExample>
	| anEditor thePreviousSegments theNewSegments thePreviousTextPieces theNewTextPieces |
	anEditor := self cursor_add_at_1_does_not_rebuild_editor.

	thePreviousSegments := anEditor children
			select: [ :eachChild | eachChild isKindOf: BrTextEditorSegmentElement ].
	self assert: thePreviousSegments size equals: 11.

	thePreviousTextPieces := thePreviousSegments
			flatCollect: [ :eachSegment | eachSegment children select: [ :each | each isKindOf: BlTextElement ] ].
	self assert: thePreviousTextPieces size equals: 11.

	anEditor navigator
		moveTo: 2;
		apply.

	anEditor forceLayout.
	self assertEditor: anEditor cursorIsAt: 2.

	theNewSegments := anEditor children
			select: [ :eachChild | eachChild isKindOf: BrTextEditorSegmentElement ].

	theNewTextPieces := theNewSegments
			flatCollect: [ :eachSegment | eachSegment children select: [ :each | each isKindOf: BlTextElement ] ].

	self assert: thePreviousSegments equals: theNewSegments.
	self assert: thePreviousTextPieces equals: theNewTextPieces.

	^ anEditor
]

{ #category : #'examples - remove' }
BrTextEditorNavigatorExamples >> cursor_removeAll_in_cursors_at_0_and_1 [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_and_1_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		removeAll;
		apply;
		unsubscribe.
	self assert: anEditor cursors isEmpty.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#addedEvents}).
	self assert: eventRecord removedEvents size equals: 2.
	self
		assert: (eventRecord removedEvents collect: #cursor) asArray
		equals: {BrTextEditorSingleCursor new position: 0.
				BrTextEditorSingleCursor new position: 1}.
	^ anEditor
]

{ #category : #'examples - remove' }
BrTextEditorNavigatorExamples >> cursor_remove_at_0_in_cursors_at_0 [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		removeAt: 0;
		apply;
		unsubscribe.
	self assert: anEditor cursors isEmpty.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#addedEvents}).
	self assertEvents: eventRecord removeCursorAt: 0.
	^ anEditor
]

{ #category : #'examples - remove' }
BrTextEditorNavigatorExamples >> cursor_remove_at_1_and_0_in_cursors_at_0_and_1 [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_and_1_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		removeAt: 0;
		removeAt: 1;
		apply;
		unsubscribe.
	self assert: anEditor cursors isEmpty.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#addedEvents}).
	self assert: eventRecord removedEvents size equals: 2.
	self
		assert: (eventRecord removedEvents collect: #cursor) asArray
		equals: {BrTextEditorSingleCursor new position: 0.
				BrTextEditorSingleCursor new position: 1}.
	^ anEditor
]

{ #category : #'examples - remove' }
BrTextEditorNavigatorExamples >> cursor_remove_at_1_in_cursors_at_0_and_1 [
	<gtExample>
	| anEditor eventRecord |
	anEditor := self cursor_add_at_0_and_1_in_empty.
	eventRecord := self connectEventRecordTo: anEditor.
	anEditor navigator
		removeAt: 1;
		apply;
		unsubscribe.
	self assertEditor: anEditor cursorIsAt: 0.
	self
		assert: (eventRecord
				noEventsOfTypes: {#movedEvents.
						#addedEvents}).
	self assertEvents: eventRecord removeCursorAt: 1.
	^ anEditor
]
