Class {
	#name : #BrEditorSearchTextSameProcessComputation,
	#superclass : #BrEditorSearchTextComputation,
	#category : #'Brick-Editor - Search'
}

{ #category : #'api - styling' }
BrEditorSearchTextSameProcessComputation >> markText: aMarkContext using: aMarker [
	| allPatternItems |
	allPatternItems := aMarker markText: aMarkContext text context: aMarkContext.
	aMarkContext computedPatternItems: allPatternItems.
	aMarker notifyFoundItems: allPatternItems context: aMarkContext.
]
