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
	default := BrGlamorousDefaultDarkTheme new.
	editor := BrGlamorousEditorTheme new.
	button := BrGlamorousButtonDarkTheme new.
	item := BrGlamorousItemTheme new.
	header := BrGlamorousHeaderTheme new.
	label := BrGlamorousLabelDarkTheme new
]
