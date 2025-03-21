"
I request an anchor element, which is a {{gtClass:BlElement}} on which a {{gtClass:BrWithExplicitMenuAptitude}} is installed on.
Users can also use {{gtMethod:BlElement>>#anchor}} to obtain the information.
"
Class {
	#name : #BrMenuAnchorElementWish,
	#superclass : #BrMenuWish,
	#instVars : [
		'anchorElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrMenuAnchorElementWish >> anchorElement [
	^ anchorElement
]

{ #category : #accessing }
BrMenuAnchorElementWish >> anchorElement: anObject [
	anchorElement := anObject
]

{ #category : #accessing }
BrMenuAnchorElementWish >> anchorElementDo: aBlock [
	^ anchorElement ifNotNil: aBlock
]

{ #category : #accessing }
BrMenuAnchorElementWish >> anchorElementDo: aBlock ifAbsent: anAbsentBlock [
	^ anchorElement ifNotNil: aBlock ifNil: anAbsentBlock
]

{ #category : #accessing }
BrMenuAnchorElementWish >> sourceElement [
	^ anchorElement
]

{ #category : #accessing }
BrMenuAnchorElementWish >> sourceElement: anObject [
	anchorElement := anObject
]

{ #category : #accessing }
BrMenuAnchorElementWish >> sourceElementDo: aBlock [
	^ anchorElement ifNotNil: aBlock
]

{ #category : #accessing }
BrMenuAnchorElementWish >> sourceElementDo: aBlock ifAbsent: anAbsentBlock [
	^ anchorElement ifNotNil: aBlock ifNil: anAbsentBlock
]
