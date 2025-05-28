Class {
	#name : #BrGlamorousDefaultDarkTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousDefaultDarkTheme >> initialize [
	super initialize.
	contentBackgroundColor := Color black.
	backdropColor := Color gray.
	
	defaultShadowColor := BrGlamorousColors defaultShadowColor.
	primaryBorderColor := BrGlamorousColors primaryBorderColor.
	darkBorderColor := BrGlamorousColors darkBorderColor.
	distinctTenStrongColors := BrGlamorousColors distinctTenStrongColors.
	newsBackgroundColor := BrGlamorousColors newsBackgroundColor.
	lightBorderColor := BrGlamorousColors lightBorderColor.
	expandCollapseTriangleBackgroundColor := BrGlamorousColors
		expandCollapseTriangleBackgroundColor.
	shadowColor := BrGlamorousColors shadowColor.
	distinctTenLightColors := BrGlamorousColors distinctTenLightColors
]
