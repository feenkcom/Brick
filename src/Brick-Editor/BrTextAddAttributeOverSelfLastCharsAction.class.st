Class {
	#name : #BrTextAddAttributeOverSelfLastCharsAction,
	#superclass : #BrTextEventHandlingAttributeAction,
	#instVars : [
		'attribute',
		'charCount'
	],
	#category : 'Brick-Editor-Attributes'
}

{ #category : #'instance creation' }
BrTextAddAttributeOverSelfLastCharsAction class >> attribute: anAttribute lastCharacters: aCharCount [
	^ self new
		setAttribute: anAttribute
		lastCharacters: aCharCount
]

{ #category : #initialization }
BrTextAddAttributeOverSelfLastCharsAction >> setAttribute: anAttribute lastCharacters: aCharCount [
	attribute := anAttribute.
	charCount := aCharCount
]
