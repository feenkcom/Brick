Class {
	#name : #BrGlamorousDarkThemeColors,
	#superclass : #BrGlamorousThemeColors,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousDarkThemeColors >> initialize [
	super initialize.
	
	"surfaces"
	appBackgroundColor := Color fromHexString: '#1A1A1A'.
	backdropBackgroundColor := Color fromHexString: '#262626'.
	sidebarBackgroundColor := Color fromHexString: '#262626'.
	contentBackgroundColor := Color fromHexString: '#333333'.
	
	"text"
	primaryTextColor := Color fromHexString: '#EAEAEA'.
	secondaryTextColor := Color fromHexString: '#B3B3B3'.
	tertiaryTextColor := Color fromHexString: '#8A8A8A'.
	disabledTextColor := Color fromHexString: '#666666'.
	invertedTextColor := Color fromHexString: '#1A1A1A'.
	
	
]
