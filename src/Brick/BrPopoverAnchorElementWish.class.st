"
I request an anchor element, which is a {{gtClass:BlElement}} on which a {{gtClass:BrWithExplicitPopoverAptitude}} is installed on.
Users can also use {{gtMethod:BlElement>>#anchor}} to obtain the information.
"
Class {
	#name : #BrPopoverAnchorElementWish,
	#superclass : #BrPopoverWish,
	#instVars : [
		'anchorElement'
	],
	#category : #'Brick-Menu - Events'
}

{ #category : #accessing }
BrPopoverAnchorElementWish >> anchorElement [
	^ anchorElement
]

{ #category : #accessing }
BrPopoverAnchorElementWish >> anchorElement: anObject [
	anchorElement := anObject
]

{ #category : #accessing }
BrPopoverAnchorElementWish >> anchorElementDo: aBlock [
	^ anchorElement ifNotNil: aBlock
]

{ #category : #accessing }
BrPopoverAnchorElementWish >> anchorElementDo: aBlock ifAbsent: anAbsentBlock [
	^ anchorElement ifNotNil: aBlock ifNil: anAbsentBlock
]

{ #category : #accessing }
BrPopoverAnchorElementWish >> sourceElement [
	^ anchorElement
]

{ #category : #accessing }
BrPopoverAnchorElementWish >> sourceElement: anObject [
	anchorElement := anObject
]

{ #category : #accessing }
BrPopoverAnchorElementWish >> sourceElementDo: aBlock [
	^ anchorElement ifNotNil: aBlock
]

{ #category : #accessing }
BrPopoverAnchorElementWish >> sourceElementDo: aBlock ifAbsent: anAbsentBlock [
	^ anchorElement ifNotNil: aBlock ifNil: anAbsentBlock
]
