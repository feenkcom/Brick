Class {
	#name : #BrTextEditorModifiedEvent,
	#superclass : #BrTextEditorEvent,
	#instVars : [
		'text',
		'editCommand'
	],
	#category : #'Brick-Editor-Model - Events'
}

{ #category : #accessing }
BrTextEditorModifiedEvent >> editCommand [
	^ editCommand
]

{ #category : #accessing }
BrTextEditorModifiedEvent >> editCommand: anEditCommand [
	editCommand := anEditCommand
]

{ #category : #accessing }
BrTextEditorModifiedEvent >> text [
	^ text
]

{ #category : #accessing }
BrTextEditorModifiedEvent >> text: anObject [
	text := anObject
]
