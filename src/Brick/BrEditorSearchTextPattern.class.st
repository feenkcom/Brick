Class {
	#name : #BrEditorSearchTextPattern,
	#superclass : #Object,
	#category : #'Brick-Editor - Search'
}

{ #category : #'api - search' }
BrEditorSearchTextPattern >> findAllIndexesIn: aText [
	"Return all index interval (start and stop positions) 
	of a given pattern (e.g., substring) in a given aText."

	<return: #Array of: #BrEditorSearchTextPatternItem>
	^ self subclassResponsibility
]
