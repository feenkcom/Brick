Class {
	#name : #BrGlamorousHeaderDarkTheme,
	#superclass : #BrGlamorousHeaderTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousHeaderDarkTheme >> initializeColors [
	super initializeColors.

	defaultBackgroundColor := Color veryVeryDarkGray slightlyDarker.

	disabledTextColor := Color gray.

	defaultTextColor := Color white.

	secondaryBackgroundColor := Color black.


]

{ #category : #initialization }
BrGlamorousHeaderDarkTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #textMarkupColor put: (Color gray).

]

{ #category : #initialization }
BrGlamorousHeaderDarkTheme >> initializeThemeable [
	super initializeThemeable.

	textMarkupColor := self
	color: [ :aTheme | aTheme header constantAt: #textMarkupColor ]
	source: [ :aTheme | aTheme header textMarkupColor ].


]
