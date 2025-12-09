"
I am {{gtClass:BrEditorSearchTextPattern}}. 
I search substrings in a given {{gtClass:BlText}}. 
"
Class {
	#name : #BrEditorSearchTextSubstringPattern,
	#superclass : #BrEditorSearchTextPattern,
	#instVars : [
		'text',
		'string'
	],
	#category : #'Brick-Editor - Search Model'
}

{ #category : #'api - search' }
BrEditorSearchTextSubstringPattern >> findAllIndexesIn: aText [
	<return: #Array of: #BrEditorSearchTextItem>
	| allIndexes anOffset |
	allIndexes := aText finder
		caseInsensitiveSubstring: self string;
		searchAll.
	anOffset := aText textOffset.
		
	^ allIndexes withIndexCollect: [ :aStart :anIndex |
		| aStop |
		aStop := aStart + self string size - 1.
		BrEditorSearchTextItem new 
			text: aText;
			pattern: self;
			index: anIndex;
			startIndex: aStart;
			stopIndex: aStop;
			absoluteStartIndex: anOffset + aStart;
			absoluteStopIndex: anOffset + aStop ]
]

{ #category : #printing }
BrEditorSearchTextSubstringPattern >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Substring: ';
		print: self text
]

{ #category : #printing }
BrEditorSearchTextSubstringPattern >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self text;
		nextPut: $)
]

{ #category : #private }
BrEditorSearchTextSubstringPattern >> string [
	^ string ifNil: [ string := self text ifNotNil: #asString ]
]

{ #category : #accessing }
BrEditorSearchTextSubstringPattern >> text [
	^ text
]

{ #category : #accessing }
BrEditorSearchTextSubstringPattern >> text: aBlText [
	text := aBlText.
	string := nil
]
