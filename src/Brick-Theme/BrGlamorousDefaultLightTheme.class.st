Class {
	#name : #BrGlamorousDefaultLightTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousDefaultLightTheme >> initializeColors [
	super initialize.
	contentBackgroundColor := Color white.
	defaultShadowColor := BrGlamorousColors defaultShadowColor.
	backdropColor := BrGlamorousColors backdropColor.
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
