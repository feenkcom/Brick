Class {
	#name : #BrGlamorousEditorTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'borderColor',
		'focusedBorderColor',
		'defaultTextForeground'
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

{ #category : #'as yet unclassified' }
BrGlamorousEditorTheme >> defaultTextForeground [
	^ defaultTextForeground
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

{ #category : #'as yet unclassified' }
BrGlamorousEditorTheme >> initializeTheme [
	super initializeTheme.
	
	defaultTextForeground := self
		color: [ :aTheme | aTheme colors primaryTextColor ]
		source: [ :aTheme | aTheme editor defaultTextForeground ]
]
