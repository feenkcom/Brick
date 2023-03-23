Class {
	#name : #BrAnchoredBottomLeftReferencePoint,
	#superclass : #BrAnchoredReferencePoint,
	#category : #'Brick-Anchored - Support'
}

{ #category : #accessing }
BrAnchoredBottomLeftReferencePoint class >> label [
	^ 'Bottom left'
]

{ #category : #'as yet unclassified' }
BrAnchoredBottomLeftReferencePoint >> from: aBounds [
	^ aBounds bottomLeft
]

{ #category : #'gt - extensions' }
BrAnchoredBottomLeftReferencePoint >> gtConfigurePreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignBottom.
	]
]
