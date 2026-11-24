Class {
	#name : #BrGlamorousButtonDarkTheme,
	#superclass : #BrGlamorousButtonTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousButtonDarkTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #disabledBackgroundColor put: BrAntColors gray8.
	self constantAt: #disabledTextColor put: BrAntColors gray7.
	self constantAt: #disabledBorderColor put: BrAntColors gray8.
	self constantAt: #defaultBackground put: BrAntColors gray9.
	self constantAt: #fadedBackgroundColor put: BrAntColors gray7.
	self constantAt: #defaultBorderColor put: BrAntColors gray8.
	self constantAt: #defaultTextColor put: BrAntColors gray3.
	self constantAt: #hoveredBorderColor put: BrAntColors blue4.
	self constantAt: #hoveredTextColor put: BrAntColors blue4.
	self constantAt: #pressedBorderColor put: BrAntColors blue2.
	self constantAt: #pressedTextColor put: BrAntColors blue2.
	self constantAt: #textHighlightColor put: BrGlamorousColors textHighlightColor.
	self constantAt: #focusedFadedBackgroundColor put: BrAntColors blue4
]
