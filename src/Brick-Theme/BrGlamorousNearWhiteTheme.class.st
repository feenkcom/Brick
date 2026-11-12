"
A light Glamorous theme with a near-white canvas and white content panes. Use this theme explicitly on an element to keep the surrounding interface quiet while preserving content colors.
"
Class {
	#name : #BrGlamorousNearWhiteTheme,
	#superclass : #BrGlamorousTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #testing }
BrGlamorousNearWhiteTheme class >> canBeDefault [
	"This theme is selected explicitly rather than by automatic default discovery."

	^ false
]

{ #category : #initialization }
BrGlamorousNearWhiteTheme >> initialize [
	super initialize.

	colors := BrGlamorousWhiteThemeColors theme: self.

	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.
	default := BrGlamorousDefaultLightTheme theme: self.
	default initializeThemeable.

	editor := BrGlamorousEditorLightTheme theme: self.
	editor initializeThemeable.

	button := BrGlamorousButtonLightTheme theme: self.
	button initializeThemeable.

	item := BrGlamorousItemTheme new.

	header := BrGlamorousHeaderLightTheme theme: self.
	header initializeThemeable.

	label := BrGlamorousLabelTheme theme: self.
	label initializeThemeable
]
