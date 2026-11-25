Class {
	#name : #BrGlamorousLightTheme,
	#superclass : #BrGlamorousTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousLightTheme class >> canBeDefault [
	^ true
]

{ #category : #'as yet unclassified' }
BrGlamorousLightTheme >> initialize [
	super initialize.

	colors := BrGlamorousLightThemeColors theme: self.

	link := BrGlamorousLinkTheme theme: self.
	link initializeThemeable.
	status := BrGlamorousStatusTheme theme: self.
	status initializeThemeable.
	default := BrGlamorousDefaultLightTheme theme: self.
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

{ #category : #'instance creation' }
BrGlamorousLightTheme >> newColumnedListTheme [
	^ BrColumnedListLightTheme theme: self
]
