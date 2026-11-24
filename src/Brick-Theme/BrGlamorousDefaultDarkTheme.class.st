Class {
	#name : #BrGlamorousDefaultDarkTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousDefaultDarkTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #defaultShadowColor put: BrAntColors gray8.
	self constantAt: #primaryBorderColor put: BrGlamorousColors primaryBorderColor.
	self constantAt: #appBackground put: BrAntColors gray8
]
