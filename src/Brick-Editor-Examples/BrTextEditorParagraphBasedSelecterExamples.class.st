Class {
	#name : #BrTextEditorParagraphBasedSelecterExamples,
	#superclass : #BrTextEditorOperatorExamples,
	#category : #'Brick-Editor-Examples-Operators'
}

{ #category : #'examples - word' }
BrTextEditorParagraphBasedSelecterExamples >> editorFor: aText [
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

{ #category : #'examples - all' }
BrTextEditorParagraphBasedSelecterExamples >> select_all_in_empty [
	<gtExample>
	| anEditor |

	anEditor := self editorOnEmptyText.

	anEditor selecter all select.

	self assert: anEditor cursors isEmpty.
	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorParagraphBasedSelecterExamples >> select_all_in_empty_with_curor [
	<gtExample>
	| anEditor |

	anEditor := self editorOnEmptyText.

	anEditor navigator
		addAt: 0;
		apply.
	
	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors allCursors equals: { BrTextEditorSingleCursor new position: 0 }.
	self assert: anEditor selection isEmpty.

	anEditor selecter all select.

	self assert: anEditor cursors isNotEmpty.
	self assert: anEditor cursors allCursors equals: { BrTextEditorSingleCursor new position: 0 }.
	self assert: anEditor selection isEmpty.

	^ anEditor
]

{ #category : #'examples - all' }
BrTextEditorParagraphBasedSelecterExamples >> select_all_reduced [
	"There was a bug, that if a new text is smaller than the existing selection, then things can go wrong"
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor selecter
		all
		select.

	self assert: anEditor selection equals: (BlCompositeSelection new select: 0 to: self multilineText size).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { self multilineText size }).

	anEditor text: 'hello'.

	self assert: anEditor selection equals: (BlCompositeSelection new select: 0 to: 5).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { 5 }).
	
	anEditor selecter
		all
		select.

	anEditor text: 'hi'.

	self assert: anEditor selection equals: (BlCompositeSelection new select: 0 to: 2).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { 2 }).

	^ anEditor
]

{ #category : #'examples - from to' }
BrTextEditorParagraphBasedSelecterExamples >> select_from_0_to_5 [
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.

	anEditor selecter
		from: 0 to: 5;
		select.
		
	self assert: anEditor selection equals: (BlCompositeSelection new select: 0 to: 5).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(5)).

	^ anEditor
]

{ #category : #'examples - from to' }
BrTextEditorParagraphBasedSelecterExamples >> select_from_0_to_5_in_steps [
	<gtExample>
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

	self assert: anEditor selection equals: (BlCompositeSelection new select: 0 to: 5).
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(5)).

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorParagraphBasedSelecterExamples >> select_moveOneLeft_at_0 [
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 0.
	anEditor selecter moveOneToLeft; select.
	self 
		assert: anEditor selection isEmpty.
	self 
		assert: anEditor editor selectedText asString 
		equals: ''.
	
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(0)).
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorParagraphBasedSelecterExamples >> select_moveOneLeft_at_4 [
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 4.
	
	anEditor selecter
		moveOneToLeft;
		select.
	
	self 
		assert: anEditor selection 
		equals: (BlCompositeSelection new select: 3 to: 4).
	self 
		assert: anEditor editor selectedText asString 
		equals: 'u'.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(3)).

	
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorParagraphBasedSelecterExamples >> select_moveOneLeft_at_4_extendToNextWordEnd [
	<gtExample>
	| anEditor |
	anEditor := self select_moveOneLeft_at_4.

	anEditor selecter
		extendToNextWordEnd;
		select.

	self
		assert: anEditor selection 
		equals: (BlCompositeSelection new select: 4 to: 8).
	self 
		assert: anEditor editor selectedText asString 
		equals: 'mmer'.

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorParagraphBasedSelecterExamples >> select_moveOneRight_at_6 [
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 6.
	
	anEditor selecter
		moveOneToRight;
		select.
	
	self 
		assert: anEditor selection 
		equals: (BlCompositeSelection new select: 6 to: 7).
	self 
		assert: anEditor editor selectedText asString 
		equals: 'e'.
	
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(7)).
	
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorParagraphBasedSelecterExamples >> select_moveOneRight_at_6_extendToNextWordEnd [
	<gtExample>
	| anEditor |

	anEditor := self select_moveOneRight_at_6.

	anEditor selecter
		extendToNextWordEnd;
		select.

	self 
		assert: anEditor selection 
		equals: (BlCompositeSelection new select: 6 to: 8).
	self 
		assert: anEditor editor selectedText asString 
		equals: 'er'.
	
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(8)).

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorParagraphBasedSelecterExamples >> select_moveOneRight_at_6_extendToNextWordEnd_twice [
	<gtExample>
	| anEditor |
	
	anEditor := self select_moveOneRight_at_6_extendToNextWordEnd.
	anEditor selecter
		extendToNextWordEnd;
		select.
	
	self 
		assert: anEditor selection 
		equals: (BlCompositeSelection new select: 6 to: 14).
	self 
		assert: anEditor editor selectedText asString 
		equals: 'er river'.
	
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(14)).
	
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorParagraphBasedSelecterExamples >> select_moveOneRight_at_6_extendToPreviousWordStart [
	<gtExample>
	| anEditor |
	
	anEditor := self select_moveOneRight_at_6.
	anEditor selecter
		extendToPreviousWordStart;
		select.
	
	self 
		assert: anEditor selection 
		equals: (BlCompositeSelection new select: 2 to: 6).
	self 
		assert: anEditor editor selectedText asString 
		equals: 'summ'.
	
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(2)).
	
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorParagraphBasedSelecterExamples >> select_moveOneRight_at_6_extendToPreviousWordStart_twice [
	<gtExample>
	| anEditor |
	
	anEditor := self select_moveOneRight_at_6_extendToPreviousWordStart.
	anEditor selecter
		extendToPreviousWordStart;
		select.
	
	self 
		assert: anEditor selection 
		equals: (BlCompositeSelection new select: 0 to: 6).
	self 
		assert: anEditor editor selectedText asString 
		equals: 'A summ'.
	
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(0)).
	
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorParagraphBasedSelecterExamples >> select_moveOneRight_at_End [
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: anEditor text size.
	anEditor selecter moveOneToRight; select.
	self 
		assert: anEditor selection isEmpty.
	self 
		assert: anEditor editor selectedText asString 
		equals: ''.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { anEditor text size }).

	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorParagraphBasedSelecterExamples >> select_moveTwiceLeft_at_1 [
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: 1.
	
	anEditor selecter
		moveOneToLeft
		select.

	anEditor editor moveCursorTo: 0.
	
	anEditor selecter
		moveOneToLeft;
		select.
	
	self 
		assert: anEditor selection 
		equals: (BlCompositeSelection new select: 0 to: 1).
	self 
		assert: anEditor editor selectedText asString 
		equals: 'A'.
	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(0)).
	^ anEditor
]

{ #category : #'examples - move' }
BrTextEditorParagraphBasedSelecterExamples >> select_moveTwiceRight_at_End [
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor editor moveCursorTo: anEditor text size - 1.
	anEditor selecter moveOneToRight; select.
	anEditor editor moveCursorTo: anEditor text size.
	
	anEditor selecter
		moveOneToRight;
		select.

	self 
		assert: anEditor selection 
		equals: (BlCompositeSelection new select: anEditor text size - 1 to: anEditor text size).
	self 
		assert: anEditor editor selectedText asString 
		equals: '.'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: { anEditor text size }).

	^ anEditor
]

{ #category : #'examples - word' }
BrTextEditorParagraphBasedSelecterExamples >> select_word_at_0 [
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor selecter
		wordAt: 0;
		select.

	self assert: anEditor selection equals: (BlCompositeSelection new select: 0 to: 1).
	self assert: anEditor editor selectedText asString equals: 'A'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(1)).

	^ anEditor
]

{ #category : #'examples - word' }
BrTextEditorParagraphBasedSelecterExamples >> select_word_at_1 [
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor selecter
		wordAt: 1;
		select.

	self assert: anEditor selection equals: (BlCompositeSelection new select: 0 to: 1).
	self assert: anEditor editor selectedText asString equals: 'A'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(1)).

	^ anEditor
]

{ #category : #'examples - word' }
BrTextEditorParagraphBasedSelecterExamples >> select_word_at_2 [
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor selecter
		wordAt: 2;
		select.

	self assert: anEditor selection equals: (BlCompositeSelection new select: 2 to: 8).
	self assert: anEditor editor selectedText asString equals: 'summer'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(8)).

	^ anEditor
]

{ #category : #'examples - word' }
BrTextEditorParagraphBasedSelecterExamples >> select_word_at_2_and_10 [
	<gtExample>
	| anEditor |

	anEditor := self editorOnMultilineText.
	anEditor selecter
		wordAt: 2;
		wordAt: 10;
		select.

	self assert: anEditor selection equals: (BlCompositeSelection new select: 2 to: 8; select: 9 to: 14).
	self assert: anEditor editor selectedText asString equals: 'summer river'.

	self assert: anEditor cursors equals: (BrTextEditorCursor atAll: #(8 14)).

	^ anEditor
]
