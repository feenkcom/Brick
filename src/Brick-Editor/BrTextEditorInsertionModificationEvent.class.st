Class {
	#name : #BrTextEditorInsertionModificationEvent,
	#superclass : #BrTextEditorModificationEvent,
	#instVars : [
		'strings'
	],
	#category : #'Brick-Editor-Model - Events'
}

{ #category : #testing }
BrTextEditorInsertionModificationEvent >> isInsertion [
	^ true
]

{ #category : #accessing }
BrTextEditorInsertionModificationEvent >> lengths [
	^ strings collect: #size
]

{ #category : #accessing }
BrTextEditorInsertionModificationEvent >> strings [
	^ strings
]

{ #category : #accessing }
BrTextEditorInsertionModificationEvent >> strings: anObject [
	strings := anObject
]
