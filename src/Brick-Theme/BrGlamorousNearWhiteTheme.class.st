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

	link := BrGlamorousLinkLightTheme theme: self.
	link initializeThemeable.
	status := BrGlamorousStatusNearWhiteTheme theme: self.
	status initializeThemeable.
	default := BrGlamorousDefaultNearWhiteTheme theme: self.
	default initializeThemeable.

	editor := BrGlamorousEditorLightTheme theme: self.
	editor initializeThemeable.

	button := BrGlamorousButtonLightTheme theme: self.
	button initializeThemeable.

	item := BrGlamorousItemTheme theme: self.
	item initializeThemeable.

	header := BrGlamorousHeaderLightTheme theme: self.
	header initializeThemeable.

	label := BrGlamorousLabelTheme theme: self.
	label initializeThemeable
]

{ #category : #initialization }
BrGlamorousNearWhiteTheme >> newColumnedListTheme [
	^ BrColumnedListLightTheme theme: self
]

{ #category : #initialization }
BrGlamorousNearWhiteTheme >> newMarkupTheme [
	^ BrGlamorousMarkupLightTheme theme: self
]
