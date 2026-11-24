Class {
	#name : #BrGlamorousButtonLightTheme,
	#superclass : #BrGlamorousButtonTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousButtonLightTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #disabledBackgroundColor put: (Color fromHexString: #f5f5f5).
	self
		constantAt: #disabledTextColor
		put: BrGlamorousColors disabledButtonTextColor.
	self
		constantAt: #disabledBorderColor
		put: BrGlamorousColors disabledButtonBorderColor.
	self constantAt: #defaultBackground put: Color white.
	self
		constantAt: #defaultBorderColor
		put: BrGlamorousColors defaultButtonBorderColor.
	self
		constantAt: #defaultTextColor
		put: BrGlamorousColors defaultButtonTextColor
]
