Class {
	#name : #BrGlamorousButtonLightTheme,
	#superclass : #BrGlamorousButtonTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #'as yet unclassified' }
BrGlamorousButtonLightTheme >> initializeColors [
	super initializeColors.
	
	"default state"
	defaultBackgroundColor := BrGlamorousColors defaultButtonBackgroundColor.
	defaultTextColor := BrGlamorousColors defaultButtonTextColor.
	defaultBorderColor := BrGlamorousColors defaultButtonBorderColor.
	
	"disabled state"
	disabledBackgroundColor := BrGlamorousColors disabledButtonBackgroundColor.
	disabledTextColor := BrGlamorousColors disabledButtonTextColor.
	disabledBorderColor := BrGlamorousColors disabledButtonBorderColor.
]
