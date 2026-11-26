Class {
	#name : #BrGlamorousLinkLightTheme,
	#superclass : #BrGlamorousLinkTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousLinkLightTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #color put: BrGlamorousColors linkColor.
	self constantAt: #errorColor put: BrGlamorousColors linkWithErrorColor
]
