Class {
	#name : #BrSearchFoundTextItem,
	#superclass : #BrSearchFoundItem,
	#instVars : [
		'pattern',
		'startIndex',
		'stopIndex',
		'text',
		'isSelected',
		'absoluteStartIndex',
		'absoluteStopIndex',
		'textAttribute',
		'index'
	],
	#category : #'Brick-List - Search Model'
}

{ #category : #accessing }
BrSearchFoundTextItem >> absoluteStartIndex [
	^ absoluteStartIndex
]

{ #category : #accessing }
BrSearchFoundTextItem >> absoluteStartIndex: anInteger [
	absoluteStartIndex := anInteger
]

{ #category : #accessing }
BrSearchFoundTextItem >> absoluteStopIndex [
	^ absoluteStopIndex
]

{ #category : #accessing }
BrSearchFoundTextItem >> absoluteStopIndex: anObject [
	absoluteStopIndex := anObject
]

{ #category : #accessing }
BrSearchFoundTextItem >> index [
	^ index
]

{ #category : #accessing }
BrSearchFoundTextItem >> index: anObject [
	index := anObject
]

{ #category : #accessing }
BrSearchFoundTextItem >> isSelected [
	^ isSelected ifNil: [ false ]
]

{ #category : #accessing }
BrSearchFoundTextItem >> isSelected: aBoolean [
	isSelected := aBoolean
]

{ #category : #'api - markers' }
BrSearchFoundTextItem >> mark: aMarkContext using: aMarker [ 
	aMarker markFoundTextItem: self context: aMarkContext
]

{ #category : #accessing }
BrSearchFoundTextItem >> pattern [
	^ pattern
]

{ #category : #accessing }
BrSearchFoundTextItem >> pattern: anObject [
	pattern := anObject
]

{ #category : #printing }
BrSearchFoundTextItem >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: 'from ';
		print: self absoluteStartIndex;
		nextPutAll: ' to ';
		print: self absoluteStopIndex;
		nextPutAll: ', subtext: ';
		print: self substring;
		nextPut: $)
]

{ #category : #accessing }
BrSearchFoundTextItem >> startIndex [
	^ startIndex
]

{ #category : #accessing }
BrSearchFoundTextItem >> startIndex: anObject [
	startIndex := anObject
]

{ #category : #accessing }
BrSearchFoundTextItem >> stopIndex [
	^ stopIndex
]

{ #category : #accessing }
BrSearchFoundTextItem >> stopIndex: anObject [
	stopIndex := anObject
]

{ #category : #acessing }
BrSearchFoundTextItem >> substring [
	^ self subtext asString
]

{ #category : #acessing }
BrSearchFoundTextItem >> subtext [
	^ self text from: self startIndex to: self stopIndex
]

{ #category : #accessing }
BrSearchFoundTextItem >> text [
	^ text
]

{ #category : #accessing }
BrSearchFoundTextItem >> text: anObject [
	text := anObject
]

{ #category : #accessing }
BrSearchFoundTextItem >> textAttribute [
	<return: #BrEditorSearchTextMark>
	^ textAttribute
]

{ #category : #accessing }
BrSearchFoundTextItem >> textAttribute: aBrEditorSearchTextMark [
	textAttribute := aBrEditorSearchTextMark
]

{ #category : #'api - markers' }
BrSearchFoundTextItem >> unmark: aMarkContext [
	self textAttribute ifNotNil: [ :aTextAttribute | 
		self text removeAttribute: aTextAttribute ]
]
