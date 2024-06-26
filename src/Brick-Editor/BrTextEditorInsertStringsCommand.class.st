Class {
	#name : #BrTextEditorInsertStringsCommand,
	#superclass : #BrTextEditorCommand,
	#instVars : [
		'strings',
		'indices'
	],
	#category : 'Brick-Editor-Commands'
}

{ #category : #executing }
BrTextEditorInsertStringsCommand >> executeOn: aTextEditor [

	aTextEditor text
		insertStrings: self strings
		atAll: self indices
]

{ #category : #accessing }
BrTextEditorInsertStringsCommand >> indices [
	^ indices
]

{ #category : #accessing }
BrTextEditorInsertStringsCommand >> indices: anObject [
	indices := anObject
]

{ #category : #printing }
BrTextEditorInsertStringsCommand >> printOn: aStream [
	aStream
		nextPutAll: 'Inserted'.
	
	self strings with: self indices do: [ :aString :anIndex |
		aStream
			space;
			print: aString;
			nextPutAll: ' at ';
			print: anIndex ]
]

{ #category : #accessing }
BrTextEditorInsertStringsCommand >> strings [
	^ strings
]

{ #category : #accessing }
BrTextEditorInsertStringsCommand >> strings: anObject [
	strings := anObject
]
