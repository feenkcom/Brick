Class {
	#name : #BrSearchTextAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'searchShortcut',
		'marker',
		'searchPatternEventHandler',
		'searchNoPatternEventHandler',
		'searchNextPatternEventHandler',
		'searchPreviousPatternEventHandler',
		'searchEndEventHandler',
		'context',
		'searchSource'
	],
	#category : #'Brick-List - Search Aptitude'
}

{ #category : #initialization }
BrSearchTextAptitude >> initialize [
	super initialize.
	self initializeMarker.
	self initializeSearchElementEventHandlers.
	self initializeShortcuts
]

{ #category : #initialization }
BrSearchTextAptitude >> initializeMarker [
	marker := self newMarker.

	marker
		when: BrSearchFinishedAnnouncement
		send: #onBrListSearchFinishedAnnouncement:
		to: self;
		when: BrSearchProgressAnnouncement
		send: #onBrListSearchProgressAnnouncement:
		to: self
]

{ #category : #initialization }
BrSearchTextAptitude >> initializeSearchElementEventHandlers [
	searchPatternEventHandler := BlEventHandler
		on: BrSearchPatternWish
		do: [ :anEvent | self onSearchPatternWish: anEvent ].
	searchNoPatternEventHandler := BlEventHandler
		on: BrSearchNoPatternWish
		do: [ :anEvent | self onSearchNoPatternWish: anEvent ].
	searchNextPatternEventHandler := BlEventHandler
		on: BrSearchNextOccurenceWish
		do: [ :anEvent | self onSearchNextOccurenceWish: anEvent ].
	searchPreviousPatternEventHandler := BlEventHandler
		on: BrSearchPreviousOccurenceWish
		do: [ :anEvent | self onSearchPreviousOccurenceWish: anEvent ].
	searchEndEventHandler := BlEventHandler
		on: BrSearchEndWish
		do: [ :anEvent | self onSearchEndWish: anEvent ]
]

{ #category : #initialization }
BrSearchTextAptitude >> initializeShortcuts [
	searchShortcut := BlShortcutWithAction new
			name: 'Search';
			description: 'Search text in a given text editor';
			combination: BlKeyCombination primaryF;
			action: [ :anEvent | self onOpenSearchTextDialogEvent: anEvent ]
]

{ #category : #initialization }
BrSearchTextAptitude >> installSearchElementEventHandlers: aSearchElement [
	aSearchElement addEventHandler: searchPatternEventHandler.
	aSearchElement addEventHandler: searchNoPatternEventHandler.
	aSearchElement addEventHandler: searchNextPatternEventHandler.
	aSearchElement addEventHandler: searchPreviousPatternEventHandler.
	aSearchElement addEventHandler: searchEndEventHandler
]

{ #category : #initialization }
BrSearchTextAptitude >> newMarker [
	^ BrSearchMarker new
		"computation: BrEditorSearchTextAsyncFutureComputation newDefault"
]

{ #category : #private }
BrSearchTextAptitude >> newMarkerContext [
	self
		widgetDo: [ :aBrEditor | 
			^ BrSearchMarkerContext new
				source: self searchSource;
				element: self searchElement ].

	^ nil
]

{ #category : #'api - hooks' }
BrSearchTextAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.
	anElement addShortcut: searchShortcut
]

{ #category : #'private - event handling' }
BrSearchTextAptitude >> onBrListSearchFinishedAnnouncement: anAnnouncement [
	context ifNil: [ ^ self ].
	context == anAnnouncement context ifFalse: [ ^ self ].

		self
		widgetDo: [ :anElement | 
			BlTaskAction
				enqueueElement: anElement
				action: [ 
					self searchElement
						index: anAnnouncement selectedIndex
						total: anAnnouncement itemsCount ] ].

	true ifTrue: [ ^ self ].
	self flag: #todo.
						
	self
		widgetDo: [ :aBrEditor | 
			BlTaskAction
				enqueueElement: aBrEditor
				action: [ 
					self searchElement
						index: anAnnouncement selectedIndex
						total: anAnnouncement itemsCount.
					BrEditorSearchTextScroller new
						editorElement: aBrEditor;
						lineIndex: anAnnouncement context selectedLine;
						characterStartPosition: anAnnouncement context selectedStartPosition;
						characterStopPosition: anAnnouncement context selectedStopPosition;
						scroll ] ]
]

{ #category : #'private - event handling' }
BrSearchTextAptitude >> onBrListSearchProgressAnnouncement: anAnnouncement [
	context ifNil: [ ^ self ].
	context == anAnnouncement context ifFalse: [ ^ self ].

	self
		widgetDo: [ :anElement | 
			BlTaskAction
				enqueueElement: anElement
				action: [ self searchElement progressIndex: nil total: anAnnouncement itemsCount ] ].

	true ifTrue: [ ^ self ].
	self flag: #todo.

	self
		widgetDo: [ :aBrEditor | 
			BlTaskAction
				enqueueElement: aBrEditor
				action: [ | aSegment |
					aSegment := (aBrEditor layout
							findFirstVisibleChildClosestToStartCompletelyVisible: true
							acceptPartiallyVisible: false) ifNotNil: #segment.

					aSegment
						ifNil: [ self searchElement progressIndex: nil total: anAnnouncement itemsCount ]
						ifNotNil: [ aSegment index = 1
								ifTrue: [ self searchElement
										progressIndex: anAnnouncement selectedIndex
										total: anAnnouncement itemsCount ]
								ifFalse: [ self searchElement
										progressIndex: nil
										total: anAnnouncement itemsCount ] ].

					BrEditorSearchTextScroller new
						editorElement: aBrEditor;
						lineIndex: anAnnouncement context selectedLine;
						characterStartPosition: anAnnouncement context selectedStartPosition;
						characterStopPosition: anAnnouncement context selectedStopPosition;
						scroll ] ]
]

{ #category : #'private - event handling' }
BrSearchTextAptitude >> onOpenSearchTextDialogEvent: anEvent [
	anEvent consumed: true
]

{ #category : #'private - event handling' }
BrSearchTextAptitude >> onSearchEndWish: anEvent [ 
	| aContext aRange |
	anEvent consumed: true.
	aContext := context ifNil: [ ^ self ].
	context := nil.

	marker unmark: aContext.
	
	self flag: #todo.
	
	"Select the last highlighted text"
	"aRange := aContext selectedRange.
	aRange ifNil: [ ^ self ].

	self widgetDo: [ :aBrEditor | 
		aBrEditor editor select: aRange first - 1 to: aRange last ]"
]

{ #category : #'private - event handling' }
BrSearchTextAptitude >> onSearchNextOccurenceWish: anEvent [
	| aContext |
	anEvent consumed: true.
	aContext := context ifNil: [ ^ self ].

	self
		widgetDo: [ :aBrEditor | 
			marker markNext: aContext.

			self flag: #todo.
			
			"BrEditorSearchTextScroller new
				editorElement: aBrEditor;
				lineIndex: aContext selectedLine;
				characterStartPosition: aContext selectedStartPosition;
				characterStopPosition: aContext selectedStopPosition;
				scroll" ]
]

{ #category : #'private - event handling' }
BrSearchTextAptitude >> onSearchNoPatternWish: anEvent [
	| aContext |
	anEvent consumed: true.

	aContext := context.
	context := nil.
	aContext ifNil: [ ^ self ].

	marker unmark: aContext
]

{ #category : #'private - event handling' }
BrSearchTextAptitude >> onSearchPatternWish: anEvent [
	| aContext |
	anEvent consumed: true.

	aContext := self newMarkerContext.
	aContext ifNil: [ ^ self ].

	aContext pattern: anEvent pattern.
	context ifNotNil: [ :anOldContext |
		marker unmark: anOldContext ].
	context := aContext.
	marker mark: aContext
]

{ #category : #'private - event handling' }
BrSearchTextAptitude >> onSearchPreviousOccurenceWish: anEvent [
	| aContext |
	anEvent consumed: true.
	aContext := context ifNil: [ ^ self ].

	self
		widgetDo: [ :aBrEditor | 
			marker markPrevious: aContext.
			
			self flag: #todo.
			
			"BrEditorSearchTextScroller new
				editorElement: aBrEditor;
				lineIndex: aContext selectedLine;
				characterStartPosition: aContext selectedStartPosition;
				characterStopPosition: aContext selectedStopPosition;
				scroll" ]
]

{ #category : #'api - hooks' }
BrSearchTextAptitude >> onUninstalledIn: anElement [
	super onUninstalledIn: anElement.
	anElement removeShortcut: searchShortcut
]

{ #category : #accessing }
BrSearchTextAptitude >> searchElement [
	"Return an element for which a computation happens, e.g., search text dialog"

	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #accessing }
BrSearchTextAptitude >> searchSource [
	"Return a source in which a computation happens, e.g., text editor, list element"

	<return: #BrSearchSource>
	^ searchSource
]

{ #category : #accessing }
BrSearchTextAptitude >> searchSource: aSource [
	"Set a source in which a computation happens, e.g., text editor, list element"

	searchSource := aSource
]

{ #category : #initialization }
BrSearchTextAptitude >> uninstallSearchElementEventHandlers: aSearchElement [
	aSearchElement removeEventHandler: searchPatternEventHandler.
	aSearchElement removeEventHandler: searchNoPatternEventHandler.
	aSearchElement removeEventHandler: searchNextPatternEventHandler.
	aSearchElement removeEventHandler: searchPreviousPatternEventHandler.
	aSearchElement removeEventHandler: searchEndEventHandler
]
