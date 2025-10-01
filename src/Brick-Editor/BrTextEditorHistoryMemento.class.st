Class {
	#name : #BrTextEditorHistoryMemento,
	#superclass : #BrTextEditorMemento,
	#instVars : [
		'history'
	],
	#category : #'Brick-Editor-Model - Memento'
}

{ #category : #accessing }
BrTextEditorHistoryMemento >> history: anObject [
	history := anObject
]

{ #category : #initialization }
BrTextEditorHistoryMemento >> initialize [
	super initialize.
	
	history := BrTextEditorHistory new
]

{ #category : #evaluating }
BrTextEditorHistoryMemento >> label [
	^ 'History'
]

{ #category : #accessing }
BrTextEditorHistoryMemento >> order [
	^ 65
]

{ #category : #memento }
BrTextEditorHistoryMemento >> restoreStateOf: aTextEditor [
	aTextEditor history: history copy
]

{ #category : #memento }
BrTextEditorHistoryMemento >> saveStateOf: aTextEditor [
	history := aTextEditor history copy
]

{ #category : #evaluating }
BrTextEditorHistoryMemento >> value [
	^ history
]
