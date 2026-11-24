Class {
	#name : #BrColumnedListDarkTheme,
	#superclass : #BrColumnedListTheme,
	#category : #'Brick-Theme-Columned List'
}

{ #category : #initialization }
BrColumnedListDarkTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #sortableHeaderHoveredBackgroundColor put: BrAntColors gray9
]
