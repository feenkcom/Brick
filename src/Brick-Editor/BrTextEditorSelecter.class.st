"
When in ""cursor update mode"" I place cursors at the end of each selection
"
Class {
	#name : #BrTextEditorSelecter,
	#superclass : #BrTextEditorOperator,
	#instVars : [
		'selection',
		'shouldUpdateCursor',
		'shouldDeselectExisting',
		'commands'
	],
	#category : #'Brick-Editor-Model - Operators'
}

{ #category : #'api - configuration' }
BrTextEditorSelecter >> all [
	"Select the whole text"
	self assertUIProcess.
	
	self
		from: 0
		to: self text size
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> all: aCompositeSelection [
	aCompositeSelection do: [ :eachMonotoneSelection |
		self from: eachMonotoneSelection from to: eachMonotoneSelection to ]
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> extendToBeginning [
	"Extend selection to the start of the editor"
	|  theCommands |
	self assertUIProcess.

	theCommands := self cursors collect: [ :aCursor |
		| aDelta |
		aDelta := aCursor position.
		(self
			privateExtendSelectionLeftAt: aCursor position
			by: aDelta)
				toMoveCursor: aCursor
				by: aDelta negated ].

	commands addAll: theCommands
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> extendToEnd [

	"Extend selection to the end of the editor"

	| theCommands |
	self assertUIProcess.

	theCommands := self cursors collect: [ :aCursor | 
		               | aDelta |
		               aDelta := self text size - aCursor position.
		               (self
			                privateExtendSelectionRightAt: aCursor position
			                by: aDelta) toMoveCursor: aCursor by: aDelta ].

	commands addAll: theCommands
]

{ #category : #accessing }
BrTextEditorSelecter >> extendToIndex: anIndex [
	| cursorPosition |
	self cursors isEmpty ifTrue: [ ^ self ].
	cursorPosition := self cursors first position.
	anIndex > cursorPosition
		ifTrue: [ self from: cursorPosition to: anIndex ]
		ifFalse: [ self from: anIndex to: cursorPosition ]
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> extendToLineEnd [
	"Extend selection to the end of the line"
	|  theCommands |
	self assertUIProcess.

	theCommands := self cursors collect: [ :aCursor |
		| aDelta |
		aDelta := (self findTextIndexAtLineEnd: aCursor) - aCursor position.
		(self
			privateExtendSelectionRightAt: aCursor position
			by: aDelta) toMoveCursor: aCursor by: aDelta ].
	
	commands addAll: theCommands
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> extendToLineStart [
	"Extend selection to the start of the line"
	|  theCommands |
	self assertUIProcess.

	theCommands := self cursors collect: [ :aCursor |
		| aDelta |
		aDelta := aCursor position - (self findTextIndexAtLineStart: aCursor).
		(self
			privateExtendSelectionLeftAt: aCursor position
			by: aDelta)
				toMoveCursor: aCursor
				by: aDelta negated ].

	commands addAll: theCommands
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> extendToNextWordEnd [
	"Extend selection to the end of the next word"
	|  theCommands |
	self assertUIProcess.

	theCommands := self cursors collect: [ :aCursor |
		| aDelta |
		
		aDelta := (self findWordEndAfter: aCursor position+1) - aCursor position.
		(self
			privateExtendSelectionRightAt: aCursor position
			by: aDelta)
				toMoveCursor: aCursor
				by: aDelta ].
	
	commands addAll: theCommands
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> extendToPreviousWordStart [
	"Extend selection to start of the previous word"
	|  theCommands |
	self assertUIProcess.

	theCommands := self cursors collect: [ :aCursor |
		| aDelta |
		
		aDelta := aCursor position - (self findWordStartBefore: aCursor position).
		(self
			privateExtendSelectionLeftAt: aCursor position
			by: aDelta)
				toMoveCursor: aCursor
				by: aDelta negated ].
	
	commands addAll: theCommands
]

{ #category : #private }
BrTextEditorSelecter >> findExistingSelectionEndAfter: aTextIndex within: aTextInterval [
	| anEndIndex |
	
	anEndIndex := aTextIndex.
	self selection do: [ :eachMonotoneSelection |
		(eachMonotoneSelection to between: aTextInterval first and: aTextInterval last)
			ifTrue: [ anEndIndex := anEndIndex max: eachMonotoneSelection to ].
	
		(eachMonotoneSelection to > aTextInterval last
			and: [ eachMonotoneSelection from <= aTextInterval last ])
				ifTrue: [ anEndIndex := aTextInterval last ] ].

	^ anEndIndex
]

{ #category : #private }
BrTextEditorSelecter >> findExistingSelectionStartBefore: aTextIndex within: aTextInterval [
	| aStartIndex |
	
	aStartIndex := aTextIndex.
	self selection do: [ :eachMonotoneSelection |
		(eachMonotoneSelection from between: aTextInterval first and: aTextInterval last)
			ifTrue: [ aStartIndex := aStartIndex min: eachMonotoneSelection from ].

		(eachMonotoneSelection from < aTextInterval first
			and: [ eachMonotoneSelection to >= aTextInterval first ])
				ifTrue: [ aStartIndex := aTextInterval first ] ].

	^ aStartIndex
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> from: aFromIndex to: aToIndex [
	| aMinIndex aMaxIndex |
	self assertUIProcess.

	aFromIndex = aToIndex
		ifTrue: [ ^ self ].
	
	aMinIndex := aFromIndex min: aToIndex.
	aMaxIndex := aFromIndex max: aToIndex.
	
	commands add: (BrExtendSelectionCommand new 
		editor: editor;
		toSelect: { BlSelection from: aMinIndex to: aMaxIndex };
		toAddCursor: aToIndex;
		toRemoveCursors: self cursors allCursors)
]

{ #category : #initialization }
BrTextEditorSelecter >> initialize [
	super initialize.

	selection := BlCompositeSelection new.
	shouldUpdateCursor := true.
	shouldDeselectExisting := false.
	commands := OrderedCollection new
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> moveOneDown [
	"Select and move a cursor one line down"
	| theCommands theNewCursorPositions theCursorsOnTheLeft theCursorsOnTheRight theCursorsOutside |
	self assertUIProcess.

	theCommands := OrderedCollection new.

	theNewCursorPositions := (self cursors collect: [ :aCursor |
		aCursor -> (self
			findTextIndexBelowCursor: aCursor
			ifAbsent: [
				(self isCursorOnTheLastLine: aCursor)
					ifTrue: [ self text size ]
					ifFalse: [ aCursor position ] ]) ]) as: OrderedIdentityDictionary.

	theCursorsOnTheLeft := self cursors
		select: [ :aCursor | self selection anySatisfy: [ :aSelection | aCursor position = aSelection from ] ].

	theCursorsOnTheRight := self cursors
		select: [ :aCursor | self selection anySatisfy: [ :aSelection | aCursor position = aSelection to ] ].

	theCursorsOutside := self cursors
		select: [ :aCursor | (self selection anySatisfy: [ :aSelection | aCursor position between: aSelection from and: aSelection to ]) not ].

	theCursorsOnTheLeft do: [ :aCursor |
		| aDelta |
		aDelta := (theNewCursorPositions at: aCursor) - aCursor position.
		theCommands add: (BrExtendSelectionCommand new 
			editor: editor;
			toDeselect: { BlSelection from: aCursor position to: (theNewCursorPositions at: aCursor) };
			toMoveCursor: aCursor by: aDelta) ].

	theCursorsOnTheRight, theCursorsOutside do: [ :aCursor | 
		| aDelta |
		aDelta := ((theNewCursorPositions at: aCursor) min: self text size) - aCursor position.
		theCommands add: (BrExtendSelectionCommand new 
			editor: editor;
			toSelect: { BlSelection from: aCursor position to: ((theNewCursorPositions at: aCursor) min: self text size) };
			toMoveCursor: aCursor by: aDelta;
			withoutResettingDesiredCoordinate) ].
		
	commands addAll: theCommands.
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> moveOneToLeft [
	"Select and move a cursor one character to the left"

	| theCommands |
	self assertUIProcess.
	theCommands := self cursors
		collect:
			[ :aCursor | 
			| dist |
			dist := (self hasString: String crlf beforeCursor: aCursor) ifTrue: [ 2 ] ifFalse: [ 1 ].
			(self privateExtendSelectionLeftAt: aCursor position by: dist) toMoveCursor: aCursor by: dist negated ].
	commands addAll: theCommands
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> moveOneToRight [
	"Select and move a cursor one character to the right"

	| theCommands |
	self assertUIProcess.
	theCommands := self cursors
		collect:
			[ :aCursor | 
			| dist |
			dist := (self hasString: String crlf afterCursor: aCursor) ifTrue: [ 2 ] ifFalse: [ 1 ].
			(self privateExtendSelectionRightAt: aCursor position by: dist) toMoveCursor: aCursor by: dist ].
	commands addAll: theCommands
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> moveOneUp [
	"Select and move a cursor one line up"
	| theNewCursorPositions theCursorsOnTheLeft theCursorsOnTheRight theCursorsOutside theCommands |
	self assertUIProcess.
	
	theCommands := OrderedCollection new.
	theNewCursorPositions := (self cursors collect: [ :aCursor |
		aCursor -> (self
			findTextIndexAboveCursor: aCursor
			ifAbsent: [
				(self isCursorOnTheFirstLine: aCursor)
					ifTrue: [ 0 ]
					ifFalse: [ aCursor position ] ]) ]) as: OrderedIdentityDictionary.

	theCursorsOnTheLeft := self cursors
		select: [ :aCursor | self selection anySatisfy: [ :aSelection | aCursor position = aSelection from ] ].
		
	theCursorsOnTheRight := self cursors
		select: [ :aCursor | self selection anySatisfy: [ :aSelection | aCursor position = aSelection to ] ].
	
	theCursorsOutside := self cursors
		select: [ :aCursor | (self selection anySatisfy: [ :aSelection | aCursor position between: aSelection from and: aSelection to ]) not ].

	"the cursor is on the right side of the selection, we should deselect from the new potential position to its current location"
	theCursorsOnTheRight do: [ :aCursor |
		| aDelta |
		aDelta := aCursor position - (theNewCursorPositions at: aCursor).
		theCommands add: (BrExtendSelectionCommand new 
			editor: editor;
			toDeselect: { BlSelection from: (theNewCursorPositions at: aCursor) to: aCursor position };
			toMoveCursor: aCursor by: aDelta negated) ].
	
	"the cursor is on the left side of the selection or is not inside any selection, we should extend it to the new potential location"
	theCursorsOnTheLeft, theCursorsOutside do: [ :aCursor | 
		| aDelta |
		aDelta := aCursor position - (theNewCursorPositions at: aCursor).
		theCommands add: (BrExtendSelectionCommand new 
			editor: editor;
			toSelect: { BlSelection from: (theNewCursorPositions at: aCursor) to: aCursor position };
			toMoveCursor: aCursor by: aDelta negated;
			withoutResettingDesiredCoordinate) ].

	commands addAll: theCommands.
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> overwrite [
	"Deselect any selections if they exist and overwrite with the new selection"
	
	shouldDeselectExisting := true
]

{ #category : #private }
BrTextEditorSelecter >> privateDeselectExisting: aSelection [
	| aDeselecter |
	
	aSelection isEmpty
		ifTrue: [ ^ self ].

	aDeselecter := self editor deselecter.	
	aSelection do: [ :eachMonotoneSelection | aDeselecter from: eachMonotoneSelection from to: eachMonotoneSelection to ].
	aDeselecter deselect
]

{ #category : #private }
BrTextEditorSelecter >> privateExtendSelectionLeftAt: aTextPosition by: anAmount [
	| hasSelectionAfter toSelect toDeselect aNewSelectionStart |

	self
		assert: [ aTextPosition >= 0 ]
		description: [ 'Text position must not be negative' ].

	self
		assert: [ aTextPosition <= self text size ]
		description: [ 'Text position must not exceed text size' ].

	self
		assert: [ anAmount >= 0 ]
		description: [ 'Amount must not be negative' ].

	toSelect := OrderedCollection new.
	toDeselect := OrderedCollection new.

	hasSelectionAfter := self selection
		anySatisfy: [ :eachMonotoneSelection |
			(eachMonotoneSelection from <= aTextPosition)
				and: [ eachMonotoneSelection to > aTextPosition ] ].

	aNewSelectionStart := (aTextPosition - anAmount) max: 0.
	self
		assert: [ aNewSelectionStart >= 0 ]
		description: [ 'Selection start must not be less than 0' ].

	hasSelectionAfter
		ifTrue: [ toSelect add: (BlSelection from: aNewSelectionStart to: aTextPosition) ]
		ifFalse: [
			| aSelectionStart aSelectionEnd |
			aSelectionEnd := self
				findExistingSelectionStartBefore: aTextPosition
				within: (aNewSelectionStart to: aTextPosition).
			
			aSelectionEnd = aTextPosition
				ifFalse: [ toDeselect add: (BlSelection from: aSelectionEnd to: aTextPosition) ].
				
			aSelectionStart := aNewSelectionStart.
			
			aSelectionStart < aSelectionEnd
				ifTrue: [ toSelect add: (BlSelection from: aSelectionStart to: aSelectionEnd) ] ].

	^ BrExtendSelectionCommand new 
		editor: editor;
		toSelect: toSelect;
		toDeselect: toDeselect
]

{ #category : #private }
BrTextEditorSelecter >> privateExtendSelectionRightAt: aTextPosition by: anAmount [
	| hasSelectionBefore toSelect toDeselect aNewSelectionEnd |

	self
		assert: [ aTextPosition >= 0 ]
		description: [ 'Text position must not be negative' ].
		
	self
		assert: [ aTextPosition <= self text size ]
		description: [ 'Text position must not exceed text size' ].
		
	self
		assert: [ anAmount >= 0 ]
		description: [ 'Amount must not be negative' ].

	toSelect := OrderedCollection new.
	toDeselect := OrderedCollection new.

	hasSelectionBefore := self selection
		anySatisfy: [ :eachMonotoneSelection |
			(eachMonotoneSelection from < aTextPosition)
				and: [ eachMonotoneSelection to >= aTextPosition ] ].

	aNewSelectionEnd := (aTextPosition + anAmount) min: self text size.
	self
		assert: [ aNewSelectionEnd <= self text size ]
		description: [ 'Selection end must not exceed text size' ].

	hasSelectionBefore
		ifTrue: [ toSelect add: (BlSelection from: aTextPosition to: aNewSelectionEnd) ]
		ifFalse: [
			| aSelectionStart aSelectionEnd |
			aSelectionStart := self
				findExistingSelectionEndAfter: aTextPosition
				within: (aTextPosition to: aNewSelectionEnd).
			
			aSelectionStart = aTextPosition
				ifFalse: [ toDeselect add: (BlSelection from: aTextPosition to: aSelectionStart) ].
				
			aSelectionEnd := aNewSelectionEnd.
			
			aSelectionStart = aSelectionEnd
				ifFalse: [ toSelect add: (BlSelection from: aSelectionStart to: aSelectionEnd) ] ].

	^ BrExtendSelectionCommand new 
		editor: editor;
		toSelect: toSelect;
		toDeselect: toDeselect
]

{ #category : #private }
BrTextEditorSelecter >> privateFrom: aFromIndex to: aToIndex [
	self assertUIProcess.

	aFromIndex = aToIndex
		ifTrue: [ ^ self ].

	selection select: aFromIndex to: aToIndex
]

{ #category : #private }
BrTextEditorSelecter >> privatePerformSelectAndDeselectCommands: theCommands [
	| aDeselecter  |

	aDeselecter := self editor deselecter.

	theCommands do: [ :aCommand |
		aCommand toDeselectDo: [ :eachSelectionToDeselect |
			aDeselecter
				from: eachSelectionToDeselect from
				to: eachSelectionToDeselect to ] ].
	aDeselecter deselect.

	theCommands do: [ :aCommand |
		aCommand toSelectDo: [ :eachSelectionToSelect |
			self
				privateFrom: eachSelectionToSelect from
				to: eachSelectionToSelect to ] ].
	
	shouldUpdateCursor
		ifFalse: [ ^ self ].
	
	theCommands do: [ :aCommand |
		| aNavigator |
		aNavigator := self editor navigator.
		aNavigator dueTo: self.
		
		aCommand shouldResetDesiredCoordinate
			ifTrue: [ aNavigator withResettingDesiredCoordinate ]
			ifFalse: [ aNavigator withoutResettingDesiredCoordinate ].
		
		aCommand toMoveCursorDo: [ :eachCursor :anAmount |
			aNavigator move: eachCursor by: anAmount ].
		aCommand toAddCursorDo: [ :aCursorPosition |
			aNavigator addAt: aCursorPosition ].
		aCommand toRemoveCursorsDo: [ :aCursor |
			aNavigator remove: aCursor ].
		aNavigator apply ].
]

{ #category : #private }
BrTextEditorSelecter >> privateSelect: aFromTextIndex to: aToTextIndex [
	"Select text within an interval defined by provided from and to indices without any other side effects.
	Note:
		- I don't change cursor position.
		- I request segments update"

	| aCommand from to |
	aFromTextIndex < aToTextIndex ifFalse: [ ^ self ].
	from := aFromTextIndex beBetween: 0 and: self text size.
	to := aToTextIndex beBetween: 0 and: self text size.

	aCommand := BrTextEditorSelectCommand new
			fromIndex: from;
			toIndex: to.
	self editor enqueueCommand: aCommand
]

{ #category : #'api - processing' }
BrTextEditorSelecter >> select [
	| toBeSelected |
	self assertUIProcess.

	self privatePerformSelectAndDeselectCommands: commands.
	commands removeAll.

	selection isEmpty
		ifTrue: [ ^ self ].

	shouldDeselectExisting
		ifTrue: [
			| toBeDeselected |
			
			toBeDeselected := self selection copy.
			selection do: [ :aMonotoneSelection | toBeDeselected deselect: aMonotoneSelection from to: aMonotoneSelection to ].			
			self privateDeselectExisting: toBeDeselected ].
	
	toBeSelected := selection copy.
	self selection do: [ :aMonotoneSelection | toBeSelected deselect: aMonotoneSelection from to: aMonotoneSelection to ].

	toBeSelected do: [ :aMonotoneSelection |
		(aMonotoneSelection interval size > 1)
			ifTrue: [ self privateSelect: aMonotoneSelection from to: aMonotoneSelection to ] ]
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> selectionUnitAt: aTextIndex [
	"Select a word or a whitespace or delimiter pair at a given text index"

	| aUnitInterval |
	self assertUIProcess.
	(self text isEmpty or: [aTextIndex > self text size]) ifTrue: [ ^ self ].

	aUnitInterval := self findDelimitedUnitAt: aTextIndex.
	aUnitInterval isEmpty
		ifTrue: [ aUnitInterval := self
					findWordAt: aTextIndex
					withClassifier: editor doubleClickWordClassifier ].
	self from: aUnitInterval first to: aUnitInterval last
]

{ #category : #'api - configuration' }
BrTextEditorSelecter >> withoutCursorUpdate [
	shouldUpdateCursor := false
]
