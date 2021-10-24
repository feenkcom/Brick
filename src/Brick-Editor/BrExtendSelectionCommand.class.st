Class {
	#name : #BrExtendSelectionCommand,
	#superclass : #Object,
	#instVars : [
		'editor',
		'toSelect',
		'toDeselect',
		'toMoveCursor',
		'toAddCursor',
		'shouldResetDesiredCoordinate',
		'toRemoveCursors'
	],
	#category : 'Brick-Editor-Model - Operators'
}

{ #category : #accessing }
BrExtendSelectionCommand >> editor: anEditor [
	editor := anEditor
]

{ #category : #accessing }
BrExtendSelectionCommand >> gtLiveFor: aView [
	<gtView>
	| textToDisplay |
	textToDisplay := editor text asString asRopedText.
	toSelect
		do: [ :eachToSelect | 
			(textToDisplay from: eachToSelect from to: eachToSelect to)
				attributes: {(BlTextHighlightAttribute new paint: (Color green darker alpha: 0.3))} ].
	toDeselect
		do: [ :eachToDeselect | 
			(textToDisplay from: eachToDeselect from to: eachToDeselect to)
				attributes: {(BlTextUnderlineAttribute new color: (Color red alpha: 0.7))} ].
	^ aView textEditor
		title: 'Selections';
		text: textToDisplay
]

{ #category : #accessing }
BrExtendSelectionCommand >> initialize [
	super initialize.

	toSelect := OrderedCollection new.
	toDeselect := OrderedCollection new.
	toMoveCursor := nil.
	toAddCursor := nil.
	toRemoveCursors := OrderedCollection new.
	shouldResetDesiredCoordinate := true
]

{ #category : #accessing }
BrExtendSelectionCommand >> shouldResetDesiredCoordinate [
	^ shouldResetDesiredCoordinate
]

{ #category : #'accessing - cursor' }
BrExtendSelectionCommand >> toAddCursor: aPosition [
	toAddCursor := aPosition
]

{ #category : #'accessing - cursor' }
BrExtendSelectionCommand >> toAddCursorDo: aBlock [
	toAddCursor ifNotNil: [ :aPosition | aBlock value: aPosition ]
]

{ #category : #accessing }
BrExtendSelectionCommand >> toDeselect [
	^ toDeselect
]

{ #category : #accessing }
BrExtendSelectionCommand >> toDeselect: aCollection [
	toDeselect := aCollection
]

{ #category : #accessing }
BrExtendSelectionCommand >> toDeselectDo: aBlockWithOneArgument [
	toDeselect do: aBlockWithOneArgument
]

{ #category : #'accessing - cursor' }
BrExtendSelectionCommand >> toMoveCursor: aCursor by: anAmount [
	toMoveCursor := aCursor -> anAmount
]

{ #category : #'accessing - cursor' }
BrExtendSelectionCommand >> toMoveCursorDo: aBlock [
	toMoveCursor ifNotNil: [ :anAssociation |
		aBlock value: anAssociation key value: anAssociation value ]
]

{ #category : #'accessing - cursor' }
BrExtendSelectionCommand >> toRemoveCursor: aCursor [
	toRemoveCursors add: aCursor
]

{ #category : #'accessing - cursor' }
BrExtendSelectionCommand >> toRemoveCursors: aCollectionOfCursors [
	toRemoveCursors addAll: aCollectionOfCursors
]

{ #category : #'accessing - cursor' }
BrExtendSelectionCommand >> toRemoveCursorsDo: aBlock [
	toRemoveCursors do: aBlock
]

{ #category : #accessing }
BrExtendSelectionCommand >> toSelect [
	^ toSelect
]

{ #category : #accessing }
BrExtendSelectionCommand >> toSelect: aCollection [
	toSelect := aCollection
]

{ #category : #accessing }
BrExtendSelectionCommand >> toSelectDo: aBlockWithOneArgument [
	toSelect do: aBlockWithOneArgument
]

{ #category : #accessing }
BrExtendSelectionCommand >> withoutResettingDesiredCoordinate [
	shouldResetDesiredCoordinate := false
]
