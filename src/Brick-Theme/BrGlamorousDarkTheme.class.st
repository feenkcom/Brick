Class {
	#name : #BrGlamorousDarkTheme,
	#superclass : #BrGlamorousTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousDarkTheme >> initialize [
	super initialize.

	colors := BrGlamorousDarkThemeColors new.
	
	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.

	default := BrGlamorousDefaultDarkTheme theme: self.
	default initializeTheme.
	
	editor := BrGlamorousEditorTheme theme: self.
	editor initializeTheme.
	
	button := BrGlamorousButtonDarkTheme theme: self.
	button initializeTheme.
	
	item := BrGlamorousItemTheme new.
	
	header := BrGlamorousHeaderDarkTheme theme: self.
	header initializeTheme.
	
	label := BrGlamorousLabelTheme theme: self.
	label initializeTheme
]
