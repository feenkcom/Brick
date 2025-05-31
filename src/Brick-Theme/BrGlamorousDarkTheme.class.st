Class {
	#name : #BrGlamorousDarkTheme,
	#superclass : #BrGlamorousTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousDarkTheme >> initialize [
	super initialize.

	colors := BrGlamorousDarkThemeColors theme: self.
	
	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.

	default := BrGlamorousDefaultDarkTheme theme: self.
	default initializeThemeable.
	
	editor := BrGlamorousEditorTheme theme: self.
	editor initializeThemeable.
	
	button := BrGlamorousButtonDarkTheme theme: self.
	button initializeThemeable.
	
	item := BrGlamorousItemTheme new.
	
	header := BrGlamorousHeaderDarkTheme theme: self.
	header initializeThemeable.
	
	label := BrGlamorousLabelTheme theme: self.
	label initializeThemeable
]
