Class {
	#name : #BrTextEditorEditableMode,
	#superclass : #BrTextEditorBasicMode,
	#category : #'Brick-Editor-Model'
}

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

{ #category : #initialization }
BrTextEditorEditableMode >> initialize [
	super initialize.

	shortcuts := shortcuts, 
		(self returnKeyAndAction
			ifNil: [ #() ]
			ifNotNil: [ :anAction | { anAction } ]),
	{
		BrEditorShortcut deleteOneLetterAfterCursor.
		BrEditorShortcut deleteOneLetterBeforeCursor.
		BrEditorShortcut shiftRight.
		BrEditorShortcut shiftLeft.
		BrEditorShortcut cut.
		BrEditorShortcut copy.
		BrEditorShortcut paste.
		BrEditorShortcut undo.
		BrEditorShortcut redo.
		
		BrEditorShortcut moveCursorLeft.
		BrEditorShortcut moveCursorRight.
		BrEditorShortcut moveCursorUp.
		BrEditorShortcut moveCursorDown.
		BrEditorShortcut moveCursorToPreviousWord.
		BrEditorShortcut moveCursorToNextWord.
		BrEditorShortcut moveCursorToLineStart.
		BrEditorShortcut moveCursorToLineEnd.
		BrEditorShortcut moveCursorToBeginning.
		BrEditorShortcut moveCursorToEnd.
		
		BrEditorShortcut selectAll.
		BrEditorShortcut deselectAll.
		BrEditorShortcut selectLetterAfterCursor.
		BrEditorShortcut selectLetterBeforeCursor.
		BrEditorShortcut selectWordBeforeCursor.
		BrEditorShortcut selectWordAfterCursor.
		BrEditorShortcut selectLineBeforeCursor.
		BrEditorShortcut selectLineAfterCursor.
		BrEditorShortcut selectLineBelowCursor.
		BrEditorShortcut selectLineAboveCursor.
		BrEditorShortcut selectToBeginning.
		BrEditorShortcut selectToEnd.
	}
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

{ #category : #defaults }
BrTextEditorEditableMode >> returnKeyAndAction [
	^ BrEditorShortcut lineEnding
]
