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
		put: BrGlamorousColors defaultButtonTextColor.
	self
		constantAt: #pressedBorderColor
		put: BrGlamorousColors pressedButtonBorderColor.
	self
		constantAt: #hoveredBorderColor
		put: BrGlamorousColors hoveredButtonBorderColor.
	self
		constantAt: #pressedTextColor
		put: BrGlamorousColors pressedButtonTextColor.
	self
		constantAt: #hoveredTextColor
		put: BrGlamorousColors hoveredButtonTextColor.
	self constantAt: #textHighlightColor put: BrGlamorousColors textHighlightColor.
	self
		constantAt: #fadedBackgroundColor
		put: BrGlamorousColors fadedButtonBackgroundColor.
	self
		constantAt: #focusedFadedBackgroundColor
		put: BrGlamorousColors hoveredButtonBorderColor
]
