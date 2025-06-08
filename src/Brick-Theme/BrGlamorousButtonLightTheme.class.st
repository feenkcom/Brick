Class {
	#name : #BrGlamorousButtonLightTheme,
	#superclass : #BrGlamorousButtonTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousButtonLightTheme >> initializeColors [
	super initializeColors.

	defaultBorderColor := BrGlamorousColors defaultButtonBorderColor.

	defaultTextColor := BrGlamorousColors defaultButtonTextColor
]

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
	self constantAt: #defaultBackground put: Color white
]

{ #category : #initialization }
BrGlamorousButtonLightTheme >> initializeThemeable [
	super initializeThemeable.

	disabledTextColor := self
			color: [ :aTheme | aTheme button constantAt: #disabledTextColor ]
			source: [ :aTheme | aTheme button disabledTextColor ].

	disabledBorderColor := self
			color: [ :aTheme | aTheme button constantAt: #disabledBorderColor ]
			source: [ :aTheme | aTheme button disabledBorderColor ]
]
