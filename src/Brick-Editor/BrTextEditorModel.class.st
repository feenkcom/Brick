"
! The Moldable Editor

I edit text and provide high level abstractions of essential text editor functionality such as selection, cursor, text insertions and deletions.

I make use of ${class:BrTextAdornmentAttribute}$ to augment text with visual elements. 

I subclass infinite data source in order to be able to smoothly display practically infinite amounts of text.
"
Class {
	#name : #BrTextEditorModel,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'model',
		'mode',
		'text',
		'selection',
		'selectionRecorder',
		'segmentBuilder',
		'segmentCollector',
		'styler',
		'stylerStrategy',
		'stylerEventHandler',
		'cursors',
		'attachedElements',
		'history',
		'filter',
		'shortcuts',
		'isFocused',
		'shouldStyleWhenTextModified'
	],
	#category : #'Brick-Editor-Model'
}

{ #category : #'api - shortcuts' }
BrTextEditorModel >> addEditorShortcut: aBrTextEditorShortcut [
	self editorShortcuts
		add: aBrTextEditorShortcut
		ifAdded: [ :aNewEditorShortcut | self onShortcutAdded: aNewEditorShortcut ]
		ifReplaced: [ :aPreviousEditorShortcut | self onShortcutRemoved: aPreviousEditorShortcut ]
]

{ #category : #'api - shortcuts' }
BrTextEditorModel >> addEditorShortcuts: aCollectionOfBrTextEditorShortcut [
	aCollectionOfBrTextEditorShortcut
		do: [ :eachShortcut | self addEditorShortcut: eachShortcut ]
]

{ #category : #asserting }
BrTextEditorModel >> assertUIProcess [
	"I check if the current process is a UI process of all attached editor elements"

	attachedElements
		do: [ :eachElement | 
			eachElement isAttachedToSceneGraph
				ifTrue: [ eachElement space host
						uiProcessDo: [ :aProcess | 
							aProcess == Processor activeProcess
								ifFalse: [ BrEditorWrongThreadError
										signal: ('I am running from a non-UI process ({1}) expected ({2})'
												format: {Processor activeProcess asString.
														aProcess asString}) ] ] ] ]
]

{ #category : #'api - mode' }
BrTextEditorModel >> beEditable [
	self editorMode: BrTextEditorEditableMode new
]

{ #category : #'api - mode' }
BrTextEditorModel >> beEditableCode [
	self editorMode: BrTextEditorEditableCodeMode new
]

{ #category : #accessing }
BrTextEditorModel >> beLineBased [
	segmentBuilder := BrTextEditorLineSegmentBuilder new
			splitter: (BrTextEditorLineSplitter new
					segmentClass: BrTextEditorLineSegment;
					yourself)
]

{ #category : #accessing }
BrTextEditorModel >> beParagraphBased [
	segmentBuilder := BrTextEditorLineSegmentBuilder new
			splitter: (BrTextEditorLineSplitter new
					segmentClass: BrTextEditorParagraphSegment;
					yourself)
]

{ #category : #'api - mode' }
BrTextEditorModel >> beReadOnlyWithSelection [
	self editorMode: BrTextEditorReadonlyWithSelectionMode new
]

{ #category : #'api - mode' }
BrTextEditorModel >> beReadOnlyWithoutSelection [
	self editorMode: BrTextEditorReadonlyWithoutSelectionMode new
]

{ #category : #'private - selection' }
BrTextEditorModel >> commitSelection [
	self selectionRecorder commit: self
]

{ #category : #'text - copy/paste' }
BrTextEditorModel >> copy: aFromIndex to: aToIndex [
	"Copy text within given text interval to the clipboard"
	
	Clipboard clipboardText: (self text from: aFromIndex + 1 to: aToIndex) asString
]

{ #category : #'text - copy/paste' }
BrTextEditorModel >> copySelected [
	"Copy currently selected text to the clipboard"
	
	self selection isEmpty
		ifTrue: [ ^ self ].
		
	self
		copy: self selection from
		to: self selection to
]

{ #category : #accessing }
BrTextEditorModel >> cursor [
	<return: #BrTextEditorCursor>

	self
		deprecated: 'Use #cursors instead.'
		transformWith: '`@receiver cursor' -> '`@receiver cursors'.

	^ cursors
]

{ #category : #accessing }
BrTextEditorModel >> cursors [
	<return: #BrTextEditorCursor>

	^ cursors
]

{ #category : #'text - copy/paste' }
BrTextEditorModel >> cut: aFromIndex to: aToIndex [
	"Copy text within given text interval to the clipboard and remove it from the editor.
	Note: I update the cursor location and selection"

	self copy: aFromIndex to: aToIndex.

	self selectNone.
	self moveCursorTo: aFromIndex.
	self delete: aFromIndex to: aToIndex
]

{ #category : #'text - copy/paste' }
BrTextEditorModel >> cutSelected [
	"Copy currently selected text to the clipboard and remove it from the editor.
	Note: I update the cursor location and selection"
	
	self selection isEmpty
		ifTrue: [ ^ self ].
	
	self
		cut: self selection from
		to: self selection to
]

{ #category : #initialization }
BrTextEditorModel >> defaultStylerStrategy [
	^ BrTextStylerAsyncStrategy new
]

{ #category : #'private - text' }
BrTextEditorModel >> delete: aFromTextIndex to: aToTextIndex [
	"I delete a piece of text within a given text interval without cursor or selection update.
	Note: cursor or selection location after deletion may be invalid!"

	self deleter
		from: aFromTextIndex to: aToTextIndex;
		withoutCursorUpdate;
		withoutSelectionUpdate;
		delete
]

{ #category : #'api - modification' }
BrTextEditorModel >> deleter [
	^ BrTextEditorDeleter new editor: self
]

{ #category : #'private - text' }
BrTextEditorModel >> deselect: aFromTextIndex to: aToTextIndex [
	"Deselect text within an interval defined by provided from and to indices without any other side effects.
	Note:
		- I don't change cursor position.
		- I request segments update"

	self deselecter
		from: aFromTextIndex to: aToTextIndex;
		deselect
]

{ #category : #'api - modification' }
BrTextEditorModel >> deselecter [
	<return: #BrTextEditorDeselecter>

	^ BrTextEditorDeselecter new editor: self
]

{ #category : #'text - styling' }
BrTextEditorModel >> disableStyleTextWhenModifiedDuring: aBlock [
	| aPreviousShouldStyleWhenTextModified |
	
	aPreviousShouldStyleWhenTextModified := shouldStyleWhenTextModified.
	shouldStyleWhenTextModified := false.
	aBlock ensure: [ shouldStyleWhenTextModified := aPreviousShouldStyleWhenTextModified ]
]

{ #category : #'api - mode' }
BrTextEditorModel >> editorMode [
	<return: #BrTextEditorMode>

	^ mode
]

{ #category : #'api - mode' }
BrTextEditorModel >> editorMode: aBrTextEditorMode [
	self
		assert: [ aBrTextEditorMode isNotNil ]
		description: [ 'Mode must not be nil' ].

	mode = aBrTextEditorMode
		ifTrue: [ ^ self ].

	"Uninstall existing mode"
	mode uninstallFromEditor: self.
	attachedElements do: [ :eachElement | mode uninstallFromEditorElement: eachElement ].

	mode := aBrTextEditorMode.
	mode installOnEditor: self.
	attachedElements do: [ :eachElement | mode installOnEditorElement: eachElement ].
	
	self notifyChanged
]

{ #category : #'api - shortcuts' }
BrTextEditorModel >> editorShortcuts [
	<return: #BrTextEditorShortcuts>

	^ shortcuts
]

{ #category : #'text - styling' }
BrTextEditorModel >> enableStyleTextWhenModified [
	shouldStyleWhenTextModified := true
]

{ #category : #'commands - processing' }
BrTextEditorModel >> enqueueCommand: aBrTextEditorCommand [
	(BrTextEditorCommandSignal textEditor: self)
		command: aBrTextEditorCommand;
		emit.

	aBrTextEditorCommand executeOn: self
]

{ #category : #'commands - processing' }
BrTextEditorModel >> enqueueHolderCommand: aBrTextEditorHolderCommand interval: aTextInterval [
	(BrTextEditorHolderCommandSignal textEditor: self)
		command: aBrTextEditorHolderCommand;
		interval: aTextInterval;
		emit.

	self
		notifyItems: aTextInterval
		event: aBrTextEditorHolderCommand
]

{ #category : #accessing }
BrTextEditorModel >> gtStringFor: aView [
	<gtView>
	^ (self text 
		gtStringFor: aView)
		priority: 5
]

{ #category : #'text - selection' }
BrTextEditorModel >> hasCursors [
	"Return true of there is at least one cursor, false otherwise"
	<return: #Boolean>
	
	^ self cursors isNotEmpty
]

{ #category : #'text - selection' }
BrTextEditorModel >> hasSelection [
	"Return true of there is at least one selected character, false otherwise"
	<return: #Boolean>
	
	^ self selection isNotEmpty
]

{ #category : #accessing }
BrTextEditorModel >> history [
	<return: #BrTextEditorHistory>
	
	^ history
]

{ #category : #accessing }
BrTextEditorModel >> history: aBrTextEditorHistory [
	history := aBrTextEditorHistory
]

{ #category : #initialization }
BrTextEditorModel >> initialize [
	super initialize.

	mode := BrTextEditorNullMode new.

	attachedElements := Set new.

	filter := BrTextEditorNoInputFilter new.
	cursors := BrTextEditorMultipleCursor new.
	selection := BlCompositeSelection new.
	selectionRecorder := BrTextEditorSelectionOverwriteRecorder new.

	text := '' asRopedText.
	self initializeText: text.

	segmentCollector := BrTextEditorSegmentCollector new.
	segmentCollector editor: self.
	segmentCollector text: text.
	segmentBuilder := BrTextEditorLineSegmentBuilder new.

	styler := BlTextNullStyler new.
	stylerEventHandler := BlEventHandler
			on: BrTextStyledEvent
			do: [ :anEvent | self onTextStyled: anEvent ].
	self addEventHandler: stylerEventHandler.
	self useDefaultStylerStrategy.

	shortcuts := BrTextEditorShortcuts new.
	history := BrTextEditorHistory new.

	isFocused := false.
	shouldStyleWhenTextModified := true.

	self beEditable.
	"self beParagraphBased"
]

{ #category : #initialization }
BrTextEditorModel >> initializeText: aBrText [
	aBrText when: BlTextStringsInserted send: #onStringsInserted: to: self.
	aBrText when: BlTextsDeleted send: #onTextsDeleted: to: self.
	aBrText when: BlTextAttributeAdded send: #onTextAttributeAdded: to: self.
	aBrText when: BlTextAttributesRemoved send: #onTextAttributesRemoved: to: self.
]

{ #category : #'api - filter' }
BrTextEditorModel >> inputFilter [
	<return: #BrTextEditorInputFilter>

	^ filter
]

{ #category : #'api - filter' }
BrTextEditorModel >> inputFilter: aBrTextEditorInputFilter [
	filter := aBrTextEditorInputFilter
]

{ #category : #'private - text' }
BrTextEditorModel >> insertString: aString at: aTextIndex [

	self inserter
		at: aTextIndex;
		string: aString;
		withoutCursorUpdate;
		withoutSelectionUpdate;
		withoutSelectionDelete;
		insert
]

{ #category : #'api - modification' }
BrTextEditorModel >> inserter [
	^ BrTextEditorInserter new editor: self
]

{ #category : #accessing }
BrTextEditorModel >> isFocused [
	<return: #Boolean>

	^ isFocused
]

{ #category : #accessing }
BrTextEditorModel >> itemCount [
	^ segmentCollector computedSegmentsCount
]

{ #category : #accessing }
BrTextEditorModel >> itemIdAt: aPosition [
	^ (segmentCollector segmentAt: aPosition) index
]

{ #category : #accessing }
BrTextEditorModel >> itemTypeAt: aPosition [
	"Return segment type at a given position"
	<return: #BrEditorSegmentType>
	
	^ (segmentCollector segmentAt: aPosition) segmentType
]

{ #category : #accessing }
BrTextEditorModel >> model [
	^ model
]

{ #category : #accessing }
BrTextEditorModel >> model: anObject [
	model := anObject
]

{ #category : #'text - cursor' }
BrTextEditorModel >> moveCursorTo: aTextIndex [
	"Moves cursor to a given position without any further action such as cancelling selection"
	<event: #BrTextEditorCursorMovedEvent>

	self navigator
		moveTo: aTextIndex;
		apply
]

{ #category : #'api - modification' }
BrTextEditorModel >> navigator [
	^ BrTextEditorNavigator new editor: self
]

{ #category : #'commands - creation' }
BrTextEditorModel >> newFocusChangedCommand [
	^ BrTextEditorFocusChangedCommand new
]

{ #category : #'commands - creation' }
BrTextEditorModel >> newInvalidateCommand [
	^ BrTextEditorInvalidateCommand new
]

{ #category : #'commands - creation' }
BrTextEditorModel >> newSelectCommand [
	^ BrTextEditorSelectCommand new
]

{ #category : #'commands - creation' }
BrTextEditorModel >> newSelectionUpdateCommand [
	^ BrTextEditorSelectionUpdateCommand new
]

{ #category : #'commands - creation' }
BrTextEditorModel >> newUpdateCommand [
	^ BrTextEditorUpdateCommand new
]

{ #category : #'private - cursor' }
BrTextEditorModel >> notifyAttributesWithinCursor: aCollectionOfAttributes [

	"I select and notify those attributes in the given collection that are within any of the cursors"
	| theEventHandlingAttributes anEvent aCurrentText aCurrentTextSize |
	self isFocused ifFalse: [ ^ self ].

	anEvent := BrTextCursorAttributeEnterEvent new.

	theEventHandlingAttributes := (aCollectionOfAttributes select: [ 
		                               :eachAttribute | 
		                               eachAttribute isEventHandler ]) asSet.

	aCurrentText := self text.
	aCurrentTextSize := aCurrentText size.
		                               
	self cursors do: [ :eachCursor | 
		| atts |
		atts := aCurrentText attributesAt: (eachCursor position min: aCurrentTextSize).
		atts do: [ :eachAttribute | 
			(theEventHandlingAttributes includes: eachAttribute) ifTrue: [ 
				(eachAttribute wantsEvent: anEvent in: self) ifTrue: [ 
					eachAttribute handleEvent: anEvent in: self on: nil ] ] ] ]
]

{ #category : #'event firing' }
BrTextEditorModel >> notifyDeletedFrom: aFromIndex to: aToIndex [
	self dispatchEvent: (BrTextEditorDeletedEvent new
		editor: self;
		fromIndex: aFromIndex;
		toIndex: aToIndex)
]

{ #category : #'event firing' }
BrTextEditorModel >> notifyInserted: aText at: aTextIndex [
	self dispatchEvent: (BrTextEditorInsertedEvent text: aText at: aTextIndex)
]

{ #category : #'event firing' }
BrTextEditorModel >> notifyInteractionAdded: anInteraction [
	self dispatchEvent: (BrTextEditorInteractionAddedEvent new interaction: anInteraction)
]

{ #category : #'event firing' }
BrTextEditorModel >> notifyInteractionRemoved: anInteraction [
	self dispatchEvent: (BrTextEditorInteractionRemovedEvent new interaction: anInteraction)
]

{ #category : #'event firing' }
BrTextEditorModel >> notifyModified: aText [
	self dispatchEvent: (BrTextEditorModifiedEvent new text: aText)
]

{ #category : #'event firing' }
BrTextEditorModel >> notifySelectionChanged: aSelection [
	self dispatchEvent: (BrTextEditorSelectionChangedEvent new selection: aSelection)
]

{ #category : #'event firing' }
BrTextEditorModel >> notifyTextReplaced: aText [
	self dispatchEvent: (BrTextEditorTextReplacedEvent new text: aText)
]

{ #category : #'event firing' }
BrTextEditorModel >> notifyTextStyled: aText [
	self dispatchEvent: (BrTextEditorTextStyledEvent new styledText: aText)
]

{ #category : #hooks }
BrTextEditorModel >> onAttached: anEditorElement [
	super onAttached: anEditorElement.

	attachedElements := attachedElements copyWith: anEditorElement.

 	mode installOnEditorElement: anEditorElement.
	shortcuts do: [ :eachInteraction | self onInteractionAdded: eachInteraction to: anEditorElement ].

	anEditorElement when: BlMouseUpEvent do: [ :anEvent | anEvent consumed: true ].
	anEditorElement when: BlClickEvent do: [ :anEvent | anEvent consumed: true ].
	anEditorElement when: BlFocusEvent do: [ self onGotFocus ].
	anEditorElement when: BlBlurEvent do: [ self onLostFocus ].

	self notifyChanged
]

{ #category : #'instance creation' }
BrTextEditorModel >> onBindHolder: aSegmentHolder at: aPosition [
	"I bind a segment at a given position to the provided segment holder"
	| aSegment previousLastIndex |

	"First we want to acquire a segment for a given position"
	BlFrameTelemetry
		time: [ 'Get segment at {1}' format: { aPosition } ]
		during: [ aSegment := segmentCollector segmentAt: aPosition. ].

	"and then bind it to the holder"
	BlFrameTelemetry
		time: [ 'Set segment at {1}' format: { aPosition } ]
		during: [ aSegmentHolder segment: aSegment ].

	"If the last cached segment was requested, load more so that the editor knows there are more lines"
	(aPosition = segmentCollector lastIndex and: [ segmentCollector end < segmentCollector text size ])
		ifTrue: [
			previousLastIndex := segmentCollector lastIndex.
			segmentCollector computeForwardAt: aPosition + 1.
			self notifyItemsInserted: (aPosition + 1 to: aPosition + segmentCollector lastIndex - previousLastIndex) ]
]

{ #category : #'instance creation' }
BrTextEditorModel >> onBindHolder: aSegmentHolder at: aPosition payloads: aCollectionOfPayloads [	
	"I bind a segment at a given position to provided segment holder"

	aCollectionOfPayloads
		ifEmpty: [ self onBindHolder: aSegmentHolder at: aPosition ]
		ifNotEmpty: [ :theCommands |
			theCommands do: [ :aHolderCommand | aHolderCommand executeOn: aSegmentHolder ] ]
]

{ #category : #'instance creation' }
BrTextEditorModel >> onCreateHolder: anEditorElement type: aSegmentType [
	"Create and return a new segment holder of a given type to be used with provided editor element"
	<return: #BrEditorSegmentHolder>
	
	"We perform a single dispatch on a segment type in order to support multiple types"
	^ aSegmentType holder
]

{ #category : #hooks }
BrTextEditorModel >> onDetached: anEditorElement [
	super onDetached: anEditorElement.

	attachedElements := attachedElements copyWithout: anEditorElement.

	mode uninstallFromEditorElement: anEditorElement.
	shortcuts do: [ :eachInteraction | self onInteractionRemoved: eachInteraction from: anEditorElement ].

	anEditorElement
		removeEventHandlersSuchThat: [ :aHandler | (aHandler isKindOf: BlEventHandler)
			and: [ { BlMouseUpEvent . BlClickEvent . BlFocusEvent . BlBlurEvent } includes: aHandler eventClass ] ]
]

{ #category : #hooks }
BrTextEditorModel >> onElementRecycled: anElementHolder [
	super onElementRecycled: anElementHolder.
	
	anElementHolder onRecycled
]

{ #category : #'private - focus' }
BrTextEditorModel >> onGotFocus [
	isFocused := true.
	
	self cursors isEmpty
		ifTrue: [ self navigator moveTo: 0; apply ].

	self processCursorEnterEvents.
	self enqueueCommand: (self newFocusChangedCommand hasFocus: true)
]

{ #category : #hooks }
BrTextEditorModel >> onInteractionAdded: anInteraction to: anEditorElement [
	anEditorElement removeShortcutsWithCombination: anInteraction combinationForPlatform.
	anEditorElement addShortcut: anInteraction asShortcut
]

{ #category : #hooks }
BrTextEditorModel >> onInteractionRemoved: anInteraction from: anEditorElement [
	anEditorElement removeShortcutsWithCombination: anInteraction combinationForPlatform
]

{ #category : #'private - focus' }
BrTextEditorModel >> onLostFocus [
	isFocused := false.

	self processCursorLeaveEvents.
	self enqueueCommand: (self newFocusChangedCommand hasFocus: false).
]

{ #category : #hooks }
BrTextEditorModel >> onShortcutAdded: anInteraction [
	attachedElements do: [ :eachElement | self onInteractionAdded: anInteraction to: eachElement ].
	self notifyInteractionAdded: anInteraction
]

{ #category : #hooks }
BrTextEditorModel >> onShortcutRemoved: anInteraction [
	attachedElements do: [ :eachElement | self onInteractionRemoved: anInteraction from: eachElement ].
	self notifyInteractionRemoved: anInteraction
]

{ #category : #'hooks - text modifications' }
BrTextEditorModel >> onStringsInserted: aBlTextStringsInserted [
	"Is sent after a few strings (or one) are inserted in a text model"
	self assertUIProcess.
	
	aBlTextStringsInserted strings
		with: aBlTextStringsInserted finalIndices
		do: [ :aString :anIndex |
			self segmentBuilder
				insertedString: aString
				at: anIndex
				in: self ].

	history
		insertedStrings: aBlTextStringsInserted strings
		undo: aBlTextStringsInserted finalIndices
		redo: aBlTextStringsInserted requestedIndices.

	aBlTextStringsInserted strings
		with: aBlTextStringsInserted finalIndices
		do: [ :aString :anIndex |
			self
				notifyInserted: aString asRopedText
				at: anIndex ].

	self notifyModified: self text.

	shouldStyleWhenTextModified
		ifTrue: [ self styleText ]
]

{ #category : #'hooks - text modifications' }
BrTextEditorModel >> onTextAttributeAdded: aBlTextAttributeAdded [
	self assertUIProcess.

	self segmentBuilder
		addedAttribute: aBlTextAttributeAdded attribute
		from: aBlTextAttributeAdded fromIndex
		to: aBlTextAttributeAdded toIndex
		in: self.

	self notifyAttributesWithinCursor: { aBlTextAttributeAdded attribute }
]

{ #category : #'hooks - text modifications' }
BrTextEditorModel >> onTextAttributesRemoved: aBlTextAttributesRemoved [
	self assertUIProcess.

	self segmentBuilder
		removedAttributesFrom: aBlTextAttributesRemoved fromIndex
		to: aBlTextAttributesRemoved toIndex
		in: self.
]

{ #category : #'hooks - text modifications' }
BrTextEditorModel >> onTextReplaced: oldText [
	"Is sent after a text instance is replaced with a new one"

	self assertUIProcess.

	history replaceText: self text oldText: oldText.
	self processCursorEnterEvents.
	self notifyTextReplaced: self text
]

{ #category : #'hooks - text modifications' }
BrTextEditorModel >> onTextStyled: aBlTextStyledEvent [
	self assertUIProcess.

	(aBlTextStyledEvent text isNextGenerationOf: self text)
		ifTrue: [
			self text updateFrom: aBlTextStyledEvent text text.
			
			BlFrameTelemetry
				time: [ 'Execute after-action: {1}' format: { aBlTextStyledEvent afterAction } ]
				during: [ aBlTextStyledEvent afterAction value: self text. ].
			
			BlFrameTelemetry
				time: [ 'notifyTextStyled' ]
				during: [ self notifyTextStyled: self text ].
			
			BlFrameTelemetry
				time: [ 'processCursorAttributes' ]
				during: [ self processCursorEnterEvents  ].
			
			BlFrameTelemetry
				time: [ 'Invalidate the whole text editor due to text change' ]
				during: [
					self updater
						all;
						update ] ]
		ifFalse: [ self styleTextAndAfterDo: aBlTextStyledEvent afterAction ]
]

{ #category : #'hooks - text modifications' }
BrTextEditorModel >> onTextsDeleted: aBlTextsDeleted [
	"Is sent after a piece of text was deleted in a text model"
	self assertUIProcess.

	aBlTextsDeleted finalIntervals
		do: [ :eachInterval |
			self segmentBuilder
				deletedFrom: eachInterval first
				to:  eachInterval last
				in: self ].

	history
		"text attributes may reference objects such as computation results in the editor and therefore we
		should remove such attributes"
		deletedTexts: (aBlTextsDeleted texts collect: [ :eachText | eachText copyWithoutExternalReferences ])
		undo: (aBlTextsDeleted finalIntervals collect: #first)
		redo: (aBlTextsDeleted requestedIntervals collect: #first).

	aBlTextsDeleted finalIntervals
		do: [ :eachInterval |
			self
				notifyDeletedFrom: eachInterval first
				to:  eachInterval last ].

	self notifyModified: self text.
	
	shouldStyleWhenTextModified
		ifTrue: [ self styleText ]
]

{ #category : #'text - copy/paste' }
BrTextEditorModel >> paste [
	"A paste a text from the clipboard at the current cursor position.
	I delete any currently selected text and update cursor position"
	
	self paster
		fromClipboard;
		atCursor;
		paste
]

{ #category : #'api - modification' }
BrTextEditorModel >> paster [
	^ BrTextEditorPaster new editor: self
]

{ #category : #'private - selection' }
BrTextEditorModel >> prepareSelection [
	self selectionRecorder prepare: self
]

{ #category : #'private - cursor' }
BrTextEditorModel >> processCursorEnterEvents [
	| anEnteredEvent eventHandlingAttributesInside |
	self isFocused ifFalse: [ ^ self ].
	anEnteredEvent := BrTextCursorAttributeEnterEvent new.
	eventHandlingAttributesInside := OrderedCollection new.
	self cursors
		do: [ :eachCursor | 
			self text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute isEventHandler ]
				indicesDo: [ :aStart :anEnd :anAttribute | 
					(eachCursor position between: aStart and: anEnd)
						ifTrue: [ eventHandlingAttributesInside add: anAttribute -> (aStart to: anEnd) ] ] ].


	eventHandlingAttributesInside
		do: [ :eachEventHandlerAttributeAndInterval | 
			| eachAttribute eachInterval |
			eachAttribute := eachEventHandlerAttributeAndInterval key.
			eachInterval := eachEventHandlerAttributeAndInterval value.
			anEnteredEvent interval: eachInterval.

			(eachAttribute wantsEvent: anEnteredEvent in: self)
				ifTrue: [ eachAttribute
						handleEvent: anEnteredEvent
						in: self
						on: nil ] ]
]

{ #category : #'private - cursor' }
BrTextEditorModel >> processCursorLeaveEvents [
	| aLeavedEvent eventHandlingAttributesOutside |
	self isFocused ifFalse: [ ^ self ].
	aLeavedEvent := BrTextCursorAttributeLeaveEvent new.
	eventHandlingAttributesOutside := OrderedCollection new.
	self cursors
		do: [ :eachCursor | 
			self text
				findAttributesSuchThat: [ :eachAttribute | eachAttribute isEventHandler ]
				indicesDo: [ :aStart :anEnd :anAttribute | 
					(eachCursor position between: aStart and: anEnd)
						ifFalse: [ eventHandlingAttributesOutside add: anAttribute -> (aStart to: anEnd) ] ] ].
	eventHandlingAttributesOutside
		do: [ :eachEventHandlerAttributeAndInterval | 
			| eachAttribute eachInterval |
			eachAttribute := eachEventHandlerAttributeAndInterval key.
			eachInterval := eachEventHandlerAttributeAndInterval value.
			aLeavedEvent interval: eachInterval.
			(eachAttribute wantsEvent: aLeavedEvent in: self)
				ifTrue: [ eachAttribute
						handleEvent: aLeavedEvent
						in: self
						on: nil ] ]
]

{ #category : #'private - selection' }
BrTextEditorModel >> recordDeselection: aMonotoneTextSelection [
	self selectionRecorder deselect: aMonotoneTextSelection in: self.
	
	(self selection + self selectionRecorder selection) isEmpty
		ifTrue: [ ^ self ].
		
	self moveCursorTo: (self selection + self selectionRecorder selection) to
]

{ #category : #'private - selection' }
BrTextEditorModel >> recordSelection: aMonotoneTextSelection [
	self selectionRecorder select: aMonotoneTextSelection in: self.

	(self selection + self selectionRecorder selection) isEmpty
		ifTrue: [ ^ self ].
		
	self moveCursorTo: (self selection + self selectionRecorder selection) to
]

{ #category : #'text - undo/redo' }
BrTextEditorModel >> redo [
	history redoOn: self
]

{ #category : #'api - shortcuts' }
BrTextEditorModel >> removeAllEditorShortcuts [
	self editorShortcuts
		removeAllShortcutsAndDo: [ :aPreviousShortcut | self onShortcutRemoved: aPreviousShortcut ]
]

{ #category : #'api - shortcuts' }
BrTextEditorModel >> removeEditorShortcut: aBrTextEditorShortcut [
	self editorShortcuts
		remove: aBrTextEditorShortcut
		ifFound: [ :aPreviousShortcut | self onShortcutRemoved: aPreviousShortcut ]
]

{ #category : #'api - shortcuts' }
BrTextEditorModel >> removeEditorShortcuts: aCollectionOfBrTextEditorShortcut [
	aCollectionOfBrTextEditorShortcut do: [ :eachShortcut | self removeEditorShortcut: eachShortcut ]
]

{ #category : #'api - save state' }
BrTextEditorModel >> restoreState: aBrTextEditorMemento [
	self assertUIProcess.

	aBrTextEditorMemento restoreStateOf: self
]

{ #category : #accessing }
BrTextEditorModel >> restoreText: aBrText [
	| oldText |
	"before changing the text we must unsubscribe from existing one"
	oldText := text.
	text unsubscribe: self.

	text := aBrText.
	self initializeText: text.	"Replacing text instance means that we can not guarantee structural integrity
	of existing cache and have to rebuild it invalidating the whole underlying model structure"
	segmentCollector := BrTextEditorSegmentCollector new.
	segmentCollector editor: self.
	segmentCollector text: text.

	self onTextReplaced: oldText.	"notify UI about structural update"
	self notifyChanged.	"text changed, we should style it"
	shouldStyleWhenTextModified ifTrue: [ self styleText ]
]

{ #category : #'api - save state' }
BrTextEditorModel >> saveState [
	<return: #BrTextEditorMemento>
	self assertUIProcess.
	
	^ (BrTextEditorCompositeMemento new all) saveStateOf: self
]

{ #category : #'api - save state' }
BrTextEditorModel >> saveState: aBrTextEditorMemento [
	<return: #BrTextEditorMemento>
	self assertUIProcess.
	
	^ aBrTextEditorMemento saveStateOf: self
]

{ #category : #accessing }
BrTextEditorModel >> segmentBuilder [
	<return: #BrTextEditorLineSegmentBuilder>

	^ segmentBuilder
]

{ #category : #accessing }
BrTextEditorModel >> segmentBuilder: aTextSegmentBuilder [
	"Change current segment builder to a new one and completely invalidate the structure"
	
	segmentBuilder := aTextSegmentBuilder.
	self notifyChanged
]

{ #category : #accessing }
BrTextEditorModel >> segmentCollector [
	<return: #BrTextEditorSegmentCollector>

	^ segmentCollector
]

{ #category : #'private - text' }
BrTextEditorModel >> select: aFromTextIndex to: aToTextIndex [
	"Select text within an interval defined by provided from and to indices without any other side effects.
	Note:
		- I don't change cursor position.
		- I request segments update"

	self selecter
		from: aFromTextIndex to: aToTextIndex;
		withoutCursorUpdate;
		select
]

{ #category : #'text - selection' }
BrTextEditorModel >> selectNone [
	"Deselect the whole text in the editor without any other side effects.
	Note:
		- I don't change cursor position.
		- I request segments update"

	self selection isEmpty
		ifTrue: [ ^ self ].

	self
		deselect: self selection from
		to: self selection to
]

{ #category : #'text - selection' }
BrTextEditorModel >> selectedText [
	<return: #BlText>
	
	^ self hasSelection
		ifTrue: [ self text copyFrom: self selection from + 1 to: self selection to ]
		ifFalse: [ self text empty ]
]

{ #category : #'api - modification' }
BrTextEditorModel >> selecter [
	<return: #BrTextEditorSelecter>

	^ BrTextEditorSelecter new editor: self
]

{ #category : #accessing }
BrTextEditorModel >> selection [
	<return: #BlSelection>

	^ selection
]

{ #category : #'private - selection' }
BrTextEditorModel >> selection: aTextSelection [
	selection := aTextSelection.
	
	self notifySelectionChanged: selection
]

{ #category : #accessing }
BrTextEditorModel >> selectionRecorder [
	<return: #BrTextEditorSelectionRecorder>

	self
		assert: [ selectionRecorder isNotNil ]
		description: [ 'Selection recorder can not be nil' ].

	^ selectionRecorder
]

{ #category : #'api - shortcuts' }
BrTextEditorModel >> setEditorShortcuts: aBrTextEditorShortcuts [
	self
		assert: [ aBrTextEditorShortcuts isKindOf: BrTextEditorShortcuts ]
		description: [ 'Must be an editor shortcuts object' ].
	
	self removeAllEditorShortcuts.
	
	shortcuts := aBrTextEditorShortcuts.
	shortcuts do: [ :aNewEditorShortcut | self onShortcutAdded: aNewEditorShortcut ]
]

{ #category : #'text - styling' }
BrTextEditorModel >> styleText [
	"I request styler to re-style my current text"
	
	self styleTextAndAfterDo: [ :aStyledText | "do nothing" ]
]

{ #category : #'text - styling' }
BrTextEditorModel >> styleTextAndAfterDo: aBlock [
	"I first style, and then I do aBlock once I am finished"
	
	self dispatchEvent: (BrTextEditorTextStyleRequested new afterAction: aBlock)
]

{ #category : #accessing }
BrTextEditorModel >> styler [
	<return: #BlTextStyler>
	^ styler
]

{ #category : #accessing }
BrTextEditorModel >> styler: aStyler [
	styler = aStyler
		ifTrue: [ ^ self ].

	styler := aStyler.

	"styler changed, let's restyle the text"
	shouldStyleWhenTextModified
		ifTrue: [ self styleText ]
]

{ #category : #accessing }
BrTextEditorModel >> stylerStrategy [
	<return: #BrTextStylerStrategy>
	^ stylerStrategy
]

{ #category : #accessing }
BrTextEditorModel >> stylerStrategy: aBrTextStylerStrategy [
	self 
		assert: [ aBrTextStylerStrategy isNotNil ] 
		description: [ 'Text styler strategy must be non-nil' ].

	stylerStrategy := aBrTextStylerStrategy
]

{ #category : #'api - shortcuts' }
BrTextEditorModel >> surroundMap [
	"When inserting some special symbols a text editor should surround a cursor or selection with that symbol"

	| spaceBlock |
	
	spaceBlock := [ :anOperator :anIndex | anOperator selection contains: anIndex ].

	^ BrTextEditorSurroundMap newFromArrays:
		{ 
			{ #'('. #')'. spaceBlock. }.
			{ #'"'. #'"'. spaceBlock. }.
			{ #''''. #''''. spaceBlock. }.
			{ #'['. #']'. spaceBlock. }.
			{ #'{'. #'}'. spaceBlock. }
		}
]

{ #category : #accessing }
BrTextEditorModel >> text [
	"Return a current text in the text editor. All modification to the text
	are reflected in the UI of the editor. For this reason I must only be
	used from a UI thread. To access a text from a non-UI thread use #textSnapshot
	which would give a copy of the current text"
	<return: #BlText>
	
	self assertUIProcess.
	^ text
]

{ #category : #accessing }
BrTextEditorModel >> text: aBrText [
	
	"when reducing the text size we should update the selection and cursor positions"
	(aBrText size < text size)
		ifTrue: [
			self navigator
				moveWithin: (0 to: aBrText size);
				apply.
			
			self deselecter
				from: aBrText size to: text size;
				deselect ].

	self restoreText: aBrText
]

{ #category : #accessing }
BrTextEditorModel >> textSnapshot [
	"Return a snaphost (copy) of the current text.
	I am safe to use from a non-UI thread because the returned text is independent from the
	current one and can be safely modified"
	<return: #BlText>

	^ text copy
]

{ #category : #'text - undo/redo' }
BrTextEditorModel >> undo [
	history undoOn: self
]

{ #category : #'private - updating' }
BrTextEditorModel >> updateSelection: aFromTextIndex to: aToTextIndex [
	"Update text rendering within an interval defined by provided from and to indices."
	| aCommand |
	
	aCommand := self newSelectionUpdateCommand
		fromIndex: aFromTextIndex;
		toIndex: aToTextIndex.
	self enqueueCommand: aCommand
]

{ #category : #'api - modification' }
BrTextEditorModel >> updater [
	<return: #BrTextEditorUpdater>

	^ BrTextEditorUpdater new editor: self
]

{ #category : #initialization }
BrTextEditorModel >> useAsyncStylerStrategy [
	self stylerStrategy: BrTextStylerAsyncStrategy new
]

{ #category : #initialization }
BrTextEditorModel >> useDefaultStylerStrategy [
	self stylerStrategy: self defaultStylerStrategy
]

{ #category : #initialization }
BrTextEditorModel >> useSyncStylerStrategy [
	self stylerStrategy: BrTextStylerSyncStrategy new
]
