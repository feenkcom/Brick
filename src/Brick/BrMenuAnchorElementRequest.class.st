"
I request an anchor element, which is a {{gtClass:BlElement}} on which a {{gtClass:BrWithExplicitMenuAptitude}} is installed on.
Users can also use {{gtMethod:BlElement>>#anchor}} to obtain the information.
"
Class {
	#name : #BrMenuAnchorElementRequest,
	#superclass : #BlEvent,
	#instVars : [
		'sourceElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuAnchorElementRequest >> sourceElement [
	^ sourceElement
]

{ #category : #accessing }
BrMenuAnchorElementRequest >> sourceElement: anObject [
	sourceElement := anObject
]

{ #category : #accessing }
BrMenuAnchorElementRequest >> sourceElementDo: aBlock [
	^ sourceElement ifNotNil: aBlock
]
