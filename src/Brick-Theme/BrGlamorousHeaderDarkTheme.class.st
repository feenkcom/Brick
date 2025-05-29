Class {
	#name : #BrGlamorousHeaderDarkTheme,
	#superclass : #BrGlamorousHeaderTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousHeaderDarkTheme >> initializeColors [
	super initializeColors.
	
	defaultBackgroundColor := Color veryVeryDarkGray slightlyDarker.
	secondaryBackgroundColor := Color black.
	
	defaultTextColor := Color white.
	disabledTextColor := Color gray.
	textMarkupColor := Color gray.
]
