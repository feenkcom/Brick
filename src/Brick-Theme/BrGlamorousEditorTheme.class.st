Class {
	#name : #BrGlamorousEditorTheme,
	#superclass : #BrTheme,
	#instVars : [
		'borderColor',
		'focusedBorderColor'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousEditorTheme >> borderColor [
	^ borderColor
]

{ #category : #accessing }
BrGlamorousEditorTheme >> borderColor: anObject [
	borderColor := anObject
]

{ #category : #accessing }
BrGlamorousEditorTheme >> focusedBorderColor [
	^ focusedBorderColor
]

{ #category : #accessing }
BrGlamorousEditorTheme >> focusedBorderColor: anObject [
	focusedBorderColor := anObject
]

{ #category : #initialization }
BrGlamorousEditorTheme >> initialize [
	super initialize.
	borderColor := BrGlamorousColors editorBorderColor.
	focusedBorderColor := BrGlamorousColors focusedEditorBorderColor
]
