"
The neutral palette for BrGlamorousNearWhiteTheme: white application and content surfaces with a near-white backdrop.
"
Class {
	#name : #BrGlamorousWhiteThemeColors,
	#superclass : #BrGlamorousThemeColors,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousWhiteThemeColors >> initialize [
	super initialize.

	primaryTextColor := Color black.
	secondaryTextColor := Color gray.
	tertiaryTextColor := Color gray.
	disabledTextColor := Color gray.
	invertedTextColor := Color white.
	appBackgroundColor := Color white.
	backdropBackgroundColor := Color fromHexString: '#FAFAFA'.
	backdropEmphasisBackgroundColor := Color fromHexString: '#D9D9D9'.
	sidebarBackgroundColor := BrGlamorousColors neutralBackgroundColor.
	contentBackgroundColor := Color white.
	groupBackgroundColor := nil.
	raisedBackgroundColor := nil.
	floatBackgroundColor := nil.
	sidebarTextColor := Color black
]
