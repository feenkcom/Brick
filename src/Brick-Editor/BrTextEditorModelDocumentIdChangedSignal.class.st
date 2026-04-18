Class {
	#name : #BrTextEditorModelDocumentIdChangedSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'editorModel',
		'text',
		'documentId'
	],
	#category : #'Brick-Editor-Signals'
}

{ #category : #accessing }
BrTextEditorModelDocumentIdChangedSignal >> documentId [
	^ documentId
]

{ #category : #accessing }
BrTextEditorModelDocumentIdChangedSignal >> documentId: anObject [
	documentId := anObject
]

{ #category : #accessing }
BrTextEditorModelDocumentIdChangedSignal >> editorModel [
	^ editorModel
]

{ #category : #accessing }
BrTextEditorModelDocumentIdChangedSignal >> editorModel: anObject [
	editorModel := anObject
]

{ #category : #printing }
BrTextEditorModelDocumentIdChangedSignal >> printOneLineContentsOn: aStream [

 documentId gtDisplayOn: aStream.
 aStream space.
 text gtDisplayOn: aStream.
]

{ #category : #accessing }
BrTextEditorModelDocumentIdChangedSignal >> text [
	^ text
]

{ #category : #accessing }
BrTextEditorModelDocumentIdChangedSignal >> text: anObject [
	text := anObject
]
