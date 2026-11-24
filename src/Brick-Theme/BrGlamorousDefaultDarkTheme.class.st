Class {
	#name : #BrGlamorousDefaultDarkTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousDefaultDarkTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #defaultShadowColor put: BrAntColors gray7.
	self constantAt: #primaryBorderColor put: BrGlamorousColors primaryBorderColor
]
