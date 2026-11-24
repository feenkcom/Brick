Class {
	#name : #BrGlamorousStatusDarkTheme,
	#superclass : #BrGlamorousStatusTheme,
	#category : #'Brick-Theme'
}

{ #category : #initialization }
BrGlamorousStatusDarkTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #neutralBackgroundColor put: BrAntColors gray8.
	self constantAt: #paleErrorBackgroundColor put: BrAntColors darkRed3
]
