Class {
	#name : #BrGlamorousHeaderDarkTheme,
	#superclass : #BrGlamorousHeaderTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousHeaderDarkTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #textMarkupColor put: Color gray.
	self constantAt: #defaultBackgroundColor put: BrAntColors gray9.
	self constantAt: #disabledTextColor put: Color gray.
	self constantAt: #defaultTextColor put: Color white.
	self constantAt: #secondaryBackgroundColor put: BrAntColors gray11
]
