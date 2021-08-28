Class {
	#name : 'BrTextEditorTextStyledEvent',
	#superclass : 'BrTextEditorEvent',
	#instVars : [
		'styledText'
	],
	#category : 'Brick-Editor-Model - Events'
}

{ #category : 'accessing' }
BrTextEditorTextStyledEvent >> styledText [
	^ styledText
]

{ #category : 'accessing' }
BrTextEditorTextStyledEvent >> styledText: anObject [
	styledText := anObject
]
