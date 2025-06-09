Class {
	#name : #BrGlamorousDarkThemeColors,
	#superclass : #BrGlamorousThemeColors,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousDarkThemeColors >> initialize [
	super initialize.

	primaryTextColor := Color fromHexString: '#EAEAEA'.
	secondaryTextColor := Color fromHexString: '#B3B3B3'.
	tertiaryTextColor := Color fromHexString: '#8A8A8A'.
	disabledTextColor := Color fromHexString: '#666666'.
	invertedTextColor := Color fromHexString: '#1A1A1A'.
	appBackgroundColor := Color fromHexString: '#1A1A1A'.
	backdropBackgroundColor := Color fromHexString: '#262626'.
	sidebarBackgroundColor := Color fromHexString: '#333333'.
	contentBackgroundColor := Color fromHexString: '#262626'.
	groupBackgroundColor := nil.
	raisedBackgroundColor := nil.
	floatBackgroundColor := nil.
	sidebarTextColor := Color fromHexString: '#CFCFCF'.
]
