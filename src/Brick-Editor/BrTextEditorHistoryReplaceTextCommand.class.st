Class {
	#name : #BrTextEditorHistoryReplaceTextCommand,
	#superclass : #BrTextEditorHistoryCommand,
	#instVars : [
		'newText',
		'oldText'
	],
	#category : #'Brick-Editor-History'
}

{ #category : #printing }
BrTextEditorHistoryReplaceTextCommand >> gtDisplayOn: aStream [
	
	aStream 
		<< 'Replace'; space;
		<< ''''; print: oldText; << ''''; space;
		<< 'with'; space;
		<< ''''; print: newText; << ''''
]

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
