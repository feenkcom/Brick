Class {
	#name : #BrEditorShortcutIds,
	#superclass : #BlShortcutIds,
	#instVars : [
		'newLineShortcutId',
		'loseFocusShortcutId',
		'carriageReturnShortcutId',
		'moveCursorLeftShortcutId',
		'moveCursorRightShortcutId',
		'moveCursorUpShortcutId',
		'moveCursorDownShortcutId',
		'moveCursorToBeginningShortcutId',
		'moveCursorToEndShortcutId',
		'moveCursorToLineStartShortcutId',
		'moveCursorToLineEndShortcutId',
		'moveCursorToNextWordShortcutId',
		'moveCursorToPreviousWordShortcutId',
		'selectAllShortcutId',
		'selectLetterBeforeCursorShortcutId',
		'selectLetterAfterCursorShortcutId',
		'selectWordBeforeCursorShortcutId',
		'selectWordAfterCursorShortcutId',
		'selectLineBeforeCursorShortcutId',
		'selectLineAfterCursorShortcutId',
		'selectLineAboveCursorShortcutId',
		'selectLineBelowCursorShortcutId',
		'selectToBeginningShortcutId',
		'selectToEndShortcutId',
		'deselectAllShortcutId',
		'copyShortcutId',
		'cutShortcutId',
		'pasteShortcutId',
		'undoShortcutId',
		'redoShortcutId',
		'deleteOneLetterBeforeCursorShortcutId',
		'deleteOneLetterAfterCursorShortcutId',
		'deleteNextWordShortcutId',
		'deletePreviousWordShortcutId',
		'shiftRightShortcutId',
		'shiftLeftShortcutId',
		'focusNextShortcutId',
		'focusPreviousShortcutId'
	],
	#category : #'Brick-Editor-Shortcuts'
}

{ #category : #accessing }
BrEditorShortcutIds >> carriageReturnShortcutId [
	^ carriageReturnShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> copyShortcutId [
	^ copyShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> cutShortcutId [
	^ cutShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> deleteNextWordShortcutId [
	^ deleteNextWordShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> deleteOneLetterAfterCursorShortcutId [
	^ deleteOneLetterAfterCursorShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> deleteOneLetterBeforeCursorShortcutId [
	^ deleteOneLetterBeforeCursorShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> deletePreviousWordShortcutId [
	^ deletePreviousWordShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> deselectAllShortcutId [
	^ deselectAllShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> focusNextShortcutId [
	^ focusNextShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> focusPreviousShortcutId [
	^ focusPreviousShortcutId
]

{ #category : #initialization }
BrEditorShortcutIds >> initialize [ 
	super initialize.
	
	newLineShortcutId := BlShortcutId identifier: #NewLine.
	loseFocusShortcutId := BlShortcutId identifier: #LoseFocus.
	carriageReturnShortcutId := BlShortcutId identifier: #CarriageReturn.
	moveCursorLeftShortcutId := BlShortcutId identifier: #MoveCursorLeft.
	moveCursorRightShortcutId := BlShortcutId identifier: #MoveCursorRight.
	moveCursorUpShortcutId := BlShortcutId identifier: #MoveCursorUp.
	moveCursorDownShortcutId := BlShortcutId identifier: #MoveCursorDown.
	moveCursorToBeginningShortcutId := BlShortcutId identifier: #MoveCursorToBeginning.
	moveCursorToEndShortcutId := BlShortcutId identifier: #MoveCursorToEnd.
	moveCursorToLineStartShortcutId := BlShortcutId identifier: #MoveCursorToLineStart.
	moveCursorToLineEndShortcutId := BlShortcutId identifier: #MoveCursorToLineEnd.
	moveCursorToNextWordShortcutId := BlShortcutId identifier: #MoveCursorToNextWord.
	moveCursorToPreviousWordShortcutId := BlShortcutId identifier: #MoveCursorToPreviousWord.
	selectAllShortcutId := BlShortcutId identifier: #SelectAll.
	selectLetterBeforeCursorShortcutId := BlShortcutId identifier: #SelectLetterBeforeCursor.
	selectLetterAfterCursorShortcutId := BlShortcutId identifier: #SelectLetterAfterCursor.
	selectWordBeforeCursorShortcutId := BlShortcutId identifier: #SelectWordBeforeCursor.
	selectWordAfterCursorShortcutId := BlShortcutId identifier: #SelectWordAfterCursor.
	selectLineBeforeCursorShortcutId := BlShortcutId identifier: #SelectLineBeforeCursor.
	selectLineAfterCursorShortcutId := BlShortcutId identifier: #SelectLineAfterCursor.
	selectLineAboveCursorShortcutId := BlShortcutId identifier: #SelectLineAboveCursor.
	selectLineBelowCursorShortcutId := BlShortcutId identifier: #SelectLineBelowCursor.
	selectToBeginningShortcutId := BlShortcutId identifier: #SelectToBeginning.
	selectToEndShortcutId := BlShortcutId identifier: #SelectToEnd.
	deselectAllShortcutId := BlShortcutId identifier: #DeselectAll.
	copyShortcutId := BlShortcutId identifier: #Copy.
	cutShortcutId := BlShortcutId identifier: #Cut.
	pasteShortcutId := BlShortcutId identifier: #Paste.
	undoShortcutId := BlShortcutId identifier: #Undo.
	redoShortcutId := BlShortcutId identifier: #Redo.
	deleteOneLetterBeforeCursorShortcutId := BlShortcutId identifier: #DeleteOneLetterBeforeCursor.
	deleteOneLetterAfterCursorShortcutId := BlShortcutId identifier: #DeleteOneLetterAfterCursor.
	deleteNextWordShortcutId := BlShortcutId identifier: #DeleteNextWord.
	deletePreviousWordShortcutId := BlShortcutId identifier: #DeletePreviousWord.
	shiftRightShortcutId := BlShortcutId identifier: #ShiftRight.
	shiftLeftShortcutId := BlShortcutId identifier: #ShiftLeft.
	focusNextShortcutId := BlShortcutId identifier: #FocusNext.
	focusPreviousShortcutId := BlShortcutId identifier: #FocusPrevious.
]

{ #category : #'as yet unclassified' }
BrEditorShortcutIds >> loseFocusShortcutId [
	^ loseFocusShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> moveCursorDownShortcutId [
	^ moveCursorDownShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> moveCursorLeftShortcutId [
	^ moveCursorLeftShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> moveCursorRightShortcutId [
	^ moveCursorRightShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> moveCursorToBeginningShortcutId [
	^ moveCursorToBeginningShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> moveCursorToEndShortcutId [
	^ moveCursorToEndShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> moveCursorToLineEndShortcutId [
	^ moveCursorToLineEndShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> moveCursorToLineStartShortcutId [
	^ moveCursorToLineStartShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> moveCursorToNextWordShortcutId [
	^ moveCursorToNextWordShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> moveCursorToPreviousWordShortcutId [
	^ moveCursorToPreviousWordShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> moveCursorUpShortcutId [
	^ moveCursorUpShortcutId
]

{ #category : #'as yet unclassified' }
BrEditorShortcutIds >> newLineShortcutId [
	^ newLineShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> pasteShortcutId [
	^ pasteShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> redoShortcutId [
	^ redoShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> selectAllShortcutId [
	^ selectAllShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> selectLetterAfterCursorShortcutId [
	^ selectLetterAfterCursorShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> selectLetterBeforeCursorShortcutId [
	^ selectLetterBeforeCursorShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> selectLineAboveCursorShortcutId [
	^ selectLineAboveCursorShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> selectLineAfterCursorShortcutId [
	^ selectLineAfterCursorShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> selectLineBeforeCursorShortcutId [
	^ selectLineBeforeCursorShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> selectLineBelowCursorShortcutId [
	^ selectLineBelowCursorShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> selectToBeginningShortcutId [
	^ selectToBeginningShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> selectToEndShortcutId [
	^ selectToEndShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> selectWordAfterCursorShortcutId [
	^ selectWordAfterCursorShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> selectWordBeforeCursorShortcutId [
	^ selectWordBeforeCursorShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> shiftLeftShortcutId [
	^ shiftLeftShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> shiftRightShortcutId [
	^ shiftRightShortcutId
]

{ #category : #accessing }
BrEditorShortcutIds >> undoShortcutId [
	^ undoShortcutId
]
