Class {
	#name : #BrEditorSearchTextVisualizerContext,
	#superclass : #Object,
	#instVars : [
		'allStartPositions',
		'selectedItem',
		'selectedStartPosition',
		'selectedLine',
		'text',
		'pattern'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #testing }
BrEditorSearchTextVisualizerContext class >> isDeprecated [
	^ true
]

{ #category : #accessing }
BrEditorSearchTextVisualizerContext >> allStartPositions [
	^ allStartPositions
]

{ #category : #accessing }
BrEditorSearchTextVisualizerContext >> allStartPositions: aCollection [
	allStartPositions := aCollection
]

{ #category : #accessing }
BrEditorSearchTextVisualizerContext >> itemsCount [
	^ self allStartPositions size
]

{ #category : #accessing }
BrEditorSearchTextVisualizerContext >> pattern [
	^ pattern
]

{ #category : #accessing }
BrEditorSearchTextVisualizerContext >> pattern: anObject [
	pattern := anObject
]

{ #category : #accessing }
BrEditorSearchTextVisualizerContext >> selectedItem [
	^ selectedItem
]

{ #category : #accessing }
BrEditorSearchTextVisualizerContext >> selectedItem: anInteger [
	selectedItem := anInteger
]

{ #category : #accessing }
BrEditorSearchTextVisualizerContext >> selectedLine [
	^ selectedLine
		ifNil: [ selectedLine := (text from: 1 to: self selectedStartPosition) lineCount ]
]

{ #category : #accessing }
BrEditorSearchTextVisualizerContext >> selectedStartPosition [
	^ selectedStartPosition
		ifNil: [ selectedStartPosition := allStartPositions at: selectedItem ]
]

{ #category : #accessing }
BrEditorSearchTextVisualizerContext >> text [
	^ text
]

{ #category : #accessing }
BrEditorSearchTextVisualizerContext >> text: aBlText [
	text := aBlText
]
