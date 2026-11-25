Class {
	#name : #BrGlamorousMarkupDarkTheme,
	#superclass : #BrGlamorousMarkupTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousMarkupDarkTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #foreground put: BrAntColors gray3.
	self constantAt: #background put: BrAntColors gray8.
	self constantAt: #codeFenceForeground put: Color lightGray
]
