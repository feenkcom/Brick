Class {
	#name : #BrTextEditorModificationEvent,
	#superclass : #BrTextEditorEvent,
	#instVars : [
		'indices'
	],
	#category : #'Brick-Editor-Model - Events'
}

{ #category : #accessing }
BrTextEditorModificationEvent >> indices [
	^ indices
]

{ #category : #accessing }
BrTextEditorModificationEvent >> indices: anObject [
	indices := anObject
]

{ #category : #'as yet unclassified' }
BrTextEditorModificationEvent >> indicesAndLengthsDo: aBlock [
	self indices with: self lengths do: aBlock
]

{ #category : #testing }
BrTextEditorModificationEvent >> isDeletion [
	^ false
]

{ #category : #testing }
BrTextEditorModificationEvent >> isInsertion [
	^ false
]

{ #category : #'as yet unclassified' }
BrTextEditorModificationEvent >> isModification [
	^ true
]

{ #category : #accessing }
BrTextEditorModificationEvent >> lengths [
	^ self subclassResponsibility
]
