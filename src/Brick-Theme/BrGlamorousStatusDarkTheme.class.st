Class {
	#name : #BrGlamorousStatusDarkTheme,
	#superclass : #BrGlamorousStatusTheme,
	#category : #'Brick-Theme'
}

{ #category : #initialization }
BrGlamorousStatusDarkTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #neutralBackgroundColor put: BrAntColors gray8
]
