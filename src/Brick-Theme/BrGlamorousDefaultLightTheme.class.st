Class {
	#name : #BrGlamorousDefaultLightTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousDefaultLightTheme >> initializeColors [
	super initializeColors.

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

{ #category : #initialization }
BrGlamorousDefaultLightTheme >> initializeConstants [
	super initializeConstants
]

{ #category : #initialization }
BrGlamorousDefaultLightTheme >> initializeThemeable [
	super initializeThemeable
]
