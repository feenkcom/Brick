Class {
	#name : #BrGlamorousLightThemeColors,
	#superclass : #BrGlamorousThemeColors,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousLightThemeColors >> initialize [
	super initialize.
	
	appBackgroundColor := BrGlamorousColors defaultHeaderBackgroundColor.
	backdropBackgroundColor := BrGlamorousColors backdropColor.
	sidebarBackgroundColor := BrGlamorousColors neutralBackgroundColor.
	contentBackgroundColor := Color white.
	
	primaryTextColor := Color black.
	secondaryTextColor := Color gray.
	tertiaryTextColor := Color gray.
	disabledTextColor := Color gray.
	invertedTextColor := Color white.
]
