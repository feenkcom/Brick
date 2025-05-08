Class {
	#name : #BrEditorSearchTextSubstringPattern,
	#superclass : #BrEditorSearchTextPattern,
	#instVars : [
		'text',
		'string'
	],
	#category : #'Brick-Editor - Search'
}

{ #category : #'api - search' }
BrEditorSearchTextSubstringPattern >> findAllIndexesIn: aText [
	<return: #Array of: #BrEditorSearchTextPatternItem>
	| allIndexes anOffset |
	allIndexes := aText finder
		caseInsensitiveSubstring: self string;
		searchAll.
	anOffset := aText textOffset.
		
	^ allIndexes collect: [ :aStart |
		| aStop |
		aStop := aStart + self string size - 1.
		BrEditorSearchTextPatternItem new 
			text: aText;
			pattern: self;
			startIndex: aStart;
			stopIndex: aStop;
			absoluteStartIndex: anOffset + aStart;
			absoluteStopIndex: anOffset + aStop ]
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
