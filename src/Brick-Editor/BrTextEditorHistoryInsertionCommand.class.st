Class {
	#name : #BrTextEditorHistoryInsertionCommand,
	#superclass : #BrTextEditorHistoryCommand,
	#instVars : [
		'strings',
		'undoIndices',
		'redoIndices'
	],
	#category : #'Brick-Editor-History'
}

{ #category : #'api - cursors' }
BrTextEditorHistoryInsertionCommand >> cursorForRedoEdit [	
	| cursorPositions |
	cursorPositions := OrderedCollection new.
	
	self strings
		with: self undoIndices
		do: [ :eachString :eachIndex | 
			cursorPositions add: eachIndex + eachString size ].
	
	^ BrTextEditorCursor singleOrMultipleFor: cursorPositions
]

{ #category : #'api - cursors' }
BrTextEditorHistoryInsertionCommand >> cursorForUndoEdit [
	^ BrTextEditorCursor singleOrMultipleFor: self redoIndices
]

{ #category : #printing }
BrTextEditorHistoryInsertionCommand >> gtDisplayOn: aStream [
	
	aStream nextPutAll: 'Insert'.
	strings
		with: undoIndices
		do: [ :eachString :eachIndex |
			aStream
				space;
				print: eachString; space;
				nextPutAll: 'at'; space;
				print: eachIndex;
				nextPut: $, ].
]

{ #category : #accessing }
BrTextEditorHistoryInsertionCommand >> redoIndices [
	^ redoIndices
]

{ #category : #accessing }
BrTextEditorHistoryInsertionCommand >> redoIndices: anObject [
	redoIndices := anObject
]

{ #category : #'api - undo/redo' }
BrTextEditorHistoryInsertionCommand >> redoOn: aBrTextEditor [
	| anInserter |
	
	aBrTextEditor deselecter all deselect.
	
	anInserter := aBrTextEditor inserter.
	self strings
		with: self redoIndices
		do: [ :eachString :eachIndex | 
			anInserter text: eachString; at: eachIndex ].
	anInserter insert
]

{ #category : #'api - undo/redo' }
BrTextEditorHistoryInsertionCommand >> redoTextChangeOn: aBlText [
	aBlText
		insertStrings: self strings
		atAll: self redoIndices.
]

{ #category : #accessing }
BrTextEditorHistoryInsertionCommand >> strings [
	^ strings
]

{ #category : #accessing }
BrTextEditorHistoryInsertionCommand >> strings: anObject [
	strings := anObject
]

{ #category : #accessing }
BrTextEditorHistoryInsertionCommand >> undoIndices [
	^ undoIndices
]

{ #category : #accessing }
BrTextEditorHistoryInsertionCommand >> undoIndices: anObject [
	undoIndices := anObject
]

{ #category : #'api - undo/redo' }
BrTextEditorHistoryInsertionCommand >> undoOn: aBrTextEditor [
	| aDeleter |
	
	aBrTextEditor deselecter all deselect.
	
	aDeleter := aBrTextEditor deleter.
	self strings 
		with: self undoIndices 
		do: [ :eachString :eachIndex | 
			aDeleter from: eachIndex to: eachIndex + eachString size ].
		
	aDeleter delete
]

{ #category : #'api - undo/redo' }
BrTextEditorHistoryInsertionCommand >> undoTextChangeOn: aBlText [
	| toDeleteIntervals |
	
	toDeleteIntervals := self strings 
		with: self undoIndices 
		collect: [ :eachString :eachIndex | 
			eachIndex + 1
				to: eachIndex + eachString size ].
	
	aBlText deleteAll: toDeleteIntervals
]
