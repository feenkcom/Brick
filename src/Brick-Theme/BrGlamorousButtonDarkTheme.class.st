Class {
	#name : #BrGlamorousButtonDarkTheme,
	#superclass : #BrGlamorousButtonTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousButtonDarkTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #disabledBackgroundColor put: Color veryDarkGray.
	self
		constantAt: #disabledTextColor
		put: BrGlamorousColors disabledButtonTextColor.
	self constantAt: #disabledBorderColor put: Color gray.
	self constantAt: #defaultBackground put: Color veryDarkGray.
	self constantAt: #fadedBackgroundColor put: BrAntColors gray6
]
