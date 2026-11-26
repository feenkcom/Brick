Class {
	#name : #BrGlamorousLinkDarkTheme,
	#superclass : #BrGlamorousLinkTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousLinkDarkTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #color put: BrAntColors blue3.
	self constantAt: #errorColor put: BrAntColors red3
]
