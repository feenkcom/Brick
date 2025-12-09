"
I am a {{gtClass:BrEditorSearchTextComputation}}. 
I search all text places in a {{gtMethod:Processor class >> #activeProcess | label=active process}}. 
Note that the active process must be a UI process. 

"
Class {
	#name : #BrEditorSearchTextSameProcessComputation,
	#superclass : #BrEditorSearchTextComputation,
	#category : #'Brick-Editor - Search Model'
}

{ #category : #'api - styling' }
BrEditorSearchTextSameProcessComputation >> markText: aMarkContext using: aMarker [
	| allPatternItems |
	allPatternItems := aMarker markText: aMarkContext text context: aMarkContext.
	aMarkContext patternItems: allPatternItems.
	aMarker notifyFoundItems: allPatternItems context: aMarkContext.
]
