Class {
	#name : #BrTextEditorDeletionModificationEvent,
	#superclass : #BrTextEditorModificationEvent,
	#instVars : [
		'lengths'
	],
	#category : #'Brick-Editor-Model - Events'
}

{ #category : #testing }
BrTextEditorDeletionModificationEvent >> isDeletion [
	^ true
]

{ #category : #accessing }
BrTextEditorDeletionModificationEvent >> lengths [
	^ lengths
]

{ #category : #accessing }
BrTextEditorDeletionModificationEvent >> lengths: anObject [
	lengths := anObject
]
