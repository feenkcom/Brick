Class {
	#name : #BrGlamorousHeaderLightTheme,
	#superclass : #BrGlamorousHeaderTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousHeaderLightTheme >> initialize [
	super initialize.
	textMarkupColor := BrGlamorousColors textMarkupColor.
	defaultBackgroundColor := BrGlamorousColors
		defaultHeaderBackgroundColor.
	disabledTextColor := BrGlamorousColors disabledHeaderTextColor.
	defaultTextColor := BrGlamorousColors defaultHeaderTextColor.
	secondaryBackgroundColor := BrGlamorousColors
		secondaryHeaderBackgroundColor
]
