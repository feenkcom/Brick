Class {
	#name : #BrMenuInitialContext,
	#superclass : #Object,
	#instVars : [
		'anchorElement',
		'menuAptitude',
		'positionInSpace',
		'elementBuilder'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #accessing }
BrMenuInitialContext >> anchorElement [
	^ anchorElement
]

{ #category : #accessing }
BrMenuInitialContext >> anchorElement: anElement [
	anchorElement := anElement
]

{ #category : #convenience }
BrMenuInitialContext >> dueToEvent: anEvent [ 
	anEvent ifNil: [ ^ self ].
	self positionInSpace: anEvent position
]

{ #category : #accessing }
BrMenuInitialContext >> elementBuilder [
	<return: #BrMenuElementBuilder>
	^ elementBuilder
]

{ #category : #accessing }
BrMenuInitialContext >> elementBuilder: anObject [
	elementBuilder := anObject
]

{ #category : #accessing }
BrMenuInitialContext >> menuAptitude [
	^ menuAptitude
]

{ #category : #accessing }
BrMenuInitialContext >> menuAptitude: anAptitude [
	menuAptitude := anAptitude
]

{ #category : #accessing }
BrMenuInitialContext >> positionInSpace [
	^ positionInSpace
]

{ #category : #accessing }
BrMenuInitialContext >> positionInSpace: aPoint [
	positionInSpace := aPoint
]
