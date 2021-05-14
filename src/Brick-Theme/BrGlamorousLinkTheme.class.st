Class {
	#name : #BrGlamorousLinkTheme,
	#superclass : #BrTheme,
	#instVars : [
		'color',
		'errorColor'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousLinkTheme >> color [
	^ color
]

{ #category : #accessing }
BrGlamorousLinkTheme >> color: anObject [
	color := anObject
]

{ #category : #accessing }
BrGlamorousLinkTheme >> errorColor [
	^ errorColor
]

{ #category : #accessing }
BrGlamorousLinkTheme >> errorColor: anObject [
	errorColor := anObject
]

{ #category : #initialization }
BrGlamorousLinkTheme >> initialize [
	super initialize.
	color := BrGlamorousColors linkColor.
	errorColor := BrGlamorousColors linkWithErrorColor
]
