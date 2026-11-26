Class {
	#name : #BrGlamorousStatusLightTheme,
	#superclass : #BrGlamorousStatusTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousStatusLightTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #successBackgroundColor
		put: BrGlamorousColors successBackgroundColor.
	self constantAt: #successBorderColor put: BrGlamorousColors successBorderColor.
	self
		constantAt: #neutralBackgroundColor
		put: BrGlamorousColors neutralBackgroundColor.
	self constantAt: #neutralBorderColor put: BrAntColors gray6.
	self constantAt: #errorBorderColor put: BrGlamorousColors errorBorderColor.
	self
		constantAt: #errorBackgroundColor
		put: BrGlamorousColors errorBackgroundColor.
	self constantAt: #failureBorderColor put: BrGlamorousColors failureBorderColor.
	self
		constantAt: #paleErrorBackgroundColor
		put: BrGlamorousColors paleErrorBackgroundColor.
	self
		constantAt: #failureBackgroundColor
		put: BrGlamorousColors failureBackgroundColor.
	self
		constantAt: #changesBackgroundColor
		put: BrGlamorousColors failureBackgroundColor
]
