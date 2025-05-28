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
	default := BrGlamorousDefaultTheme new.
	editor := BrGlamorousEditorTheme new.
	button := BrGlamorousButtonLightTheme new.
	item := BrGlamorousItemTheme new.
	header := BrGlamorousHeaderLightTheme new.
	label := BrGlamorousLabelLightTheme new
]
