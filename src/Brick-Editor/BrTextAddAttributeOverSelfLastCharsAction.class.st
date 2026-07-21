Class {
	#name : #BrTextAddAttributeOverSelfLastCharsAction,
	#superclass : #BrTextEventHandlingAttributeAction,
	#instVars : [
		'attribute',
		'charCount'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #'instance creation' }
BrTextAddAttributeOverSelfLastCharsAction class >> attribute: anAttribute lastCharacters: aCharCount [
	^ self new
		setAttribute: anAttribute
		lastCharacters: aCharCount
]

{ #category : #private }
BrTextAddAttributeOverSelfLastCharsAction >> performAction: anEvent in: aTextEditor [
	| aStart anEnd |
	anEnd := anEvent attributeEnd.
	aStart := (anEnd - charCount) max: anEvent attributeStart.

	(aTextEditor text from: aStart to: anEnd) attributes: {attribute}
]

{ #category : #initialization }
BrTextAddAttributeOverSelfLastCharsAction >> setAttribute: anAttribute lastCharacters: aCharCount [
	attribute := anAttribute.
	charCount := aCharCount
]
