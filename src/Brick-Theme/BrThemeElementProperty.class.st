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

	"Failsafe fix to stop the propagation of the theme event in case the element
	already has a theme. In a normal execution this property should not be applied
	on an element in case the theme did not change."
	(anElement userData at: #brickTheme ifAbsent: [ nil ]) == theme ifTrue: [ 
		^ self ].
	
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
