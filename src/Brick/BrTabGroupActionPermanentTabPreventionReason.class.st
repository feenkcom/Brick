Class {
	#name : #BrTabGroupActionPermanentTabPreventionReason,
	#superclass : #BrTabGroupActionPreventionReason,
	#instVars : [
		'contentElement'
	],
	#category : #'Brick-Tabs - Support'
}

{ #category : #accessing }
BrTabGroupActionPermanentTabPreventionReason >> contentElement [
	^ contentElement
]

{ #category : #accessing }
BrTabGroupActionPermanentTabPreventionReason >> contentElement: anObject [
	contentElement := anObject
]
