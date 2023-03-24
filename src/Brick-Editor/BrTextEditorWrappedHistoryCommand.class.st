"
{{gtClass:BrTextEditorWrappedHistoryCommand}} wraps a {{gtClass:BrTextEditorHistoryCommand}} command and either executes the undo or redo action on that command. This exists so that places that need to react to undo/redo actions can just get a wrapped actions and do not have to check if they should execute the undo or redo logic.
"
Class {
	#name : #BrTextEditorWrappedHistoryCommand,
	#superclass : #Object,
	#instVars : [
		'targetCommand',
		'shouldApplyUndo'
	],
	#category : #'Brick-Editor-History'
}

{ #category : #'instance creation' }
BrTextEditorWrappedHistoryCommand class >> forCommand: aCommand [
	^ self new 
		targetCommand: aCommand
]

{ #category : #execution }
BrTextEditorWrappedHistoryCommand >> applyOn: aBrTextEditor [
	^ self shouldApplyUndo 
		ifTrue: [ self applyUndoOn:  aBrTextEditor ] 
		ifFalse: [ self applyRedoOn: aBrTextEditor ]
]

{ #category : #execution }
BrTextEditorWrappedHistoryCommand >> applyRedoOn: aBrTextEditor [ 
	^ self targetCommand redoOn: aBrTextEditor
]

{ #category : #execution }
BrTextEditorWrappedHistoryCommand >> applyRedoTextChangeOn: aText [ 
	^ self targetCommand redoTextChangeOn: aText
]

{ #category : #execution }
BrTextEditorWrappedHistoryCommand >> applyTextChangeOn: aText [
	^ self shouldApplyUndo 
		ifTrue: [ self applyUndoTextChangeOn:  aText ] 
		ifFalse: [ self applyRedoTextChangeOn: aText ]
]

{ #category : #execution }
BrTextEditorWrappedHistoryCommand >> applyUndoOn: aBrTextEditor [ 
	^ self targetCommand undoOn: aBrTextEditor
]

{ #category : #execution }
BrTextEditorWrappedHistoryCommand >> applyUndoTextChangeOn: aText [ 
	^ self targetCommand undoTextChangeOn: aText
]

{ #category : #accessing }
BrTextEditorWrappedHistoryCommand >> markForUndo [
	shouldApplyUndo := true
]

{ #category : #testing }
BrTextEditorWrappedHistoryCommand >> shouldApplyUndo [
	^ shouldApplyUndo ifNil: [ false ]
]

{ #category : #accessing }
BrTextEditorWrappedHistoryCommand >> targetCommand [
	^ targetCommand
]

{ #category : #accessing }
BrTextEditorWrappedHistoryCommand >> targetCommand: anObject [
	targetCommand := anObject
]
