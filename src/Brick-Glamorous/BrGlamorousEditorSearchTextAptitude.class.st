Class {
	#name : #BrGlamorousEditorSearchTextAptitude,
	#superclass : #BrEditorSearchTextAptitude,
	#category : #'Brick-Glamorous-Editor'
}

{ #category : #initialization }
BrGlamorousEditorSearchTextAptitude >> newSearchElement [
	^ BrSearchTextElement new
		hFitContentLimited;
		constraintsDo: [ :c | 
			c minWidth: 300.
			c frame horizontal alignCenter.
			c frame vertical alignCenter ]
]
