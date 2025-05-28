Class {
	#name : #BrGlamorousButtonDarkTheme,
	#superclass : #BrGlamorousButtonTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousButtonDarkTheme >> initializeColors [
	super initializeColors.

	"default state"
	defaultBackgroundColor := Color black.
	defaultTextColor := Color white.
	defaultBorderColor := Color gray.

	"disabled state"
	disabledBackgroundColor := Color black.
	disabledTextColor := Color gray.
	disabledBorderColor := Color gray.
]
