Class {
	#name : #BrGlamorousDarkTheme,
	#superclass : #BrGlamorousTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousDarkTheme >> initialize [
	super initialize.

	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.

	default := BrGlamorousDefaultDarkTheme theme: self.
	default initializeTheme.
	
	editor := BrGlamorousEditorTheme new.
	button := BrGlamorousButtonDarkTheme theme: self.
	button initializeTheme.
	
	item := BrGlamorousItemTheme new.
	header := BrGlamorousHeaderDarkTheme new.
	label := BrGlamorousLabelDarkTheme new
]
