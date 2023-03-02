Class {
	#name : #BrTextEditorHistoryDeletionCommand,
	#superclass : #BrTextEditorHistoryCommand,
	#instVars : [
		'texts',
		'undoIndices',
		'redoIndices'
	],
	#category : #'Brick-Editor-History'
}

{ #category : #'api - cursors' }
BrTextEditorHistoryDeletionCommand >> cursorForRedoEdit [
	| cursorPositions |
	cursorPositions := self undoIndices 
		collect: [ :anIndex | anIndex - 1 ].
	
	^ BrTextEditorCursor singleOrMultipleFor: cursorPositions 
]

{ #category : #'api - cursors' }
BrTextEditorHistoryDeletionCommand >> cursorForUndoEdit [
	| cursorPositions |
	cursorPositions := OrderedCollection new.
	self texts
		with: self redoIndices
		do: [ :eachText :eachIndex | 
			cursorPositions add: eachIndex + eachText size - 1 ].
			
	^ BrTextEditorCursor singleOrMultipleFor: cursorPositions 
]

{ #category : #printing }
BrTextEditorHistoryDeletionCommand >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Delete'.
	texts
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
BrTextEditorHistoryDeletionCommand >> redoIndices [
	^ redoIndices
]

{ #category : #accessing }
BrTextEditorHistoryDeletionCommand >> redoIndices: anObject [
	redoIndices := anObject
]

{ #category : #'api - undo/redo' }
BrTextEditorHistoryDeletionCommand >> redoOn: aBrTextEditor [
	| aDeleter |
	aBrTextEditor deselecter all deselect.
	
	aDeleter := aBrTextEditor deleter.
	texts
		with: redoIndices
		do: [ :eachText :eachIndex | 
			aDeleter 
				from: eachIndex - 1 
				to: eachIndex - 1 + eachText size ].

	aDeleter delete
]

{ #category : #'api - undo/redo' }
BrTextEditorHistoryDeletionCommand >> redoTextChangeOn: aBlText [
	| toDeleteIntervals |
	
	toDeleteIntervals := self texts 
		with: self undoIndices 
		collect: [ :eachString :eachIndex | 
			eachIndex
				to: eachIndex + eachString size - 1 ].

	aBlText deleteAll: toDeleteIntervals
]

{ #category : #accessing }
BrTextEditorHistoryDeletionCommand >> texts [
	^ texts
]

{ #category : #accessing }
BrTextEditorHistoryDeletionCommand >> texts: anObject [
	texts := anObject
]

{ #category : #accessing }
BrTextEditorHistoryDeletionCommand >> undoIndices [
	^ undoIndices
]

{ #category : #accessing }
BrTextEditorHistoryDeletionCommand >> undoIndices: anObject [
	undoIndices := anObject
]

{ #category : #'api - undo/redo' }
BrTextEditorHistoryDeletionCommand >> undoOn: aBrTextEditor [
	| anInserter |

	aBrTextEditor deselecter all deselect.

	anInserter := aBrTextEditor inserter.
	self texts
		with: self undoIndices
		do: [ :eachText :eachIndex | 
			anInserter
				text: eachText characters asString;
				at: eachIndex - 1 ].
	
	anInserter insert
]

{ #category : #'api - undo/redo' }
BrTextEditorHistoryDeletionCommand >> undoTextChangeOn: aBlText [
	aBlText
		insertStrings: (self texts collect: [ :aText |
			aText characters asString ])
		atAll: (self redoIndices collect: [ :anIndex |
			anIndex - 1 ])
]
