Class {
	#name : #BrTextEditorTextReplacedEvent,
	#superclass : #BrTextEditorEvent,
	#instVars : [
		'text',
		'documentId'
	],
	#category : 'Brick-Editor-Model - Events'
}

{ #category : #accessing }
BrTextEditorTextReplacedEvent >> documentId [
	^ documentId
]

{ #category : #accessing }
BrTextEditorTextReplacedEvent >> documentId: anObject [
	documentId := anObject
]

{ #category : #accessing }
BrTextEditorTextReplacedEvent >> text [
	^ text
]

{ #category : #accessing }
BrTextEditorTextReplacedEvent >> text: anObject [
	text := anObject
]
