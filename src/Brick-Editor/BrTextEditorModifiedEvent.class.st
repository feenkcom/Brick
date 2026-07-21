Class {
	#name : #BrTextEditorModifiedEvent,
	#superclass : #BrTextEditorEvent,
	#instVars : [
		'text',
		'editCommand',
		'reason',
		'documentId'
	],
	#category : 'Brick-Editor-Model - Events'
}

{ #category : #accessing }
BrTextEditorModifiedEvent >> documentId [
	^ documentId
]

{ #category : #accessing }
BrTextEditorModifiedEvent >> documentId: anObject [
	documentId := anObject
]

{ #category : #accessing }
BrTextEditorModifiedEvent >> editCommand [
	^ editCommand
]

{ #category : #accessing }
BrTextEditorModifiedEvent >> editCommand: anEditCommand [
	editCommand := anEditCommand
]

{ #category : #testing }
BrTextEditorModifiedEvent >> isDueToInsertion [
	^ reason isKindOf: BlTextStringsInserted
]

{ #category : #accessing }
BrTextEditorModifiedEvent >> reason [
	^ reason
]

{ #category : #accessing }
BrTextEditorModifiedEvent >> reason: anObject [
	reason := anObject
]

{ #category : #accessing }
BrTextEditorModifiedEvent >> text [
	^ text
]

{ #category : #accessing }
BrTextEditorModifiedEvent >> text: anObject [
	text := anObject
]
