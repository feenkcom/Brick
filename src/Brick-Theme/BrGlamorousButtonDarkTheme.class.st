Class {
	#name : #BrGlamorousButtonDarkTheme,
	#superclass : #BrGlamorousButtonTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousButtonDarkTheme >> initializeColors [
	super initializeColors.

	disabledTextColor := Color gray.

	disabledBorderColor := Color gray.

	defaultBorderColor := Color gray.

	defaultTextColor := Color white
]

{ #category : #initialization }
BrGlamorousButtonDarkTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #disabledBackgroundColor put: Color veryDarkGray.
	self
		constantAt: #disabledTextColor
		put: BrGlamorousColors disabledButtonTextColor.
	self
		constantAt: #disabledBorderColor
		put: BrGlamorousColors disabledButtonBorderColor.
	self constantAt: #defaultBackground put: Color veryDarkGray
]

{ #category : #initialization }
BrGlamorousButtonDarkTheme >> initializeThemeable [
	super initializeThemeable
]
