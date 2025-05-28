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
	link := BrGlamorousLinkTheme new.
	status := BrGlamorousStatusTheme new.
	default := BrGlamorousDefaultLightTheme theme: self.
	default initializeTheme.
	
	editor := BrGlamorousEditorTheme new.
	button := BrGlamorousButtonLightTheme theme: self.
	button initializeTheme.

	item := BrGlamorousItemTheme new.
	header := BrGlamorousHeaderLightTheme new.
	label := BrGlamorousLabelLightTheme new
]
