Class {
	#name : #BrAnchoredTopLeftReferencePoint,
	#superclass : #BrAnchoredReferencePoint,
	#category : #'Brick-Anchored - Support'
}

{ #category : #accessing }
BrAnchoredTopLeftReferencePoint class >> label [
	^ 'Top left'
]

{ #category : #'as yet unclassified' }
BrAnchoredTopLeftReferencePoint >> from: aBounds [
	^ aBounds topLeft
]

{ #category : #'gt - extensions' }
BrAnchoredTopLeftReferencePoint >> gtConfigurePreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignTop.
	]
]
