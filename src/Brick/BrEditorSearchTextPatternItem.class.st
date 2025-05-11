Class {
	#name : #BrEditorSearchTextPatternItem,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'startIndex',
		'stopIndex',
		'text',
		'isSelected',
		'absoluteStartIndex',
		'absoluteStopIndex',
		'textAttribute'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #accessing }
BrEditorSearchTextPatternItem >> absoluteStartIndex [
	^ absoluteStartIndex
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> absoluteStartIndex: anInteger [
	absoluteStartIndex := anInteger
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> absoluteStopIndex [
	^ absoluteStopIndex
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> absoluteStopIndex: anObject [
	absoluteStopIndex := anObject
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> isSelected [
	^ isSelected ifNil: [ false ]
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> isSelected: aBoolean [
	isSelected := aBoolean
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> pattern [
	^ pattern
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> pattern: anObject [
	pattern := anObject
]

{ #category : #printing }
BrEditorSearchTextPatternItem >> printOn: aStream [
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
BrEditorSearchTextPatternItem >> startIndex [
	^ startIndex
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> startIndex: anObject [
	startIndex := anObject
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> stopIndex [
	^ stopIndex
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> stopIndex: anObject [
	stopIndex := anObject
]

{ #category : #acessing }
BrEditorSearchTextPatternItem >> substring [
	^ self subtext asString
]

{ #category : #acessing }
BrEditorSearchTextPatternItem >> subtext [
	^ self text from: self startIndex to: self stopIndex
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> text [
	^ text
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> text: anObject [
	text := anObject
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> textAttribute [
	<return: #BrEditorSearchTextMark>
	^ textAttribute
]

{ #category : #accessing }
BrEditorSearchTextPatternItem >> textAttribute: aBrEditorSearchTextMark [
	textAttribute := aBrEditorSearchTextMark
]
