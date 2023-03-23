Class {
	#name : #BrAnchoredTopRightReferencePoint,
	#superclass : #BrAnchoredReferencePoint,
	#category : #'Brick-Anchored - Support'
}

{ #category : #accessing }
BrAnchoredTopRightReferencePoint class >> label [
	^ 'Top right'
]

{ #category : #'as yet unclassified' }
BrAnchoredTopRightReferencePoint >> from: aBounds [
	^ aBounds topRight
]

{ #category : #'gt - extensions' }
BrAnchoredTopRightReferencePoint >> gtConfigurePreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignTop.
	]
]
