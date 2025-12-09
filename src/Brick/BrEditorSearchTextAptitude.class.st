Class {
	#name : #BrEditorSearchTextAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'marker',
		'searchElement',
		'context',
		'searchShortcut'
	],
	#category : #'Brick-Editor - Search Aptitude'
}

{ #category : #initialization }
BrEditorSearchTextAptitude >> initialize [
	super initialize.

	self initializeSearchElement.
	self initializeMarker.
	self initializePopover.
	searchShortcut := BlShortcutWithAction new
			name: 'Search';
			description: 'Search text in a given text editor';
			combination: BlKeyCombination primaryF;
			action: [ :anEvent | self onOpenSearchTextDialogEvent: anEvent ]
]

{ #category : #initialization }
BrEditorSearchTextAptitude >> initializeMarker [
	marker := self newMarker.

	marker
		when: BrEditorSearchTextFinishedAnnouncement
		send: #onBrEditorSearchTextFinishedAnnouncement:
		to: self;
		when: BrEditorSearchTextProgressAnnouncement
		send: #onBrEditorSearchTextProgressAnnouncement:
		to: self
]

{ #category : #initialization }
BrEditorSearchTextAptitude >> initializePopover [
	self add: self newPopoverAptitude.

	self
		when: BrPopoverIsHiddenEvent
		do: [ :anEvent | self onBrPopoverIsHiddenEvent: anEvent ]
]

{ #category : #initialization }
BrEditorSearchTextAptitude >> initializeSearchElement [
	searchElement := self newSearchElement.

	searchElement
		when: BrEditorSearchTextPatternWish
		do: [ :anEvent | self onBrSearchTextPatternWish: anEvent ].
	searchElement
		when: BrEditorSearchTextNoPatternWish
		do: [ :anEvent | self onBrSearchTextNoPatternWish: anEvent ].
	searchElement
		when: BrEditorSearchTextNextOccurenceWish
		do: [ :anEvent | self onBrSearchTextNextOccurenceWish: anEvent ].
	searchElement
		when: BrEditorSearchTextPreviousOccurenceWish
		do: [ :anEvent | self onBrSearchTextPreviousOccurenceWish: anEvent ].
	searchElement
		when: BrEditorSearchTextEndWish
		do: [ :anEvent | self onBrSearchTextEndWish: anEvent ]
]

{ #category : #initialization }
BrEditorSearchTextAptitude >> newMarker [
	^ BrEditorSearchTextMarker new
		computation: BrEditorSearchTextAsyncFutureComputation newDefault
]

{ #category : #private }
BrEditorSearchTextAptitude >> newMarkerContext [
	self
		widgetDo: [ :aBrEditor | 
			^ BrEditorSearchTextMarkerContext new
				fromEditor: aBrEditor;
				element: searchElement ].

	^ nil
]

{ #category : #initialization }
BrEditorSearchTextAptitude >> newPopoverAptitude [
	<return: #BrWithExplicitPopoverAptitude>
	^ self subclassResponsibility
]

{ #category : #initialization }
BrEditorSearchTextAptitude >> newSearchElement [
	"Create a new search element that understands #index:total: and #progressIndex:total:"

	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #'api - hooks' }
BrEditorSearchTextAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.
	anElement addShortcut: searchShortcut
]

{ #category : #'private - event management' }
BrEditorSearchTextAptitude >> onBrEditorSearchTextFinishedAnnouncement: anAnnouncement [
	context ifNil: [ ^ self ].
	context == anAnnouncement context ifFalse: [ ^ self ].

	self
		widgetDo: [ :aBrEditor | 
			BlTaskAction
				enqueueElement: aBrEditor
				action: [ 
					searchElement
						index: anAnnouncement selectedIndex
						total: anAnnouncement itemsCount.
					BrEditorSearchTextScroller new
						editorElement: aBrEditor;
						lineIndex: anAnnouncement context selectedLine;
						characterStartPosition: anAnnouncement context selectedStartPosition;
						characterStopPosition: anAnnouncement context selectedStopPosition;
						scroll ] ]
]

{ #category : #'private - event management' }
BrEditorSearchTextAptitude >> onBrEditorSearchTextProgressAnnouncement: anAnnouncement [
	context ifNil: [ ^ self ].
	context == anAnnouncement context ifFalse: [ ^ self ].

	self
		widgetDo: [ :aBrEditor | 
			BlTaskAction
				enqueueElement: aBrEditor
				action: [ | aSegment |
					aSegment := (aBrEditor layout
							findFirstVisibleChildClosestToStartCompletelyVisible: true
							acceptPartiallyVisible: false) ifNotNil: #segment.

					aSegment
						ifNil: [ searchElement progressIndex: nil total: anAnnouncement itemsCount ]
						ifNotNil: [ aSegment index = 1
								ifTrue: [ searchElement
										progressIndex: anAnnouncement selectedIndex
										total: anAnnouncement itemsCount ]
								ifFalse: [ searchElement
										progressIndex: nil
										total: anAnnouncement itemsCount ] ].

					BrEditorSearchTextScroller new
						editorElement: aBrEditor;
						lineIndex: anAnnouncement context selectedLine;
						characterStartPosition: anAnnouncement context selectedStartPosition;
						characterStopPosition: anAnnouncement context selectedStopPosition;
						scroll ] ]
]

{ #category : #'private - event management' }
BrEditorSearchTextAptitude >> onBrPopoverIsHiddenEvent: anEvent [
	| aContext |
	aContext := context ifNil: [ ^ self ].
	context := nil.

	marker unmark: aContext
]

{ #category : #'private - event management' }
BrEditorSearchTextAptitude >> onBrSearchTextEndWish: anEvent [
	| aContext aRange |
	anEvent consumed: true.
	aContext := context ifNil: [ ^ self ].
	context := nil.

	marker unmark: aContext.
	
	"Select the last highlighted text"
	aRange := aContext selectedRange.
	aRange ifNil: [ ^ self ].

	self widgetDo: [ :aBrEditor | 
		aBrEditor editor select: aRange first - 1 to: aRange last ]
]

{ #category : #'private - event management' }
BrEditorSearchTextAptitude >> onBrSearchTextNextOccurenceWish: anEvent [
	| aContext |
	anEvent consumed: true.
	aContext := context ifNil: [ ^ self ].

	self
		widgetDo: [ :aBrEditor | 
			marker markNext: aContext.

			BrEditorSearchTextScroller new
				editorElement: aBrEditor;
				lineIndex: aContext selectedLine;
				characterStartPosition: aContext selectedStartPosition;
				characterStopPosition: aContext selectedStopPosition;
				scroll ]
]

{ #category : #initialization }
BrEditorSearchTextAptitude >> onBrSearchTextNoPatternWish: anEvent [
	| aContext |
	anEvent consumed: true.

	aContext := context.
	context := nil.
	aContext ifNil: [ ^ self ].

	marker unmark: aContext
]

{ #category : #'private - event management' }
BrEditorSearchTextAptitude >> onBrSearchTextPatternWish: anEvent [
	| aContext |
	anEvent consumed: true.

	aContext := self newMarkerContext.
	aContext ifNil: [ ^ self ].

	aContext pattern: anEvent pattern.
	context := aContext.
	marker mark: aContext
]

{ #category : #'private - event management' }
BrEditorSearchTextAptitude >> onBrSearchTextPreviousOccurenceWish: anEvent [
	| aContext |
	anEvent consumed: true.
	aContext := context ifNil: [ ^ self ].

	self
		widgetDo: [ :aBrEditor | 
			marker markPrevious: aContext.
			BrEditorSearchTextScroller new
				editorElement: aBrEditor;
				lineIndex: aContext selectedLine;
				characterStartPosition: aContext selectedStartPosition;
				characterStopPosition: aContext selectedStopPosition;
				scroll ]
]

{ #category : #'private - event management' }
BrEditorSearchTextAptitude >> onOpenSearchTextDialogEvent: anEvent [
	anEvent consumed: true
]
