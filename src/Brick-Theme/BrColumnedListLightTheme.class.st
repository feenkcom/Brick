Class {
	#name : #BrColumnedListLightTheme,
	#superclass : #BrColumnedListTheme,
	#category : #'Brick-Theme-Columned List'
}

{ #category : #initialization }
BrColumnedListLightTheme >> initializeConstants [
	constants := OrderedDictionary new.
	self constantAt: #headerBackgroundColor put: Color transparent.
	self constantAt: #sortableHeaderHoveredBackgroundColor put: BrAntColors gray2
]
