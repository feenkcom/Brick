Class {
	#name : #BrEditorSearchTextAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'marker',
		'searchElement',
		'context'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #initialization }
BrEditorSearchTextAptitude >> initialize [
	super initialize.

	self initializeSearchElement.
	self initializeMarker.
	self initializeEventHandlers
]

{ #category : #initialization }
BrEditorSearchTextAptitude >> initializeEventHandlers [
	self
		when: BrSearchTextPatternWish
		do: [ :anEvent | self onBrSearchTextPatternWish: anEvent ].
	self
		when: BrSearchTextNoPatternWish
		do: [ :anEvent | self onBrSearchTextNoPatternWish: anEvent ].
	self
		when: BrSearchTextNextOccurenceWish
		do: [ :anEvent | self onBrSearchTextNextOccurenceWish: anEvent ].
	self
		when: BrSearchTextPreviousOccurenceWish
		do: [ :anEvent | self onBrSearchTextPreviousOccurenceWish: anEvent ].
	self
		when: BrSearchTextEndWish
		do: [ :anEvent | self onBrSearchTextEndWish: anEvent ].
]

{ #category : #initialization }
BrEditorSearchTextAptitude >> initializeMarker [
	marker := self newMarker.

	marker
		when: BrEditorSearchTextFinishedAnnouncement
		send: #onBrEditorSearchTextFinishedAnnouncement:
		to: self
]

{ #category : #initialization }
BrEditorSearchTextAptitude >> initializeSearchElement [
	searchElement := self newSearchElement
]

{ #category : #initialization }
BrEditorSearchTextAptitude >> newMarker [
	^ BrEditorSearchTextMarker new
		computation: (BrEditorSearchTextAsyncFutureComputation new
				executionConfiguration: (AsyncFutureExecutionConfiguration new
						customGroup: #SearchText;
						defaultPriority))
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
BrEditorSearchTextAptitude >> newSearchElement [
	"Create a new search element that understands #index:total:"

	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #'private - event management' }
BrEditorSearchTextAptitude >> onBrEditorSearchTextFinishedAnnouncement: anAnnouncement [
	self
		widgetDo: [ :aWidget | 
			BlTaskAction
				enqueueElement: aWidget
				action: [ searchElement
						index: anAnnouncement selectedIndex
						total: anAnnouncement itemsCount ] ]
]

{ #category : #'private - event management' }
BrEditorSearchTextAptitude >> onBrSearchTextEndWish: anEvent [
	| aContext aRange |
	anEvent consumed: true.
	aContext := context ifNil: [ ^ self ].
	context := nil.

	marker unmark: aContext.
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
