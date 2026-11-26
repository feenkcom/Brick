Class {
	#name : #BrGlamorousStatusDarkTheme,
	#superclass : #BrGlamorousStatusTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousStatusDarkTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #neutralBackgroundColor put: BrAntColors gray7.
	self constantAt: #neutralBorderColor put: BrAntColors gray5.

	self constantAt: #successBackgroundColor put: BrAntColors darkGreen4.
	self constantAt: #successBorderColor put: BrAntColors darkGreen5.

	self constantAt: #errorBackgroundColor put: BrAntColors darkRed4.
	self constantAt: #errorBorderColor put: BrAntColors red6.

	self constantAt: #paleErrorBackgroundColor put: BrAntColors darkRed3.

	self constantAt: #failureBackgroundColor put: BrAntColors orange6.
	self constantAt: #failureBorderColor put: BrAntColors orange4.

	self constantAt: #changesBackgroundColor put: BrAntColors orange4
]
