Class {
	#name : #BrTextAddAttributeOverSelfFirstCharsAction,
	#superclass : #BrTextEventHandlingAttributeAction,
	#instVars : [
		'attribute',
		'charCount'
	],
	#category : 'Brick-Editor-Attributes'
}

{ #category : #'instance creation' }
BrTextAddAttributeOverSelfFirstCharsAction class >> attribute: anAttribute firstCharacters: aCharCount [
	^ self new
		setAttribute: anAttribute
		firstCharacters: aCharCount
]

{ #category : #private }
BrTextAddAttributeOverSelfFirstCharsAction >> performAction: anEvent in: aTextEditor [
	| aStart anEnd |
	aStart := anEvent attributeStart.
	anEnd := (aStart + charCount) min: anEvent attributeEnd.

	(aTextEditor text from: aStart to: anEnd) attributes: {attribute}
]

{ #category : #initialization }
BrTextAddAttributeOverSelfFirstCharsAction >> setAttribute: anAttribute firstCharacters: aCharCount [
	attribute := anAttribute.
	charCount := aCharCount
]
