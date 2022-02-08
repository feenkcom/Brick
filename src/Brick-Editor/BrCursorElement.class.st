Class {
	#name : #BrCursorElement,
	#superclass : #BlElement,
	#instVars : [
		'textPosition'
	],
	#category : #'Brick-Editor-UI'
}

{ #category : #initialization }
BrCursorElement >> initialize [
	super initialize.
	
	textPosition := 0.
	self focusability: BlFocusability none
]

{ #category : #accessing }
BrCursorElement >> textPosition [
	^ textPosition
]

{ #category : #accessing }
BrCursorElement >> textPosition: aNumber [
	textPosition := aNumber.
	self requestLayout
]
