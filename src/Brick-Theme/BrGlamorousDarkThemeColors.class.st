Class {
	#name : #BrGlamorousDarkThemeColors,
	#superclass : #BrGlamorousThemeColors,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousDarkThemeColors >> initialize [
	super initialize.

	primaryTextColor := BrAntColors gray1.
	secondaryTextColor := Color fromHexString: '#B3B3B3'.
	tertiaryTextColor := Color fromHexString: '#8A8A8A'.
	disabledTextColor := Color fromHexString: '#666666'.
	invertedTextColor := Color fromHexString: '#1A1A1A'.
	groupBackgroundColor := nil.
	raisedBackgroundColor := nil.
	floatBackgroundColor := nil.
	sidebarTextColor := Color fromHexString: '#CFCFCF'
]
