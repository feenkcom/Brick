Class {
	#name : #BrTextHighlight,
	#superclass : #Object,
	#instVars : [
		'id',
		'color'
	],
	#category : 'Brick-Editor-Attributes'
}

{ #category : #'instance creation' }
BrTextHighlight class >> id: aString color: aColor [
	^ self new setId: aString color: aColor
]

{ #category : #accessing }
BrTextHighlight >> color [
	^ color
]

{ #category : #accessing }
BrTextHighlight >> id [
	^ id
]

{ #category : #initialization }
BrTextHighlight >> setId: aString color: aColor [
	id := aString.
	color := aColor
]
