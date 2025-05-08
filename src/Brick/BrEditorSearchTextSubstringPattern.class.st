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
	| allIndexes |
	allIndexes := aText finder
		caseInsensitiveSubstring: self string;
		searchAll.
		
	^ allIndexes collect: [ :aStart |
		BrEditorSearchTextPatternItem new 
			text: aText;
			pattern: self;
			startIndex: aStart;
			stopIndex: aStart + self string size - 1 ]
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
