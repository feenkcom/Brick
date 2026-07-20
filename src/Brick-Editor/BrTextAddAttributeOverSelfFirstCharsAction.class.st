Class {
	#name : #BrTextAddAttributeOverSelfFirstCharsAction,
	#superclass : #BrTextEventHandlingAttributeAction,
	#instVars : [
		'attribute',
		'charCount'
	],
	#category : #'Brick-Editor-Attributes'
}

{ #category : #'instance creation' }
BrTextAddAttributeOverSelfFirstCharsAction class >> attribute: anAttribute firstCharacters: aCharCount [
	^ self new
		setAttribute: anAttribute
		firstCharacters: aCharCount
]

{ #category : #initialization }
BrTextAddAttributeOverSelfFirstCharsAction >> setAttribute: anAttribute firstCharacters: aCharCount [
	attribute := anAttribute.
	charCount := aCharCount
]
