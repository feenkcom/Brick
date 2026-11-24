Class {
	#name : #BrGlamorousDefaultLightTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousDefaultLightTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #appBackground
		put: BrGlamorousColors defaultHeaderBackgroundColor
]
