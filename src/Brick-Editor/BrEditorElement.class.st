"
I represent a scrollable editor element. I support scrolling, selection and other various features.
"
Class {
	#name : #BrEditorElement,
	#superclass : #BlInfiniteElement,
	#instVars : [
		'hasFocus',
		'textStyleHandler',
		'textScrollOnModifyHandler'
	],
	#classVars : [
		'EditorTabSize'
	],
	#category : #'Brick-Editor-UI'
}

{ #category : #accessing }
BrEditorElement class >> editorTabSize [
	^ EditorTabSize ifNil: [ EditorTabSize := 2 ]
]

{ #category : #accessing }
BrEditorElement class >> editorTabSize: aNumber [
	self assert: aNumber isNumber.
	EditorTabSize := aNumber
]

{ #category : #conversion }
BrEditorElement >> asScrollableElement [
	^ self
]

{ #category : #initialization }
BrEditorElement >> defaultLayout [
	^ BlInfiniteLinearLayout vertical
]

{ #category : #accessing }
BrEditorElement >> editor [
	<return: #BrTextEditorModel>

	^ self dataSource
]

{ #category : #accessing }
BrEditorElement >> editor: aBrTextEditor [
	self editor removeEventHandler: textStyleHandler.
	self editor removeEventHandler: textScrollOnModifyHandler.
	self dataSource: aBrTextEditor.
	self editor addEventHandler: textStyleHandler.
	self editor addEventHandler: textScrollOnModifyHandler.
]

{ #category : #'focus testing' }
BrEditorElement >> hasFocus [
	^ hasFocus or: [ self isFocused ]
]

{ #category : #initialization }
BrEditorElement >> initialize [
	super initialize.

	self focusability: BlFocusability block.
	
	hasFocus := false.
	self when: BlFocusInEvent do: [ hasFocus := true ].
	self when: BlFocusOutEvent do: [ hasFocus := false ].
	
	self enableNestedScrolling.
	
	textStyleHandler := BlEventHandler
		on: BrTextEditorTextStyleRequested
		do: [ :anEvent | self privateDoStyleTextAndAfterDo: anEvent afterAction ].
		
	textScrollOnModifyHandler := BlEventHandler
		on: BrTextEditorModifiedEvent
		do: [ :anEvent | self privateScrollWhenTextModified: anEvent ].
]

{ #category : #accessing }
BrEditorElement >> privateDoStyleTextAndAfterDo: aBlock [
	"Actually trigger a text styler"
	
	(BlTextStylerRequestedSignal new element: self) emit.
	
	self editor stylerStrategy
		styleTextInEditorElement: self
		thenDo: aBlock
]

{ #category : #initialization }
BrEditorElement >> privateScrollWhenTextModified: anEvent [
	| allCursors aMaxIndex aTargetLine |
	anEvent isDueToInsertion ifFalse: [ ^ self ].

	allCursors := self editor cursors allCursors
		ifEmpty: [ ^ self ].

	aMaxIndex := (allCursors detectMax: [ :each | each position ]) position.
	aMaxIndex := aMaxIndex min: self text size.
	aTargetLine := (self text from: 1 to: aMaxIndex) lineCount.

	self scrollToPosition: aTargetLine + 1
]

{ #category : #scrolling }
BrEditorElement >> scrollToFirst [
	"Scroll instantly to the first position"
	
	self scrollToPosition: 1
]

{ #category : #scrolling }
BrEditorElement >> scrollToLast [
	"Scroll instantly to the last segment"
	
	self scrollToPosition: self editor text lineCount
]

{ #category : #accessing }
BrEditorElement >> scrollToPosition: aPosition [
	(self editor segmentCollector end < self editor segmentCollector text size
		and: [ self editor segmentCollector cachedInterval last < aPosition ])
		ifTrue: [ self editor segmentCollector computeForwardAt: aPosition ].
	^ super scrollToPosition: aPosition
]

{ #category : #accessing }
BrEditorElement >> smoothScrollToPosition: aPosition [
	(self editor segmentCollector end < self editor segmentCollector text size
		and: [ self editor segmentCollector cachedInterval last < aPosition ])
		ifTrue: [ self editor segmentCollector computeForwardAt: aPosition ].
	^ super smoothScrollToPosition: aPosition
]

{ #category : #accessing }
BrEditorElement >> text [
	^ self editor text
]
