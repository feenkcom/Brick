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
BrEditorElement >> addAttribute: anAttribute overMarker: aMarkerAttribute [
	"Return an attribute tag, currently it is the very same attribute."

	self text
		findAttribute: aMarkerAttribute
		indicesDo: [ :aMarkerStartPosition :aMarkerEndPosition | 
			self text
				attributes: {anAttribute}
				from: aMarkerStartPosition
				to: aMarkerEndPosition ].

	^ anAttribute
]

{ #category : #'api - attributes' }
BrEditorElement >> addAttribute: anAttribute overRange: aBrTextRange [
	"Return an attribute tag, currently it is the very same attribute."

	self assert: [ aBrTextRange isCharacterRange ].
	
	"(self editor isWithDocumentId: aBrTextRange documentId)
		ifFalse: [ ^ self ]."

	self text
		attributes: {anAttribute}
		from: aBrTextRange start
		to: aBrTextRange end.
		
	^ anAttribute
]

{ #category : #'api - highlighting' }
BrEditorElement >> addHighlight: aBrTextHighlight overRange: aBrTextRange [
	self assert: [ aBrTextRange isCharacterRange ].

	"(self editor isWithDocumentId: aBrTextRange documentId)
		ifFalse: [ ^ self ]."

	self text
		attributes: {BlTextHighlightAttribute new
					paint: aBrTextHighlight color;
					id: aBrTextHighlight id}
		from: aBrTextRange start
		to: aBrTextRange end
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

{ #category : #'api - attributes' }
BrEditorElement >> removeAttributeTagged: anAttributeTag [
	"anAttributeTag is currently the very same attribute."

	self text removeAttribute: anAttributeTag
]

{ #category : #'api - attributes' }
BrEditorElement >> removeAttributeTagged: anAttributeTag overMarker: aMarkerAttribute [
	"anAttributeTag is currently the very same attribute."

	self text removeAttribute: anAttributeTag
]

{ #category : #'api - highlighting' }
BrEditorElement >> removeHighlightsWithId: aStringId [
	self text
		clearAttributes: [ :eachAttribute | 
			eachAttribute class = BlTextHighlightAttribute and: [ 
				eachAttribute id = aStringId ] ]
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

{ #category : #accessing }
BrEditorElement >> text [
	^ self editor text
]
