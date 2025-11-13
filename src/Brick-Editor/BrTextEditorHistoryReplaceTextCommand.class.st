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
	self setText: newText on: aBrTextEditor
]

{ #category : #accessing }
BrTextEditorHistoryReplaceTextCommand >> setText: aText on: aBrTextEditor [
	aBrTextEditor selecter
		all;
		select.
	aBrTextEditor inserter
		text: aText;
		at: 0;
		insert
]

{ #category : #accessing }
BrTextEditorHistoryReplaceTextCommand >> undoOn: aBrTextEditor [
	self setText: oldText on: aBrTextEditor
]
