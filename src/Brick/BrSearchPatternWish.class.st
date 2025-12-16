Class {
	#name : #BrSearchPatternWish,
	#superclass : #BrSearchWish,
	#instVars : [
		'pattern'
	],
	#category : #'Brick-List - Search Events'
}

{ #category : #accessing }
BrSearchPatternWish >> pattern [
	^ pattern
]

{ #category : #accessing }
BrSearchPatternWish >> pattern: anObject [
	pattern := anObject
]
