Class {
	#name : #BrGlamorousHeaderDarkTheme,
	#superclass : #BrGlamorousHeaderTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousHeaderDarkTheme >> initialize [
	super initialize.
	
	defaultBackgroundColor := Color darkGray.
	secondaryBackgroundColor := Color black.
	
	defaultTextColor := Color white.
	disabledTextColor := Color gray.
	textMarkupColor := Color gray.
]
