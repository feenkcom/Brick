Class {
	#name : #BrSearchTextPatternWish,
	#superclass : #BrWish,
	#instVars : [
		'text'
	],
	#category : #'Brick-Glamorous-Editor'
}

{ #category : #accessing }
BrSearchTextPatternWish >> text [
	^ text
]

{ #category : #'event handling' }
BrSearchTextPatternWish >> text: aBlText [
	text := aBlText 
]
