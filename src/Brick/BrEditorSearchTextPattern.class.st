"
I am an abstract class.
I know how to find all substring places for a given {{gtClass:BlText}}. 
I return collection of {{gtClass:BrEditorSearchTextItem}}. 
"
Class {
	#name : #BrEditorSearchTextPattern,
	#superclass : #Object,
	#category : #'Brick-Editor - Search Model'
}

{ #category : #'api - search' }
BrEditorSearchTextPattern >> findAllIndexesIn: aText [
	"Return all index interval (start and stop positions) 
	of a given pattern (e.g., substring) in a given aText."

	<return: #Array of: #BrEditorSearchTextItem>
	^ self subclassResponsibility
]
