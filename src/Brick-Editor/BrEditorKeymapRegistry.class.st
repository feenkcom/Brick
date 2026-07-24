Class {
	#name : #BrEditorKeymapRegistry,
	#superclass : #BlShortcutKeymapRegistryCategory,
	#category : #'Brick-Editor-Shortcuts'
}

{ #category : #accessing }
BrEditorKeymapRegistry class >> registryLabel [
	^'Editor'
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultCarriageReturnShortcutCombination [
	^ BlKeyCombination return
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultCopyShortcutCombination [
	^ BlKeyCombination primaryC
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultCutShortcutCombination [
	^ BlKeyCombination primaryX
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultDeleteNextWordShortcutCombination [
	^ BlKeyCombination builder primary delete build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultDeleteOneLetterAfterCursorShortcutCombination [
	^ BlKeyCombination delete
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultDeleteOneLetterBeforeCursorShortcutCombination [
	^ BlKeyCombination backspace
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultDeletePreviousWordShortcutCombination [
	^ BlKeyCombination builder primary backspace build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultDeselectAllShortcutCombination [
	^ BlKeyCombination escape
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultFocusNextShortcutCombination [
	^ BlKeyCombination arrowRight
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultFocusPreviousShortcutCombination [
	^ BlKeyCombination arrowLeft
]

{ #category : #'accessing - defaults' }
BrEditorKeymapRegistry >> defaultLoseFocusShortcutIdCombination [
	^BlKeyCombination escape
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorDownShortcutCombination [
	^ BlKeyCombination arrowDown
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorLeftShortcutCombination [
	^ BlKeyCombination arrowLeft
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorRightShortcutCombination [
	^ BlKeyCombination arrowRight
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorToBeginningShortcutCombination [
	^ BlKeyCombination builder primary home build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorToEndShortcutCombination [
	^ BlKeyCombination builder primary end build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorToLineEndShortcutCombination [
	^ BlKeyCombination end
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorToLineEndShortcutCombinationMacOs [
	^ BlKeyCombination end or: BlKeyCombination primaryArrowRight
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorToLineStartShortcutCombination [
	^ BlKeyCombination home
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorToLineStartShortcutCombinationMacOs [
	^ BlKeyCombination home or: BlKeyCombination primaryArrowLeft
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorToNextWordShortcutCombination [
	^ BlKeyCombination builder control arrowRight build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorToNextWordShortcutCombinationMacOs [
	^ BlKeyCombination builder alt arrowRight build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorToPreviousWordShortcutCombination [
	^ BlKeyCombination builder control arrowLeft build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorToPreviousWordShortcutCombinationMacOs [
	^ BlKeyCombination builder alt arrowLeft build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultMoveCursorUpShortcutCombination [
	^ BlKeyCombination arrowUp
]

{ #category : #'accessing - defaults' }
BrEditorKeymapRegistry >> defaultNewLineShortcutIdShortcutCombination [
	^BlKeyCombination return
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultPasteShortcutCombination [
	^ BlKeyCombination primaryV
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultRedoShortcutCombination [
	^ BlKeyCombination primaryShiftZ
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectAllShortcutCombination [
	^ BlKeyCombination primaryA
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectLetterAfterCursorShortcutCombination [
	^ BlKeyCombination shiftArrowRight
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectLetterBeforeCursorShortcutCombination [
	^ BlKeyCombination shiftArrowLeft
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectLineAboveCursorShortcutCombination [
	^ BlKeyCombination shiftArrowUp
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectLineAfterCursorShortcutCombination [
	^ BlKeyCombination shiftEnd
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectLineAfterCursorShortcutCombinationMacOs [
	^ BlKeyCombination primaryShiftArrowRight or: BlKeyCombination shiftEnd
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectLineBeforeCursorShortcutCombination [
	^ BlKeyCombination shiftHome
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectLineBeforeCursorShortcutCombinationMacOs [
	^ BlKeyCombination primaryShiftArrowLeft or: BlKeyCombination shiftHome
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectLineBelowCursorShortcutCombination [
	^ BlKeyCombination shiftArrowDown
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectToBeginningShortcutCombination [
	^ BlKeyCombination builder primary shift home build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectToEndShortcutCombination [
	^ BlKeyCombination builder primary shift end build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectWordAfterCursorShortcutCombination [
	^ BlKeyCombination builder shift control arrowRight build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectWordAfterCursorShortcutCombinationMacOs [
	^ BlKeyCombination builder shift alt arrowRight build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectWordBeforeCursorShortcutCombination [
	^ BlKeyCombination builder shift control arrowLeft build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultSelectWordBeforeCursorShortcutCombinationMacOs [
	^ BlKeyCombination builder shift alt arrowLeft build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultShiftLeftShortcutCombination [
	^ BlKeyCombination builder shift tab build
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultShiftRightShortcutCombination [
	^ BlKeyCombination tab
]

{ #category : #defaults }
BrEditorKeymapRegistry >> defaultUndoShortcutCombination [
	^ BlKeyCombination primaryZ
]

{ #category : #initialization }
BrEditorKeymapRegistry >> initializeBasicCombinations [
	super initializeBasicCombinations.
	
	self 
		initializeShortcut: BrEditorShortcutIds default newLineShortcutId 
		with: self defaultNewLineShortcutIdShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default loseFocusShortcutId 
		with: self defaultLoseFocusShortcutIdCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default carriageReturnShortcutId 
		with: self defaultCarriageReturnShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default moveCursorLeftShortcutId 
		with: self defaultMoveCursorLeftShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default moveCursorRightShortcutId 
		with: self defaultMoveCursorRightShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default moveCursorUpShortcutId 
		with: self defaultMoveCursorUpShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default moveCursorDownShortcutId 
		with: self defaultMoveCursorDownShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default moveCursorToBeginningShortcutId 
		with: self defaultMoveCursorToBeginningShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default moveCursorToEndShortcutId 
		with: self defaultMoveCursorToEndShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default moveCursorToLineStartShortcutId 
		with: self defaultMoveCursorToLineStartShortcutCombination
		macOs: self defaultMoveCursorToLineStartShortcutCombinationMacOs.
	self 
		initializeShortcut: BrEditorShortcutIds default moveCursorToLineEndShortcutId 
		with: self defaultMoveCursorToLineEndShortcutCombination
		macOs: self defaultMoveCursorToLineEndShortcutCombinationMacOs.
	self 
		initializeShortcut: BrEditorShortcutIds default moveCursorToNextWordShortcutId 
		with: self defaultMoveCursorToNextWordShortcutCombination
		macOs: self defaultMoveCursorToNextWordShortcutCombinationMacOs.
	self 
		initializeShortcut: BrEditorShortcutIds default moveCursorToPreviousWordShortcutId 
		with: self defaultMoveCursorToPreviousWordShortcutCombination
		macOs: self defaultMoveCursorToPreviousWordShortcutCombinationMacOs.
	self 
		initializeShortcut: BrEditorShortcutIds default selectAllShortcutId 
		with: self defaultSelectAllShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default selectLetterBeforeCursorShortcutId 
		with: self defaultSelectLetterBeforeCursorShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default selectLetterAfterCursorShortcutId 
		with: self defaultSelectLetterAfterCursorShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default selectWordBeforeCursorShortcutId 
		with: self defaultSelectWordBeforeCursorShortcutCombination
		macOs: self defaultSelectWordBeforeCursorShortcutCombinationMacOs.
	self 
		initializeShortcut: BrEditorShortcutIds default selectWordAfterCursorShortcutId 
		with: self defaultSelectWordAfterCursorShortcutCombination
		macOs: self defaultSelectWordAfterCursorShortcutCombinationMacOs.
	self 
		initializeShortcut: BrEditorShortcutIds default selectLineBeforeCursorShortcutId 
		with: self defaultSelectLineBeforeCursorShortcutCombination
		macOs: self defaultSelectLineBeforeCursorShortcutCombinationMacOs.
	self 
		initializeShortcut: BrEditorShortcutIds default selectLineAfterCursorShortcutId 
		with: self defaultSelectLineAfterCursorShortcutCombination
		macOs: self defaultSelectLineAfterCursorShortcutCombinationMacOs.
	self 
		initializeShortcut: BrEditorShortcutIds default selectLineAboveCursorShortcutId 
		with: self defaultSelectLineAboveCursorShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default selectLineBelowCursorShortcutId 
		with: self defaultSelectLineBelowCursorShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default selectToBeginningShortcutId 
		with: self defaultSelectToBeginningShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default selectToEndShortcutId 
		with: self defaultSelectToEndShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default deselectAllShortcutId 
		with: self defaultDeselectAllShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default copyShortcutId 
		with: self defaultCopyShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default cutShortcutId 
		with: self defaultCutShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default pasteShortcutId 
		with: self defaultPasteShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default undoShortcutId 
		with: self defaultUndoShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default redoShortcutId 
		with: self defaultRedoShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default deleteOneLetterBeforeCursorShortcutId 
		with: self defaultDeleteOneLetterBeforeCursorShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default deleteOneLetterAfterCursorShortcutId 
		with: self defaultDeleteOneLetterAfterCursorShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default deleteNextWordShortcutId 
		with: self defaultDeleteNextWordShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default deletePreviousWordShortcutId 
		with: self defaultDeletePreviousWordShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default shiftRightShortcutId 
		with: self defaultShiftRightShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default shiftLeftShortcutId 
		with: self defaultShiftLeftShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default focusNextShortcutId 
		with: self defaultFocusNextShortcutCombination.
	self 
		initializeShortcut: BrEditorShortcutIds default focusPreviousShortcutId 
		with: self defaultFocusPreviousShortcutCombination
]
