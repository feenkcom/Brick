Class {
	#name : #BrTextRange,
	#superclass : #Object,
	#instVars : [
		'start',
		'end',
		'documentId'
	],
	#category : 'Brick-Editor-Model'
}

{ #category : #'as yet unclassified' }
BrTextRange class >> new [
	(self == BrTextRange)
		ifTrue: [ self error: 'Choose one of the concrete subclasses' ].
		
	^ super new
]

{ #category : #'instance creation' }
BrTextRange class >> start: aStart end: anEnd documentId: aDocumentId [
	^ self new
		setStart: aStart
		end: anEnd
		documentId: aDocumentId
]

{ #category : #accessing }
BrTextRange >> documentId [
	^ documentId
]

{ #category : #accessing }
BrTextRange >> end [
	^ end
]

{ #category : #printing }
BrTextRange >> gtDisplayOn: stream [
	stream
		nextPutAll: self typeName;
		space;
		nextPut: $[;
		print: start;
		nextPutAll: '..';
		print: end;
		nextPut: $];
		space.
	documentId gtDisplayOn: stream
]

{ #category : #testing }
BrTextRange >> isByteRange [
	^ false
]

{ #category : #testing }
BrTextRange >> isCharacterRange [
	^ false
]

{ #category : #initialization }
BrTextRange >> setStart: aStart end: anEnd documentId: aDocumentId [
	start := aStart.
	end := anEnd.
	documentId := aDocumentId
]

{ #category : #accessing }
BrTextRange >> start [
	^ start
]

{ #category : #printing }
BrTextRange >> typeName [
	^ self subclassResponsibility
]
