Class {
	#name : #BrGlamorousLightThemeColors,
	#superclass : #BrGlamorousThemeColors,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousLightThemeColors >> initialize [
	super initialize.

	primaryTextColor := Color black.
	secondaryTextColor := Color gray.
	tertiaryTextColor := Color gray.
	disabledTextColor := Color gray.
	invertedTextColor := Color white.
	appBackgroundColor := BrGlamorousColors defaultHeaderBackgroundColor.
	backdropBackgroundColor := BrGlamorousColors backdropColor.
	sidebarBackgroundColor := BrGlamorousColors neutralBackgroundColor.
	contentBackgroundColor := Color white.
	groupBackgroundColor := nil.
	raisedBackgroundColor := nil.
	floatBackgroundColor := nil.
	sidebarTextColor := Color black.
]
