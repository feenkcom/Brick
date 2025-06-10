Class {
	#name : #BrGlamorousHeaderLightTheme,
	#superclass : #BrGlamorousHeaderTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousHeaderLightTheme >> initializeColors [
	super initializeColors.

	textMarkupColor := BrGlamorousColors textMarkupColor.

	defaultBackgroundColor := BrGlamorousColors defaultHeaderBackgroundColor.

	disabledTextColor := BrGlamorousColors disabledHeaderTextColor.

	defaultTextColor := BrGlamorousColors defaultHeaderTextColor.

	secondaryBackgroundColor := BrGlamorousColors secondaryHeaderBackgroundColor
]

{ #category : #initialization }
BrGlamorousHeaderLightTheme >> initializeConstants [
	super initializeConstants
]

{ #category : #initialization }
BrGlamorousHeaderLightTheme >> initializeThemeable [
	super initializeThemeable
]
