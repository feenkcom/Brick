"
I represent a place in a {{gtClass:BlText}} where a given {{gtClass:BrEditorSearchTextPattern}} was found.

"
Class {
	#name : #BrEditorSearchTextItem,
	#superclass : #Object,
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
	#category : #'Brick-Editor - Search Model'
}

{ #category : #accessing }
BrEditorSearchTextItem >> absoluteStartIndex [
	^ absoluteStartIndex
]

{ #category : #accessing }
BrEditorSearchTextItem >> absoluteStartIndex: anInteger [
	absoluteStartIndex := anInteger
]

{ #category : #accessing }
BrEditorSearchTextItem >> absoluteStopIndex [
	^ absoluteStopIndex
]

{ #category : #accessing }
BrEditorSearchTextItem >> absoluteStopIndex: anObject [
	absoluteStopIndex := anObject
]

{ #category : #accessing }
BrEditorSearchTextItem >> index [
	^ index
]

{ #category : #accessing }
BrEditorSearchTextItem >> index: anObject [
	index := anObject
]

{ #category : #accessing }
BrEditorSearchTextItem >> isSelected [
	^ isSelected ifNil: [ false ]
]

{ #category : #accessing }
BrEditorSearchTextItem >> isSelected: aBoolean [
	isSelected := aBoolean
]

{ #category : #accessing }
BrEditorSearchTextItem >> pattern [
	^ pattern
]

{ #category : #accessing }
BrEditorSearchTextItem >> pattern: anObject [
	pattern := anObject
]

{ #category : #printing }
BrEditorSearchTextItem >> printOn: aStream [
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
BrEditorSearchTextItem >> startIndex [
	^ startIndex
]

{ #category : #accessing }
BrEditorSearchTextItem >> startIndex: anObject [
	startIndex := anObject
]

{ #category : #accessing }
BrEditorSearchTextItem >> stopIndex [
	^ stopIndex
]

{ #category : #accessing }
BrEditorSearchTextItem >> stopIndex: anObject [
	stopIndex := anObject
]

{ #category : #acessing }
BrEditorSearchTextItem >> substring [
	^ self subtext asString
]

{ #category : #acessing }
BrEditorSearchTextItem >> subtext [
	^ self text from: self startIndex to: self stopIndex
]

{ #category : #accessing }
BrEditorSearchTextItem >> text [
	^ text
]

{ #category : #accessing }
BrEditorSearchTextItem >> text: anObject [
	text := anObject
]

{ #category : #accessing }
BrEditorSearchTextItem >> textAttribute [
	<return: #BrEditorSearchTextMark>
	^ textAttribute
]

{ #category : #accessing }
BrEditorSearchTextItem >> textAttribute: aBrEditorSearchTextMark [
	textAttribute := aBrEditorSearchTextMark
]
