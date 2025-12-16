Class {
	#name : #BrSearchSubstringPattern,
	#superclass : #BrSearchPattern,
	#instVars : [
		'text',
		'string'
	],
	#category : #'Brick-List - Search Model'
}

{ #category : #'api - search' }
BrSearchSubstringPattern >> findAllIndexesInText: aText [
	"Return all index interval (start and stop positions) 
	of a given pattern (e.g., substring) in a given aText."

	<return: #Array of: #BrSearchFoundTextItem>
	| allIndexes anOffset |
	allIndexes := aText finder
			caseInsensitiveSubstring: self string;
			searchAll.
	anOffset := aText textOffset.

	^ allIndexes
		withIndexCollect: [ :aStart :anIndex | 
			| aStop |
			aStop := aStart + self string size - 1.
			BrSearchFoundTextItem new
				text: aText;
				pattern: self;
				index: anIndex;
				startIndex: aStart;
				stopIndex: aStop;
				absoluteStartIndex: anOffset + aStart;
				absoluteStopIndex: anOffset + aStop ]
]

{ #category : #printing }
BrSearchSubstringPattern >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Substring: ';
		print: self text
]

{ #category : #printing }
BrSearchSubstringPattern >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self text;
		nextPut: $)
]

{ #category : #accessing }
BrSearchSubstringPattern >> string [
	^ string ifNil: [ string := self text ifNotNil: #asString ]
]

{ #category : #accessing }
BrSearchSubstringPattern >> text [
	^ text
]

{ #category : #accessing }
BrSearchSubstringPattern >> text: aBlText [
	text := aBlText
]
