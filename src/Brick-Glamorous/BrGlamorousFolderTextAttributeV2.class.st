Class {
	#name : #BrGlamorousFolderTextAttributeV2,
	#superclass : #BrTextFolderTextAttributeV2,
	#instVars : [
		'tooltipText'
	],
	#category : #'Brick-Glamorous-Editor - Attributes'
}

{ #category : #'private - event handling' }
BrGlamorousFolderTextAttributeV2 >> clearHighlightInTextEditorElement: aTextEditorElement [
	self foldableMarkerAttribute ifNil: [ ^ self ].

	aTextEditorElement removeHighlightsWithId: self highlightId
]

{ #category : #accessing }
BrGlamorousFolderTextAttributeV2 >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| aToggle |
	aToggle := BrInlineExpanderElement new
			id: self id;
			aptitude: (BrLabelExpanderAptitude new text: tooltipText);
			expanded: self isFolded not;
			padding: (BlInsets all: 2);
			margin: (BlInsets top: 2);
			mouseCursor: BlCursor default;
			toggleAction: [ :aWidget | self toggleFoldedOrUnfoledInEditorElement: anEditorElement ].

	self tooltipText ifNotNil: [ :aText | 
		aToggle addAptitude: (BrGlamorousWithExplicitTooltipAptitude text: aText) ].
	aToggle
		when: BlMouseEnterEvent
		do: [ :evt | self highlightFoldableTextInTextEditorElement: anEditorElement ].
	aToggle
		when: BlMouseLeaveEvent
		do: [ :evt | self clearHighlightInTextEditorElement: anEditorElement ].
	aToggle
		when: BlClickEvent
		do: [ :anEvent | 
			anEvent modifiers isSoftAltOnly
				ifTrue: [ anEvent consumed: true.
					anEvent target phlow
						spawnObject: (self definingMethod ifNil: [ self ] ifNotNil: [ :aMethod | aMethod ]) ] ].

	^ aToggle
]

{ #category : #'private - event handling' }
BrGlamorousFolderTextAttributeV2 >> highlightFoldableTextInTextEditorElement: aTextEditorElement [
	self foldableMarkerAttribute ifNil: [ ^ self ].

	aTextEditorElement
		addHighlight: (BrTextHighlight
				id: self highlightId
				color: BrGlamorousColors neutralBackgroundColor)
		overMarker: self foldableMarkerAttribute
]

{ #category : #'private - event handling' }
BrGlamorousFolderTextAttributeV2 >> highlightId [
	^ #'folder-foldable-text'
]

{ #category : #accessing }
BrGlamorousFolderTextAttributeV2 >> tooltipText [
	^ tooltipText
]

{ #category : #accessing }
BrGlamorousFolderTextAttributeV2 >> tooltipText: anObject [
	tooltipText := anObject
]
