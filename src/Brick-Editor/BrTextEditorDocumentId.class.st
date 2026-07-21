Class {
	#name : #BrTextEditorDocumentId,
	#superclass : #Object,
	#instVars : [
		'textId',
		'revisionId'
	],
	#category : 'Brick-Editor-Model'
}

{ #category : #'instance creation' }
BrTextEditorDocumentId class >> textId: aTextId revisionId: aRevisionId [
	^ self new textId: aTextId revisionId: aRevisionId
]

{ #category : #comparing }
BrTextEditorDocumentId >> = anObject [
	self == anObject ifTrue: [ ^ true ].

	self class = anObject class ifFalse: [ ^ false ].

	^ self textId = anObject textId and: [ self revisionId = anObject revisionId ]
]

{ #category : #printing }
BrTextEditorDocumentId >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Document ';
		print: self textId;
		nextPutAll: '.';
		print: self revisionId
]

{ #category : #comparing }
BrTextEditorDocumentId >> hash [
	^ (self class hash hashMultiply bitXor: self textId hash hashMultiply)
		bitXor: self revisionId hash hashMultiply
]

{ #category : #printing }
BrTextEditorDocumentId >> printOn: aStream [
	aStream
		nextPutAll: 'DocumentId(id: ';
		print: self textId;
		nextPutAll: ', revision: ';
		print: self revisionId;
		nextPutAll: ')'
]

{ #category : #'accessing - structure variables' }
BrTextEditorDocumentId >> revisionId [
	^ revisionId
]

{ #category : #accessing }
BrTextEditorDocumentId >> textId [
	^ textId
]

{ #category : #initialization }
BrTextEditorDocumentId >> textId: aTextId revisionId: aRevisionId [
	textId := aTextId.
	revisionId := aRevisionId
]

{ #category : #changes }
BrTextEditorDocumentId >> withIncreasedRevisionId [
	^ self class textId: textId revisionId: revisionId + 1
]

{ #category : #changes }
BrTextEditorDocumentId >> withIncreasedTextId [
	^ self class textId: textId + 1 revisionId: 1
]
