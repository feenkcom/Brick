Class {
	#name : #BrTextEditorHistoryReplaceTextCommand,
	#superclass : #BrTextEditorHistoryCommand,
	#instVars : [
		'newText',
		'oldText'
	],
	#category : #'Brick-Editor-History'
}

{ #category : #accessing }
BrTextEditorHistoryReplaceTextCommand >> newText: aText [
	newText := aText
]

{ #category : #accessing }
BrTextEditorHistoryReplaceTextCommand >> oldText: aText [
	oldText := aText
]

{ #category : #accessing }
BrTextEditorHistoryReplaceTextCommand >> redoOn: aBrTextEditor [
	aBrTextEditor text: newText
]

{ #category : #accessing }
BrTextEditorHistoryReplaceTextCommand >> undoOn: aBrTextEditor [
	aBrTextEditor text: oldText
]
