Class {
	#name : #BrGlamorousMarkupLightTheme,
	#superclass : #BrGlamorousMarkupTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousMarkupLightTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #foreground put: BrGlamorousColors textMarkupColor.
	self constantAt: #background put: BrAntColors gray3.
	self constantAt: #codeFenceForeground put: Color lightGray
]
