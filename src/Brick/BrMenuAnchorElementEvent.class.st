"
I request an anchor element, which is a {{gtClass:BlElement}} on which a {{gtClass:BrWithExplicitMenuAptitude}} is installed on.
Users can also use {{gtMethod:BlElement>>#anchor}} to obtain the information.
"
Class {
	#name : #BrMenuAnchorElementEvent,
	#superclass : #BrMenuEvent,
	#instVars : [
		'sourceElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuAnchorElementEvent >> sourceElement [
	^ sourceElement
]

{ #category : #accessing }
BrMenuAnchorElementEvent >> sourceElement: anObject [
	sourceElement := anObject
]

{ #category : #accessing }
BrMenuAnchorElementEvent >> sourceElementDo: aBlock [
	^ sourceElement ifNotNil: aBlock
]

{ #category : #accessing }
BrMenuAnchorElementEvent >> sourceElementDo: aBlock ifAbsent: anAbsentBlock [
	^ sourceElement ifNotNil: aBlock ifNil: anAbsentBlock
]
