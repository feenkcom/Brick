Class {
	#name : #BrColumnedListLightTheme,
	#superclass : #BrColumnedListTheme,
	#category : #'Brick-Theme-Columned List'
}

{ #category : #initialization }
BrColumnedListLightTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #headerBackgroundColor put: Color transparent.
	self constantAt: #sortableHeaderHoveredBackgroundColor put: BrAntColors gray2
]
