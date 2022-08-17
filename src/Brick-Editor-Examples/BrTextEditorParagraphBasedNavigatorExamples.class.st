Class {
	#name : #BrTextEditorParagraphBasedNavigatorExamples,
	#superclass : #BrTextEditorNavigatorExamples,
	#category : #'Brick-Editor-Examples-Operators'
}

{ #category : #'examples - performance' }
BrTextEditorParagraphBasedNavigatorExamples >> cursor_add_at_1_does_not_rebuild_editor [
	<gtExample>
	| anEditor thePreviousSegments theNewSegments thePreviousTextPieces theNewTextPieces |
	
	anEditor := self editorOnMultilineText.

	thePreviousSegments := anEditor children
		select: [ :eachChild | eachChild isKindOf: BrTextEditorSegmentElement ].	
	self assert: thePreviousSegments size equals: 11.
	
	thePreviousTextPieces := thePreviousSegments flatCollect: [ :eachSegment | eachSegment children asArray ].
	self assert: thePreviousTextPieces size equals: 11.

	anEditor navigator
		addAt: 1;
		apply.

	anEditor forceLayout.

	self assert: anEditor cursors allCursors equals: { BrTextEditorSingleCursor new position: 1 }.
	
	theNewSegments := anEditor children
		select: [ :eachChild | eachChild isKindOf: BrTextEditorSegmentElement ].	
	self assert: theNewSegments size equals: 11.
	
	theNewTextPieces := theNewSegments flatCollect: [ :eachSegment | eachSegment children asArray ].
	self assert: theNewTextPieces size equals: 12.
	
	self assert: thePreviousSegments equals: theNewSegments.
	
	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorParagraphBasedNavigatorExamples >> cursor_add_at_1_in_empty [
	<gtExample>
	| anEditor theAddedEvents theMovedEvents theRemovedEvents |
	
	anEditor := self editorOnMultilineText.

	theAddedEvents := OrderedCollection new.
	theMovedEvents := OrderedCollection new.
	theRemovedEvents := OrderedCollection new.

	anEditor navigator
		whenAdded: [ :anEvent | theAddedEvents add: anEvent ];
		whenMoved: [ :anEvent | theMovedEvents add: anEvent ];
		whenRemoved: [ :anEvent | theRemovedEvents add: anEvent ];
		addAt: 1;
		apply;
		unsubscribe.

	anEditor forceLayout.

	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors allCursors equals: { BrTextEditorSingleCursor new position: 1 }.
	
	self assert: theAddedEvents size equals: 1.
	self assert: (theAddedEvents collect: #cursor) asArray equals: {
		BrTextEditorSingleCursor new position: 1.
	}.
	self assert: theMovedEvents isEmpty.
	self assert: theRemovedEvents isEmpty.
	
	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorParagraphBasedNavigatorExamples >> cursor_add_at_2_in_empty [
	<gtExample>
	| anEditor theAddedEvents theMovedEvents theRemovedEvents |
	
	anEditor := self editorOnMultilineText.

	theAddedEvents := OrderedCollection new.
	theMovedEvents := OrderedCollection new.
	theRemovedEvents := OrderedCollection new.

	anEditor navigator
		whenAdded: [ :anEvent | theAddedEvents add: anEvent ];
		whenMoved: [ :anEvent | theMovedEvents add: anEvent ];
		whenRemoved: [ :anEvent | theRemovedEvents add: anEvent ];
		addAt: 2;
		apply;
		unsubscribe.

	anEditor forceLayout.

	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors allCursors equals: { BrTextEditorSingleCursor new position: 2 }.
	
	self assert: theAddedEvents size equals: 1.
	self assert: (theAddedEvents collect: #cursor) asArray equals: {
		BrTextEditorSingleCursor new position: 2.
	}.
	self assert: theMovedEvents isEmpty.
	self assert: theRemovedEvents isEmpty.
	
	^ anEditor
]

{ #category : #'examples - add' }
BrTextEditorParagraphBasedNavigatorExamples >> cursor_add_at_68_in_empty [
	<gtExample>
	| anEditor theAddedEvents theMovedEvents theRemovedEvents |
	
	anEditor := self editorOnMultilineText.
	
	theAddedEvents := OrderedCollection new.
	theMovedEvents := OrderedCollection new.
	theRemovedEvents := OrderedCollection new.


	anEditor navigator
		whenAdded: [ :anEvent | theAddedEvents add: anEvent ];
		whenMoved: [ :anEvent | theMovedEvents add: anEvent ];
		whenRemoved: [ :anEvent | theRemovedEvents add: anEvent ];
		addAt: 68;
		apply;
		unsubscribe.
		
	anEditor forceLayout.

	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors allCursors equals: { BrTextEditorSingleCursor new position: 68 }.
	
	self assert: theAddedEvents size equals: 1.
	self assert: (theAddedEvents collect: #cursor) asArray equals: {
		BrTextEditorSingleCursor new position: 68.
	}.
	self assert: theMovedEvents isEmpty.
	self assert: theRemovedEvents isEmpty.
	
	^ anEditor
]

{ #category : #'examples - no duplication' }
BrTextEditorParagraphBasedNavigatorExamples >> cursor_is_not_duplicated [
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

{ #category : #'examples - move to screen' }
BrTextEditorParagraphBasedNavigatorExamples >> cursor_moveToScreen_1_left_half_in_empty [
	<gtExample>
	<label: 'Click on the left half of the first character'>
	| anEditor theAddedEvents theMovedEvents theRemovedEvents |

	anEditor := self editorOnMultilineText.

	theAddedEvents := OrderedCollection new.
	theMovedEvents := OrderedCollection new.
	theRemovedEvents := OrderedCollection new.

	anEditor navigator
		whenAdded: [ :anEvent | theAddedEvents add: anEvent ];
		whenMoved: [ :anEvent | theMovedEvents add: anEvent ];
		whenRemoved: [ :anEvent | theRemovedEvents add: anEvent ];
		moveToScreenPosition: ("self paragraphMargin left + "(self glyphWidth / 2.0) - 1) @ ("self paragraphMargin top + "(self glyphHeight / 2.0));
		apply;
		unsubscribe.

	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(0)).

	self assert: theAddedEvents size equals: 1.
	self assert: (theAddedEvents collect: #cursor) asArray equals: (BrTextEditorCursor atAll: #(0)) allCursors.
	self assert: theMovedEvents isEmpty.
	self assert: theRemovedEvents isEmpty.
	
	^ anEditor
]

{ #category : #'examples - move to screen' }
BrTextEditorParagraphBasedNavigatorExamples >> cursor_moveToScreen_1_middle_in_empty [
	<gtExample>
	<label: 'Click right in the middle of the first character'>
	| anEditor theAddedEvents theMovedEvents theRemovedEvents |
	
	anEditor := self editorOnMultilineText.
	
	theAddedEvents := OrderedCollection new.
	theMovedEvents := OrderedCollection new.
	theRemovedEvents := OrderedCollection new.

	anEditor navigator
		whenAdded: [ :anEvent | theAddedEvents add: anEvent ];
		whenMoved: [ :anEvent | theMovedEvents add: anEvent ];
		whenRemoved: [ :anEvent | theRemovedEvents add: anEvent ];
		moveToScreenPosition: ("self paragraphMargin left + "(self glyphWidth / 2.0)) @ ("self paragraphMargin top +" (self glyphHeight / 2.0));
		apply;
		unsubscribe.
		
	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(0)).
	
	self assert: theAddedEvents size equals: 1.
	self assert: (theAddedEvents collect: #cursor) asArray equals: (BrTextEditorCursor atAll: #(0)) allCursors.
	self assert: theMovedEvents isEmpty.
	self assert: theRemovedEvents isEmpty.
	
	^ anEditor
]

{ #category : #'examples - move to screen' }
BrTextEditorParagraphBasedNavigatorExamples >> cursor_moveToScreen_1_right_half_in_empty [
	<gtExample>
	<label: 'Click on the right half of the first character'>
	| anEditor theAddedEvents theMovedEvents theRemovedEvents |
	
	anEditor := self editorOnMultilineText.
	
	theAddedEvents := OrderedCollection new.
	theMovedEvents := OrderedCollection new.
	theRemovedEvents := OrderedCollection new.

	anEditor navigator
		whenAdded: [ :anEvent | theAddedEvents add: anEvent ];
		whenMoved: [ :anEvent | theMovedEvents add: anEvent ];
		whenRemoved: [ :anEvent | theRemovedEvents add: anEvent ];
		moveToScreenPosition: ("self paragraphMargin left + "(self glyphWidth / 2.0) + 5) @ ("self paragraphMargin top + "(self glyphHeight / 2.0));
		apply;
		unsubscribe.
		
	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(1)).
	
	self assert: theAddedEvents size equals: 1.
	self assert: (theAddedEvents collect: #cursor) asArray equals: (BrTextEditorCursor atAll: #(1)) allCursors.
	self assert: theMovedEvents isEmpty.
	self assert: theRemovedEvents isEmpty.
	
	^ anEditor
]

{ #category : #'examples - move to screen' }
BrTextEditorParagraphBasedNavigatorExamples >> cursor_moveToScreen_41_right_in_empty [
	<gtExample>
	<label: 'Click on the right half of the 41th character'>
	| anEditor theAddedEvents theMovedEvents theRemovedEvents |

	anEditor := self editorOnMultilineText.

	theAddedEvents := OrderedCollection new.
	theMovedEvents := OrderedCollection new.
	theRemovedEvents := OrderedCollection new.

	anEditor navigator
		whenAdded: [ :anEvent | theAddedEvents add: anEvent ];
		whenMoved: [ :anEvent | theMovedEvents add: anEvent ];
		whenRemoved: [ :anEvent | theRemovedEvents add: anEvent ];
		moveToScreenPosition: (400@100);
		apply;
		unsubscribe.

	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(67)).

	self assert: theAddedEvents size equals: 1.
	self assert: (theAddedEvents collect: #cursor) asArray equals: (BrTextEditorCursor atAll: #(67)) allCursors.
	self assert: theMovedEvents isEmpty.
	self assert: theRemovedEvents isEmpty.
	
	^ anEditor
]

{ #category : #'examples - move to' }
BrTextEditorParagraphBasedNavigatorExamples >> cursor_moveTo_67_in_cursors_at_68 [
	<gtExample>
	| anEditor theAddedEvents theMovedEvents theRemovedEvents |
	
	anEditor := self cursor_add_at_68_in_empty.
	
	theAddedEvents := OrderedCollection new.
	theMovedEvents := OrderedCollection new.
	theRemovedEvents := OrderedCollection new.

	anEditor navigator
		whenAdded: [ :anEvent | theAddedEvents add: anEvent ];
		whenMoved: [ :anEvent | theMovedEvents add: anEvent ];
		whenRemoved: [ :anEvent | theRemovedEvents add: anEvent ];
		moveTo: 67;
		apply;
		unsubscribe.
	
	anEditor forceLayout.

	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors allCursors equals: { BrTextEditorSingleCursor new position: 67 }.
	
	self assert: theAddedEvents isEmpty.
	self assert: theMovedEvents size equals: 1.
	self assert: theMovedEvents first cursor equals: (BrTextEditorSingleCursor new position: 67).
	self assert: theMovedEvents first oldIndex equals: 68.
	self assert: theMovedEvents first newIndex equals: 67.
	self assert: theRemovedEvents isEmpty.

	^ anEditor
]

{ #category : #'examples - performance' }
BrTextEditorParagraphBasedNavigatorExamples >> cursor_move_from_1_to_2_does_not_rebuild_editor [
	<gtExample>
	| anEditor thePreviousSegments theNewSegments thePreviousTextPieces theNewTextPieces |

	anEditor := self cursor_add_at_1_does_not_rebuild_editor.

	thePreviousSegments := anEditor children
		select: [ :eachChild | eachChild isKindOf: BrTextEditorSegmentElement ].	
	self assert: thePreviousSegments size equals: 11.

	thePreviousTextPieces := thePreviousSegments flatCollect: [ :eachSegment | eachSegment children asArray ].
	self assert: thePreviousTextPieces size equals: 12.

	anEditor navigator
		moveTo: 2;
		apply.

	anEditor forceLayout.

	self assert: anEditor cursors allCursors equals: { BrTextEditorSingleCursor new position: 2 }.
	
	theNewSegments := anEditor children
		select: [ :eachChild | eachChild isKindOf: BrTextEditorSegmentElement ].	
	self assert: theNewSegments size equals: 11.
	
	theNewTextPieces := theNewSegments flatCollect: [ :eachSegment | eachSegment children asArray ].
	self assert: theNewTextPieces size equals: 12.
	
	self assert: thePreviousSegments equals: theNewSegments.
	self assert: thePreviousTextPieces equals: theNewTextPieces.
	
	^ anEditor
]

{ #category : #accessing }
BrTextEditorParagraphBasedNavigatorExamples >> editorFor: aText [
	<return: #BrEditor>
	| anEditor aRopedText |

	aRopedText := aText asRopedText lineSpacing: self lineSpacing; paragraphMargin: self paragraphMargin; wordPadding: self wordPadding.

	anEditor := BrEditor new.
	anEditor editor beParagraphBased.
	anEditor aptitude: BrEditorAptitude new.
	anEditor padding: BlInsets empty.
	anEditor fitContent.
	anEditor text: aRopedText.
	
	BlDevCrossover on: anEditor.
	
	anEditor editor segmentBuilder
		wordStencil: [ :aTBrTextEditorTextualPiece |
			| aTextElement |
			aTextElement := BrTextEditableWordPieceStencilBuilder new
				segmentPiece: aTBrTextEditorTextualPiece;
				asElement.
			aTextElement measurer: self fixedMeasurer.
			aTextElement measurer textOffset: aTBrTextEditorTextualPiece textStart.
			aTextElement ].
	
	anEditor requestFocus.
	anEditor forceLayout.

	^ anEditor
]
