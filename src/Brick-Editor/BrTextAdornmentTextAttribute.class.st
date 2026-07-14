Class {
	#name : #BrTextAdornmentTextAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'text'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #accessing }
BrTextAdornmentTextAttribute >> text [
	^ text
]

{ #category : #accessing }
BrTextAdornmentTextAttribute >> text: anObject [
	text := anObject
]
