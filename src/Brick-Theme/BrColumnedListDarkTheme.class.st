Class {
	#name : #BrColumnedListDarkTheme,
	#superclass : #BrColumnedListTheme,
	#category : #'Brick-Theme-Columned List'
}

{ #category : #initialization }
BrColumnedListDarkTheme >> initializeConstants [
	constants := OrderedDictionary new.
	self constantAt: #headerBackgroundColor put: Color transparent.
	self constantAt: #sortableHeaderHoveredBackgroundColor put: BrAntColors gray9
]
