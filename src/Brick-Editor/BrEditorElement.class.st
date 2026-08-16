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

{ #category : #'api - attributes' }
BrEditorElement >> addAppendingAttribute: anAppendingAttribute atAppendingAttribute: anotherAppendingAttribute [
	"Return an attribute tag, currently it is the very same attribute."

	^ self editor
		addAppendingAttribute: anAppendingAttribute
		atAppendingAttribute: anotherAppendingAttribute
]

{ #category : #'api - attributes' }
BrEditorElement >> addAttribute: anAttribute overMarker: aMarkerAttribute [
	"Return an attribute tag, currently it is the very same attribute."

	^ self addAttribute: anAttribute overMarker: aMarkerAttribute
]

{ #category : #'api - attributes' }
BrEditorElement >> addAttribute: anAttribute overRange: aBrTextRange [
	"Return an attribute tag, currently it is the very same attribute."

	^ self editor addAttribute: anAttribute overRange: aBrTextRange
]

{ #category : #'api - highlighting' }
BrEditorElement >> addHighlight: aBrTextHighlight overMarker: aMarkerAttribute [
	self editor addHighlight: aBrTextHighlight overMarker: aMarkerAttribute
]

{ #category : #'api - highlighting' }
BrEditorElement >> addHighlight: aBrTextHighlight overRange: aBrTextRange [
	self editor addHighlight: aBrTextHighlight overRange: aBrTextRange
]

{ #category : #conversion }
BrEditorElement >> asScrollableElement [
	^ self
]

{ #category : #initialization }
BrEditorElement >> defaultLayout [
	^ BlInfiniteLinearLayout vertical
]

{ #category : #'api - editing' }
BrEditorElement >> deleteNextAtCursor [
	self editor deleteNextAtCursor
]

{ #category : #'api - editing' }
BrEditorElement >> deletePreviousAtCursor [
	self editor deletePreviousAtCursor
]

{ #category : #'api - selection' }
BrEditorElement >> deselectAll [
	self editor deselectAll
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

{ #category : #'api - attributes' }
BrEditorElement >> executeAdornmentActionOfAdornmentAttribute: anAdornmentAttribute [
	anAdornmentAttribute executeAdornmentActionOnEditorElement: self
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

{ #category : #'api - editing' }
BrEditorElement >> insertLineEndingAtCursor [
	self editor insertLineEndingAtCursor
]

{ #category : #'api - cursors' }
BrEditorElement >> moveCursorTo: aTextIndex [
	"Moves cursor to a given position without any further action such as cancelling selection"

	self editor moveCursorTo: aTextIndex
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

{ #category : #'api - attributes' }
BrEditorElement >> removeAdornmentAttribute: anAdornmentAttribute [
	self editor removeAdornmentAttribute: anAdornmentAttribute
]

{ #category : #'api - attributes' }
BrEditorElement >> removeAttributeTagged: anAttributeTag [
	"anAttributeTag is currently the very same attribute."

	self editor removeAttributeTagged: anAttributeTag
]

{ #category : #'api - attributes' }
BrEditorElement >> removeAttributeTagged: anAttributeTag overMarker: aMarkerAttribute [
	"anAttributeTag is currently the very same attribute."

	self editor removeAttributeTagged: anAttributeTag overMarker: aMarkerAttribute
]

{ #category : #'api - highlighting' }
BrEditorElement >> removeHighlightsWithId: aStringId [
	self editor removeHighlightsWithId: aStringId
]

{ #category : #'api - editor' }
BrEditorElement >> removeTextAttribute: anAttribute [
	self editor text clearAttributes: [ :each | each == anAttribute ]
]

{ #category : #styling }
BrEditorElement >> requestManualStyling [
	self editor styleText
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

{ #category : #'api - selection' }
BrEditorElement >> selectedStringAndIntervalDo: aSelectedTextBlock orCursorPositionDo: aCursorTextPositionBlock [
	"If a text is selected, evaluate aSelectedTextBlock, aCursorTextPositionBlock otherwise.
	- aSelectedTextBlock have three optional parameters [ :aSelectedString :aSelectedInterval :aTextSize :aDocumentId :aCaretOffset | ],
	- aCursorTextPositionBlock has two optional parameters [ :aStringPosition :aTextSize :aDocumentId :aCaretOffset | ]."

	self editor
		selectedStringAndIntervalDo: aSelectedTextBlock
		orCursorPositionDo: aCursorTextPositionBlock
]

{ #category : #accessing }
BrEditorElement >> smoothScrollToPosition: aPosition [
	(self editor segmentCollector end < self editor segmentCollector text size
		and: [ self editor segmentCollector cachedInterval last < aPosition ])
		ifTrue: [ self editor segmentCollector computeForwardAt: aPosition ].
	^ super smoothScrollToPosition: aPosition
]

{ #category : #styling }
BrEditorElement >> styleText [
	self
		deprecated: 'Use #requestManualStyling instead.'
		transformWith: '`@receiver styleText' -> '`@receiver requestManualStyling'.

	self editor styleText
]

{ #category : #'api - attributes' }
BrEditorElement >> styledTextAttributesDo: aBlock [
	"Iterate styled text attributes. 
	`aBlock` have two optional parameters [ :allAttributes :eachPosition | ]"

	self editor styledTextAttributesDo: aBlock
]

{ #category : #accessing }
BrEditorElement >> text [
	^ self editor text
]

{ #category : #'api - attributes' }
BrEditorElement >> toggleAppendingAttribute: anAppendingAttribute atAppendingAttribute: anotherAppendingAttribute [
	self editor
		toggleAppendingAttribute: anAppendingAttribute
		atAppendingAttribute: anotherAppendingAttribute
]
