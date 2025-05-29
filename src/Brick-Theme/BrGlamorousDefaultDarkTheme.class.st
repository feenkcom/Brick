Class {
	#name : #BrGlamorousDefaultDarkTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousDefaultDarkTheme >> initializeColors [
	super initialize.
	
	defaultShadowColor := BrGlamorousColors defaultShadowColor.
	shadowColor := BrGlamorousColors shadowColor.
	
	primaryBorderColor := BrGlamorousColors primaryBorderColor.
	darkBorderColor := BrGlamorousColors darkBorderColor.
	distinctTenStrongColors := BrGlamorousColors distinctTenStrongColors.
	newsBackgroundColor := BrGlamorousColors newsBackgroundColor.
	lightBorderColor := BrGlamorousColors lightBorderColor.
	expandCollapseTriangleBackgroundColor := BrGlamorousColors
		expandCollapseTriangleBackgroundColor.
	distinctTenLightColors := BrGlamorousColors distinctTenLightColors
]
