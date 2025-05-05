Class {
	#name : #BrTextEditorHistoryCommandsExamples,
	#superclass : #Object,
	#category : #'Brick-Editor-Examples-History'
}

{ #category : #assertions }
BrTextEditorHistoryCommandsExamples >> assertCommandCursorsFor: anEditCommand redo: aRedoCursor undo: anUndoCursor [
	self 
		assert: anEditCommand cursorForRedoEdit
		equals: aRedoCursor.
	self 
		assert: anEditCommand cursorForUndoEdit
		equals: anUndoCursor.
]

{ #category : #'examples - commands' }
BrTextEditorHistoryCommandsExamples >> deleteSingleCharacterCommandAtPositionOne [
	<gtExample>
	<return: #BrTextEditorHistoryDeletionCommand>
	^ BrTextEditorHistoryDeletionCommand new
		texts: {'a' asRopedText};
		undoIndices: #(1);
		redoIndices: #(1)
]

{ #category : #'examples - cursors' }
BrTextEditorHistoryCommandsExamples >> deleteSingleCharacterCommandAtPositionOne_undoRedoCursorPositions [
	<gtExample>
	<return: #BrTextEditorHistoryDeletionCommand>
	| command |
	command := self deleteSingleCharacterCommandAtPositionOne.
	self
		assertCommandCursorsFor: command
		redo: (BrTextEditorSingleCursor at: 0)
		undo: (BrTextEditorSingleCursor at: 1).

	^ command
]

{ #category : #'examples - commands' }
BrTextEditorHistoryCommandsExamples >> deleteSingleCharacterCommandAtPositionTwo [
	<gtExample>
	<return: #BrTextEditorHistoryDeletionCommand>
	^ BrTextEditorHistoryDeletionCommand new
		texts: {'b' asRopedText};
		undoIndices: #(2);
		redoIndices: #(2)
]

{ #category : #'examples - cursors' }
BrTextEditorHistoryCommandsExamples >> deleteSingleCharacterCommandAtPositionTwo_undoRedoCursorPositions [
	<gtExample>
	<return: #BrTextEditorHistoryDeletionCommand>
	| command |
	command := self deleteSingleCharacterCommandAtPositionTwo.
	self
		assertCommandCursorsFor: command
		redo: (BrTextEditorSingleCursor at: 1)
		undo: (BrTextEditorSingleCursor at: 2).

	^ command
]

{ #category : #'examples - commands' }
BrTextEditorHistoryCommandsExamples >> deleteSingleCharactersCommandAtTwoPositionsOneSameLine [
	<gtExample>
	<return: #BrTextEditorHistoryDeletionCommand>
	^ BrTextEditorHistoryDeletionCommand new
		texts: {'1' asRopedText.
				'1' asRopedText};
		undoIndices: #(2 5);
		redoIndices: #(2 4)
]

{ #category : #'examples - cursors' }
BrTextEditorHistoryCommandsExamples >> deleteSingleCharactersCommandAtTwoPositionsOneSameLine_undoRedoCursorPositions [
	<gtExample>
	<return: #BrTextEditorHistoryDeletionCommand>
	| command |
	command := self deleteSingleCharactersCommandAtTwoPositionsOneSameLine.
	self
		assertCommandCursorsFor: command
		redo: (BrTextEditorCursor atAll: #(1 4))
		undo: (BrTextEditorCursor atAll: #(2 4)).

	^ command
]

{ #category : #'examples - commands' }
BrTextEditorHistoryCommandsExamples >> insertMultipleCharactersCommandAtTwoPositionsOneSameLine [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	^ BrTextEditorHistoryInsertionCommand new
		strings: {'123'.
				'123'};
		undoIndices: #(1 6);
		redoIndices: #(1 3)
]

{ #category : #'examples - cursors' }
BrTextEditorHistoryCommandsExamples >> insertMultipleCharactersCommandAtTwoPositionsOneSameLine_undoRedoCursorPositions [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	| command |
	command := self insertMultipleCharactersCommandAtTwoPositionsOneSameLine.
	self
		assertCommandCursorsFor: command
		redo: (BrTextEditorCursor atAll: #(4 9))
		undo: (BrTextEditorCursor atAll: #(1 3)).

	^ command
]

{ #category : #'examples - commands' }
BrTextEditorHistoryCommandsExamples >> insertSingleCharacterCommandAtPositionOne [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	^ BrTextEditorHistoryInsertionCommand new
		strings: {'a'};
		undoIndices: #(1);
		redoIndices: #(1)
]

{ #category : #'examples - cursors' }
BrTextEditorHistoryCommandsExamples >> insertSingleCharacterCommandAtPositionOne_undoRedoCursorPositions [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	| command |
	command := self insertSingleCharacterCommandAtPositionOne.
	self
		assertCommandCursorsFor: command
		redo: (BrTextEditorSingleCursor at: 2)
		undo: (BrTextEditorSingleCursor at: 1).

	^ command
]

{ #category : #'examples - commands' }
BrTextEditorHistoryCommandsExamples >> insertSingleCharacterCommandAtPositionZero [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	^ BrTextEditorHistoryInsertionCommand new
		strings: {'a'};
		undoIndices: #(0);
		redoIndices: #(0)
]

{ #category : #'examples - cursors' }
BrTextEditorHistoryCommandsExamples >> insertSingleCharacterCommandAtPositionZero_undoRedoCursorPositions [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	| command |
	command := self insertSingleCharacterCommandAtPositionZero.
	self
		assertCommandCursorsFor: command
		redo: (BrTextEditorSingleCursor at: 1)
		undo: (BrTextEditorSingleCursor at: 0).

	^ command
]

{ #category : #'examples - commands' }
BrTextEditorHistoryCommandsExamples >> insertSingleCharactersCommandAtTwoPositionsOneSameLine [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	^ BrTextEditorHistoryInsertionCommand new
		strings: {'1'.
				'1'};
		undoIndices: #(1 4);
		redoIndices: #(1 3)
]

{ #category : #'examples - cursors' }
BrTextEditorHistoryCommandsExamples >> insertSingleCharactersCommandAtTwoPositionsOneSameLine_undoRedoCursorPositions [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	| command |
	command := self insertSingleCharactersCommandAtTwoPositionsOneSameLine.
	self
		assertCommandCursorsFor: command
		redo: (BrTextEditorCursor atAll: #(2 5))
		undo: (BrTextEditorCursor atAll: #(1 3)).

	^ command
]
