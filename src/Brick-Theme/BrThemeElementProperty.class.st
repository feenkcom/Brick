Class {
	#name : #BrThemeElementProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'theme'
	],
	#category : #'Brick-Theme-Core'
}

{ #category : #accessing }
BrThemeElementProperty >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ theme = anObject theme
]

{ #category : #accessing }
BrThemeElementProperty >> applyOnElement: anElement [
	anElement userData at: #brickTheme put: theme.	
	anElement dispatchEvent: BrThemeChanged new.
]

{ #category : #accessing }
BrThemeElementProperty >> canPropagateToChildren [
	^ true
]

{ #category : #accessing }
BrThemeElementProperty >> hash [
	^ theme hash
]

{ #category : #accessing }
BrThemeElementProperty >> theme [
	^ theme
]

{ #category : #accessing }
BrThemeElementProperty >> theme: aTheme [
	theme := aTheme
]
