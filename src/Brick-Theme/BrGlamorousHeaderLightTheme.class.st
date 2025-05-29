Class {
	#name : #BrGlamorousHeaderLightTheme,
	#superclass : #BrGlamorousHeaderTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousHeaderLightTheme >> initializeColors [
	super initializeColors.
	
	defaultBackgroundColor := BrGlamorousColors defaultHeaderBackgroundColor.
	secondaryBackgroundColor := BrGlamorousColors secondaryHeaderBackgroundColor.

	textMarkupColor := BrGlamorousColors textMarkupColor.
	
	disabledTextColor := BrGlamorousColors disabledHeaderTextColor.
	defaultTextColor := BrGlamorousColors defaultHeaderTextColor.
]
