Class {
	#name : #BrSearchPattern,
	#superclass : #Object,
	#category : #'Brick-List - Search Model'
}

{ #category : #'api - search' }
BrSearchPattern >> findAllIndexesInText: aText [
	"Return all index interval (start and stop positions) 
	of a given pattern (e.g., substring) in a given aText."

	<return: #Array of: #BrSearchFoundTextItem>
	^ self subclassResponsibility
]
