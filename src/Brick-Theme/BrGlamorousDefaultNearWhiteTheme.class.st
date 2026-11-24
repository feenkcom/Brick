Class {
	#name : #BrGlamorousDefaultNearWhiteTheme,
	#superclass : #BrGlamorousDefaultLightTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousDefaultNearWhiteTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #appBackground put: Color white
]
