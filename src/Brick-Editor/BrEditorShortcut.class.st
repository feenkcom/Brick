"
BrEditorShortcut can be used in a pluggable manner by writing a class-side constructor method, or it can be overridden in subclasses
"
Class {
	#name : #BrEditorShortcut,
	#superclass : #BlBasicShortcut,
	#instVars : [
		'name',
		'performBlock',
		'description',
		'combinationForUnix',
		'combinationForMacOS',
		'combinationForWindows'
	],
	#category : #'Brick-Editor-Shortcuts'
}

{ #category : #'shortcut creation' }
BrEditorShortcut class >> carriageReturn [

	^ self new
		  name: 'Insert carriage return';
		  description:
			  'Inserts a carriage return (cr) at the cursor location and indents the new line to match the indentation of the previous line.';
		  combination: BlKeyCombination return;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor inserter
				  inputFilter: aBrTextEditor inputFilter;
				  atCursor;
				  crLineEndingWithWhitespace;
				  insert ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> copy [

	^ self new
		  name: 'Copy';
		  description: 'Copies the selection text into the clipboard.';
		  combination: BlKeyCombination primaryC;
		  performBlock: #copySelected;
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> cut [

	^ self new
		  name: 'Cut';
		  description:
			  'Cut selected text and save it to the clipboard ready to paste elsewhere.';
		  combination: BlKeyCombination primaryX;
		  performBlock: #cutSelected;
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> deleteOneLetterAfterCursor [

	^ self new
		  name: 'Forward delete';
		  description:
			  'Discards the character ahead of the cursor''s position, moving all following characters one position "back" towards the freed letterspace.';
		  combination: BlKeyCombination delete;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deleter
				  selected;
				  oneAfterCursorIfOutsideOfSelection;
				  delete ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> deleteOneLetterBeforeCursor [

	^ self new
		  name: 'Delete';
		  description:
			  'Moves the display cursor one position backwards, deletes the character at that position, and shifts back the text after that position by one position.';
		  combination: BlKeyCombination backspace;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deleter
				  selected;
				  oneBeforeCursorIfOutsideOfSelection;
				  surroundings: aBrTextEditor surroundMap;
				  delete ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> deselectAll [

	^ self new
		  name: 'Deselect';
		  description: 'Deselects any currently selected text.';
		  combination: BlKeyCombination escape;
		  performBlock: #selectNone;
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> editableLabelAccept [

	^ self new
		  name: 'Accept';
		  description: 'Accepts changes make to the text.';
		  combination: BlKeyCombination return;
		  performBlock: [ :aBrTextEditor :aBrEditorElement | 
			  aBrEditorElement acceptEdition ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> editableLabelCancel [

	^ self new
		  name: 'Cancel';
		  description:
			  'Cancels changes and brings back the state of the editor.';
		  combination: BlKeyCombination escape;
		  performBlock: [ :aBrTextEditor :aBrEditorElement | 
			  aBrEditorElement cancelEdition ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> editableLabelSwitchToEditor [

	^ self new
		  name: 'Switch to editor';
		  description:
			  'Switches the label into an editor allowing users to edit it.';
		  combination: BlKeyCombination return;
		  performBlock: [ :aBrTextEditor :aBrEditorElement | 
			  aBrEditorElement switchToEditor ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> focusNext [

	^ self new
		  name: 'Focus next';
		  description: 'Gives focus to the next focusable element.';
		  combination: BlKeyCombination arrowRight;
		  performBlock: [ :aTextEditor :aBrEditorElement | 
			  aBrEditorElement
				  nextSiblingSuchThat: [ :eachElement | eachElement isFocusable ]
				  do: [ :anElement | anElement requestFocus ] ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> focusPrevious [

	^ self new
		  name: 'Focus previous';
		  description: 'Gives focus to the previous focusable element.';
		  combination: BlKeyCombination arrowLeft;
		  performBlock: [ :aTextEditor :aBrEditorElement | 
			  aBrEditorElement
				  previousSiblingSuchThat: [ :eachElement | 
					  eachElement isFocusable ]
				  do: [ :anElement | anElement requestFocus ] ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> lineEnding [

	^ self new
		  name: 'Insert line ending';
		  description:
			  'Inserts a platform specific line ending at the cursor location and indents the new line to match the indentation of the previous line.';
		  combination: BlKeyCombination return;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor inserter
				  inputFilter: aBrTextEditor inputFilter;
				  atCursor;
				  lineEndingWithWhitespace;
				  insert ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> loseFocus [

	^ self new
		  name: 'Lose focus';
		  description: 'Loses focus.';
		  combination: BlKeyCombination escape;
		  performBlock: [ :aTextEditor :aBrEditorElement | 
			  aBrEditorElement loseFocus ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> moveCursorDown [

	^ self new
		  name: 'Move cursor down';
		  description:
			  'Moves the cursor one line at a time below the current position and deselects any selected text.';
		  combination: BlKeyCombination arrowDown;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deselecter
				  all;
				  deselect.
			  aBrTextEditor navigator
				  moveDown;
				  withoutResettingDesiredCoordinate;
				  apply ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> moveCursorLeft [

	^ self new
		  name: 'Move cursor left';
		  description:
			  'Moves the cursor one letter at a time to the left from the current position and deselects any selected text.';
		  combination: BlKeyCombination arrowLeft;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deselecter
				  all;
				  deselect.
			  aBrTextEditor navigator
				  moveLeft;
				  apply ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> moveCursorRight [

	^ self new
		  name: 'Move cursor right';
		  description:
			  'Moves the cursor one letter at a time to the right from the current position and deselects any selected text.';
		  combination: BlKeyCombination arrowRight;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deselecter
				  all;
				  deselect.
			  aBrTextEditor navigator
				  moveRight;
				  apply ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> moveCursorToBeginning [

	^ self new
		  name: 'Move beginning';
		  description:
			  'Moves the cursor to the beginning of the current editor and deselects any selected text.';
		  combination: BlKeyCombination builder primary home build;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deselecter
				  all;
				  deselect.
			  aBrTextEditor navigator
				  moveTo: 0;
				  apply ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> moveCursorToEnd [

	^ self new
		  name: 'Move end';
		  description:
			  'Moves the cursor to the end of the current editor and deselects any selected text.';
		  combination: BlKeyCombination builder primary end build;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deselecter
				  all;
				  deselect.
			  aBrTextEditor navigator
				  moveToEnd;
				  apply ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> moveCursorToLineEnd [

	^ self new
		  name: 'Move cursor to the line end';
		  description:
			  'Moves the cursor to the end of the current line and deselects any selected text.';
		  combination: BlKeyCombination end;
		  combinationForMacOS:
			  (BlKeyCombination end or: BlKeyCombination primaryArrowRight);
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deselecter
				  all;
				  deselect.
			  aBrTextEditor navigator
				  moveToLineEnd;
				  apply ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> moveCursorToLineStart [

	^ self new
		  name: 'Move cursor to the line start';
		  description:
			  'Moves the cursor to the start of the current line and deselects any selected text.';
		  combination: BlKeyCombination home;
		  combinationForMacOS:
			  (BlKeyCombination home or: BlKeyCombination primaryArrowLeft);
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deselecter
				  all;
				  deselect.
			  aBrTextEditor navigator
				  moveToLineStart;
				  apply ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> moveCursorToNextWord [

	^ self new
		  name: 'Move cursor to the next word';
		  description:
			  'Moves the cursor to the end of the next (or current) word and deselects any selected text.';
		  combination: BlKeyCombination builder control arrowRight build;
		  combinationForMacOS: BlKeyCombination builder alt arrowRight build;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deselecter
				  all;
				  deselect.
			  aBrTextEditor navigator
				  moveToEndNextWord;
				  apply ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> moveCursorToPreviousWord [

	^ self new
		  name: 'Move cursor to the previous word';
		  description:
			  'Moves the cursor to the start of the previous (or current) word and deselects any selected text.';
		  combination: BlKeyCombination builder control arrowLeft build;
		  combinationForMacOS: BlKeyCombination builder alt arrowLeft build;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deselecter
				  all;
				  deselect.

			  aBrTextEditor navigator
				  moveToStartPreviousWord;
				  apply ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> moveCursorUp [

	^ self new
		  name: 'Move cursor up';
		  description:
			  'Moves the cursor one line at a time above the current position and deselects any selected text.';
		  combination: BlKeyCombination arrowUp;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor deselecter
				  all;
				  deselect.
			  aBrTextEditor navigator
				  moveUp;
				  withoutResettingDesiredCoordinate;
				  apply ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> paste [

	^ self new
		  name: 'Paste';
		  description:
			  'Paste a text from the clipboard at the current cursor position and delete any currently selected text.';
		  combination: BlKeyCombination primaryV;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor paster
				  inputFilter: aBrTextEditor inputFilter;
				  fromClipboard;
				  atCursor;
				  paste ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> redo [

	^ self new
		  name: 'Redo';
		  description: 'Reverses the undo or advances the document to a more recent state.';
		  combination: BlKeyCombination primaryShiftZ;
		  performBlock: #redo;
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> selectAll [

	^ self new
		  name: 'Select all';
		  description: 'Selects all text';
		  combination: BlKeyCombination primaryA;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor selecter
				  all;
				  select ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> selectLetterAfterCursor [

	^ self new
		  name: 'Select letter to the right';
		  description:
			  'Selects one letter at a time to the right from the cursor.';
		  combination: BlKeyCombination shiftArrowRight;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor selecter
				  moveOneToRight;
				  select ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> selectLetterBeforeCursor [

	^ self new
		  name: 'Select letter to the left';
		  description:
			  'Selects one letter at a time to the left from the cursor.';
		  combination: BlKeyCombination shiftArrowLeft;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor selecter
				  moveOneToLeft;
				  select ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> selectLineAboveCursor [

	^ self new
		  name: 'Select line above';
		  description: 'Selects one line at a time above the cursor.';
		  combination: BlKeyCombination shiftArrowUp;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor selecter
				  moveOneUp;
				  select ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> selectLineAfterCursor [
	^ (self new)
		name: 'Select to the end of a line';
		description: 'Extends the selection from the current cursor position to the end of a line.';
		combination: BlKeyCombination shiftEnd;
		combinationForMacOS: (BlKeyCombination primaryShiftArrowRight or: BlKeyCombination shiftEnd);
		performBlock:
				[ :aBrTextEditor | 
					(aBrTextEditor selecter)
						extendToLineEnd;
						select ];
		yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> selectLineBeforeCursor [
	^ (self new)
		name: 'Select to the beginning of a line';
		description: 'Extends the selection from the current cursor position to the beginning of a line.';
		combination: BlKeyCombination shiftHome;
		combinationForMacOS: (BlKeyCombination primaryShiftArrowLeft or: BlKeyCombination shiftHome);
		performBlock:
				[ :aBrTextEditor | 
					(aBrTextEditor selecter)
						extendToLineStart;
						select ];
		yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> selectLineBelowCursor [

	^ self new
		  name: 'Select line below';
		  description: 'Selects one line at a time below the cursor.';
		  combination: BlKeyCombination shiftArrowDown;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor selecter
				  moveOneDown;
				  select ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> selectToBeginning [

	^ self new
		  name: 'Select to the beginning of the editor';
		  description:
			  'Extends the selection from the current cursor position to the beginning of the editor.';
		  combination: BlKeyCombination builder primary shift home build;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor selecter
				  extendToBeginning;
				  select ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> selectToEnd [

	^ self new
		  name: 'Select to the end of the editor';
		  description:
			  'Extends the selection from the current cursor position to the end of the editor.';
		  combination: BlKeyCombination builder primary shift end build;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor selecter
				  extendToEnd;
				  select ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> selectWordAfterCursor [

	^ self new
		  name: 'Select next word';
		  description:
			  'Extends the selection from the current cursor position to the end of the next word.';
		  combination:
			  BlKeyCombination builder shift control arrowRight build;
		  combinationForMacOS:
			  BlKeyCombination builder shift alt arrowRight
				  build;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor selecter
				  extendToNextWordEnd;
				  select ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> selectWordBeforeCursor [

	^ self new
		  name: 'Select previous word';
		  description:
			  'Extends the selection from the current cursor position to the beginning of previous word.';
		  combination:
			  BlKeyCombination builder shift control arrowLeft build;
		  combinationForMacOS:
			  BlKeyCombination builder shift alt arrowLeft build;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor selecter
				  extendToPreviousWordStart;
				  select ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> shiftLeft [

	^ self new
		  name: 'Shift left';
		  description:
			  'Shift text at the cursor or if there is selection, the selected lines, one indetation to the left.';
		  combination: BlKeyCombination builder shift tab build;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor selection isEmpty
				  ifTrue: [ 
					  aBrTextEditor deleter
						  beforeCurrentLineIfIndent;
						  delete ]
				  ifFalse: [ 
					  aBrTextEditor deleter
						  beforeSelectedLinesIfIndent;
						  delete ] ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> shiftRight [

	^ self new
		  name: 'Shift right';
		  description:
			  'Shift text at the cursor or if there is selection, the selected lines, one indetation to the right.';
		  combination: BlKeyCombination tab;
		  performBlock: [ :aBrTextEditor | 
			  aBrTextEditor selection isEmpty
				  ifTrue: [ 
					  aBrTextEditor inserter
						  atCursor;
						  indentation;
						  insert ]
				  ifFalse: [ 
					  aBrTextEditor inserter
						  indentation;
						  beforeSelectedLines;
						  withoutSelectionDelete;
						  insert ] ];
		  yourself
]

{ #category : #'shortcut creation' }
BrEditorShortcut class >> undo [

	^ self new
		  name: 'Undo';
		  description: 'Erases the last change done to the document, reverting it to an older state.';
		  combination: BlKeyCombination primaryZ;
		  performBlock: #undo;
		  yourself
]

{ #category : #accessing }
BrEditorShortcut >> combinationForMacOS [
	^combinationForMacOS ifNil: [combination]
]

{ #category : #accessing }
BrEditorShortcut >> combinationForMacOS: aKeyCombination [
	combinationForMacOS := aKeyCombination
]

{ #category : #accessing }
BrEditorShortcut >> combinationForUnix [
	^combinationForUnix ifNil: [combination]
]

{ #category : #accessing }
BrEditorShortcut >> combinationForUnix: aKeyCombination [
	combinationForUnix := aKeyCombination
]

{ #category : #accessing }
BrEditorShortcut >> combinationForWindows [
	^combinationForWindows ifNil: [combination]
]

{ #category : #accessing }
BrEditorShortcut >> combinationForWindows: aKeyCombination [
	combinationForWindows := aKeyCombination
]

{ #category : #accessing }
BrEditorShortcut >> description [
	^description
]

{ #category : #accessing }
BrEditorShortcut >> description: aString [
	description := aString
]

{ #category : #accessing }
BrEditorShortcut >> name [
	^name
]

{ #category : #accessing }
BrEditorShortcut >> name: aString [
	name := aString
]

{ #category : #evaluation }
BrEditorShortcut >> performBlock: aBlock [
	performBlock := aBlock
	
]

{ #category : #evaluation }
BrEditorShortcut >> performDueTo: aShortcutEvent [

	"we consume shortcut event before evaluating a custom action in order to give subclasses a chance to not consume the event"
	aShortcutEvent consumed: true.

	self
		performOnEditor: aShortcutEvent currentTarget editor
		element: aShortcutEvent currentTarget
		dueTo: aShortcutEvent
]

{ #category : #evaluation }
BrEditorShortcut >> performOnEditor: aBrTextEditor element: aBrEditorElement dueTo: aShortcutEvent [
	performBlock cull: aBrTextEditor cull: aBrEditorElement cull: aShortcutEvent
]
