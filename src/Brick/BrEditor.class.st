Class {
	#name : #BrEditor,
	#superclass : #BrEditorElement,
	#traits : 'TBrLayoutResizable + TBrScrollable',
	#classTraits : 'TBrLayoutResizable classTrait + TBrScrollable classTrait',
	#instVars : [
		'textReplacedHandler',
		'lineCount'
	],
	#category : #'Brick-Editor - UI'
}

{ #category : #'api - editor' }
BrEditor >> addEditorShortcut: aBrTextEditorInteraction [
	self editor addEditorShortcut: aBrTextEditorInteraction
]

{ #category : #'api - editor' }
BrEditor >> beEditable [
	self beMode: BrTextEditorEditableMode new
]

{ #category : #'api - editor' }
BrEditor >> beMode: aTextEditorMode [
	self viewModel mode: aTextEditorMode
]

{ #category : #'api - editor' }
BrEditor >> beReadOnlyWithSelection [
	self beMode: BrTextEditorReadonlyWithSelectionMode new
]

{ #category : #'api - editor' }
BrEditor >> beReadOnlyWithoutSelection [
	self beMode: BrTextEditorReadonlyWithoutSelectionMode new
]

{ #category : #accessing }
BrEditor >> computeVerticalScrollExtent [
	^ self lastVisibleSegment index - self firstVisibleSegment index
]

{ #category : #accessing }
BrEditor >> computeVerticalScrollOffset [
	^ self firstVisibleSegment index - 1
]

{ #category : #accessing }
BrEditor >> computeVerticalScrollRange [
	^ self lineCount
]

{ #category : #'editor - accessing' }
BrEditor >> cursors [
	<return: #BrTextEditorCursor>
	^ self editor cursors
]

{ #category : #initialization }
BrEditor >> defaultEditorModel [
	^ BrEditorModel new mode: self defaultTextEditorMode
]

{ #category : #initialization }
BrEditor >> defaultTextEditorMode [
	^ BrTextEditorEditableMode new
]

{ #category : #initialization }
BrEditor >> defaultTextEditorModel [
	^ BrTextEditorModel withEditorMode: self defaultTextEditorMode
]

{ #category : #'editor - operations' }
BrEditor >> deleter [
	<return: #BrTextEditorDeleter>

	^ self editor deleter
]

{ #category : #'editor - operations' }
BrEditor >> deselecter [
	<return: #BrTextEditorDeselecter>

	^ self editor deselecter
]

{ #category : #accessing }
BrEditor >> editor: aBrTextEditor [
	self editor removeEventHandler: textReplacedHandler.

	super editor: aBrTextEditor.

	aBrTextEditor addEventHandler: textReplacedHandler.
	aBrTextEditor consumeClickEvent: false
]

{ #category : #accessing }
BrEditor >> firstVisibleSegment [
	^ (self layout
		findFirstVisibleChildClosestToStartCompletelyVisible: true
		acceptPartiallyVisible: true) segment
]

{ #category : #initialization }
BrEditor >> initialize [
	super initialize.
	
	self matchParent.

	textReplacedHandler := BlEventHandler
		on: BrTextEditorTextReplacedEvent
		"we intentionally set text directly to the viewModel
		to prevent any possible #asRopedText convertion"
		do: [ :anEvent | self viewModel text: anEvent text ].

	self editor: self defaultTextEditorModel.
	self padding: (BlInsets all: 5).

	self viewModel: self defaultEditorModel.
	
	self viewModel when: BrEditorTextChanged do: [ lineCount := nil].
	
	self when: BlMouseUpEvent do: [ :anEvent | anEvent consumed: true ].
	self when: BlClickEvent do: [ :anEvent | anEvent consumed: true ].
	self when: BrScrollByWish do: [:aWish | self onScrollBy: aWish]
]

{ #category : #'api - editor' }
BrEditor >> inputFilter: aBrTextEditorInputFilter [
	self editor inputFilter: aBrTextEditorInputFilter
]

{ #category : #'editor - operations' }
BrEditor >> inserter [
	<return: #BrTextEditorInserter>

	^ self editor inserter
]

{ #category : #'api - editor' }
BrEditor >> isEditable [
	<return: #Boolean>

	^ self viewModel mode isEditable
]

{ #category : #'api - editor' }
BrEditor >> isReadOnly [
	<return: #Boolean>

	^ self viewModel mode isReadOnly
]

{ #category : #accessing }
BrEditor >> lastVisibleSegment [
	^ (self layout
		findFirstVisibleChildClosestToEndCompletelyVisible: true
		acceptPartiallyVisible: true) segment
]

{ #category : #accessing }
BrEditor >> lineCount [
	^ lineCount ifNil: [ lineCount := self text lineCount ]
]

{ #category : #'editor - operations' }
BrEditor >> navigator [
	<return: #BrTextEditorNavigator>

	^ self editor navigator
]

{ #category : #'api - scrolling' }
BrEditor >> onScrollBy: aWish [
	| position |
	position := aWish delta y.
	position := position positive
			ifTrue: [ self lastVisibleSegment index + position ceiling ]
			ifFalse: [ self firstVisibleSegment index + position floor ].
	self scrollToPosition: position
]

{ #category : #'editor - operations' }
BrEditor >> selecter [
	<return: #BrTextEditorSelecter>

	^ self editor selecter
]

{ #category : #'editor - accessing' }
BrEditor >> selection [
	<return: #BlSelection>

	^ self editor selection
]

{ #category : #'editor - accessing' }
BrEditor >> styler [
	^ self viewModel styler
]

{ #category : #'editor - accessing' }
BrEditor >> styler: aStyler [
	self viewModel styler: aStyler
]

{ #category : #'editor - accessing' }
BrEditor >> text [
	"Return a text I work with. All modifications to a text must be done from UI thread"
	<return: #BlText>

	^ self viewModel text
]

{ #category : #'editor - accessing' }
BrEditor >> text: aBlText [
	self viewModel text: aBlText asRopedText
]
