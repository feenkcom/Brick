Class {
	#name : #BrTextEditorEditableMode,
	#superclass : #BrTextEditorBasicMode,
	#category : #'Brick-Editor-Model'
}

{ #category : #shortcuts }
BrTextEditorEditableMode >> copyShortcut [
	^ BrEditorShortcut copy
]

{ #category : #initialization }
BrTextEditorEditableMode >> createEventHandlers [
	^ super createEventHandlers, {
		BrTextEditorMouseDownHandler uniqueInstance.
		BrTextEditorDoubleClickHandler uniqueInstance.
		BrTextEditorSelectionHandler new.
		BrTextEditorInsertionHandler uniqueInstance.
		BrTextEditorCursorIconHandler uniqueInstance.
	}
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> createShortcuts [
	^ super createShortcuts
		, {self returnShortcut.
				self deleteOneLetterAfterCursorShortcut.
				self deleteOneLetterBeforeCursorShortcut.
				self deleteOneWordAfterCursorShortcut.
				self deleteOneWordBeforeCursorShortcut.
				self shiftRightShortcut.
				self shiftLeftShortcut.
				self cutShortcut.
				self copyShortcut.
				self pasteShortcut.
				self undoShortcut.
				self redoShortcut.
				self moveCursorLeftShortcut.
				self moveCursorRightShortcut.
				self moveCursorUpShortcut.
				self moveCursorDownShortcut.
				self moveCursorToPreviousWordShortcut.
				self moveCursorToNextWordShortcut.
				self moveCursorToLineStartShortcut.
				self moveCursorToLineEndShortcut.
				self moveCursorToBeginningShortcut.
				self moveCursorToEndShortcut.
				self selectAllShortcut.
				self deselectAllShortcut.
				self selectLetterAfterCursorShortcut.
				self selectLetterBeforeCursorShortcut.
				self selectWordBeforeCursorShortcut.
				self selectWordAfterCursorShortcut.
				self selectLineBeforeCursorShortcut.
				self selectLineAfterCursorShortcut.
				self selectLineBelowCursorShortcut.
				self selectLineAboveCursorShortcut.
				self selectToBeginningShortcut.
				self selectToEndShortcut}
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> cutShortcut [
	^ BrEditorShortcut cut
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> deleteOneLetterAfterCursorShortcut [
	^ BrEditorShortcut deleteOneLetterAfterCursor
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> deleteOneLetterBeforeCursorShortcut [
	^ BrEditorShortcut deleteOneLetterBeforeCursor
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> deleteOneWordAfterCursorShortcut [
	^BrEditorShortcut deleteNextWord
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> deleteOneWordBeforeCursorShortcut [
	^BrEditorShortcut deletePreviousWord
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> deselectAllShortcut [
	^ BrEditorShortcut deselectAll
]

{ #category : #'api - hooks' }
BrTextEditorEditableMode >> installOnEditor: aTextEditor [
	super installOnEditor: aTextEditor.

	aTextEditor segmentBuilder beEditable
]

{ #category : #testing }
BrTextEditorEditableMode >> isEditable [
	^ true
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> moveCursorDownShortcut [
	^ BrEditorShortcut moveCursorDown
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> moveCursorLeftShortcut [
	^ BrEditorShortcut moveCursorLeft
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> moveCursorRightShortcut [
	^ BrEditorShortcut moveCursorRight
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> moveCursorToBeginningShortcut [
	^ BrEditorShortcut moveCursorToBeginning
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> moveCursorToEndShortcut [
	^ BrEditorShortcut moveCursorToEnd
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> moveCursorToLineEndShortcut [
	^ BrEditorShortcut moveCursorToLineEnd
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> moveCursorToLineStartShortcut [
	^ BrEditorShortcut moveCursorToLineStart
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> moveCursorToNextWordShortcut [
	^ BrEditorShortcut moveCursorToNextWord
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> moveCursorToPreviousWordShortcut [
	^ BrEditorShortcut moveCursorToPreviousWord
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> moveCursorUpShortcut [
	^ BrEditorShortcut moveCursorUp
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> pasteShortcut [
	^ BrEditorShortcut paste
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> redoShortcut [
	^ BrEditorShortcut redo
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> returnShortcut [
	^ BrEditorShortcut lineEnding
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> selectAllShortcut [
	^ BrEditorShortcut selectAll
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> selectLetterAfterCursorShortcut [
	^ BrEditorShortcut selectLetterAfterCursor
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> selectLetterBeforeCursorShortcut [
	^ BrEditorShortcut selectLetterBeforeCursor
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> selectLineAboveCursorShortcut [
	^ BrEditorShortcut selectLineAboveCursor
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> selectLineAfterCursorShortcut [
	^ BrEditorShortcut selectLineAfterCursor
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> selectLineBeforeCursorShortcut [
	^ BrEditorShortcut selectLineBeforeCursor
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> selectLineBelowCursorShortcut [
	^ BrEditorShortcut selectLineBelowCursor
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> selectToBeginningShortcut [
	^ BrEditorShortcut selectToBeginning
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> selectToEndShortcut [
	^ BrEditorShortcut selectToEnd
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> selectWordAfterCursorShortcut [
	^ BrEditorShortcut selectWordAfterCursor
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> selectWordBeforeCursorShortcut [
	^ BrEditorShortcut selectWordBeforeCursor
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> shiftLeftShortcut [
	^ BrEditorShortcut shiftLeft
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> shiftRightShortcut [
	^ BrEditorShortcut shiftRight
]

{ #category : #shortcuts }
BrTextEditorEditableMode >> undoShortcut [
	^ BrEditorShortcut undo
]
