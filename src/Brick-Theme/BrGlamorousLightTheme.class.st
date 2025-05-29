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
	
	colors := BrGlamorousLightThemeColors new.
	
	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.
	default := BrGlamorousDefaultLightTheme theme: self.
	default initializeTheme.
	
	editor := BrGlamorousEditorTheme theme: self.
	editor initializeTheme.
	
	button := BrGlamorousButtonLightTheme theme: self.
	button initializeTheme.

	item := BrGlamorousItemTheme new.

	header := BrGlamorousHeaderLightTheme theme: self.
	header initializeTheme.

	label := BrGlamorousLabelTheme theme: self.
	label initializeTheme
]
