Class {
	#name : #BrAnchoredCenterLeftReferencePoint,
	#superclass : #BrAnchoredReferencePoint,
	#category : #'Brick-Anchored - Support'
}

{ #category : #accessing }
BrAnchoredCenterLeftReferencePoint class >> label [
	^ 'Center left'
]

{ #category : #'as yet unclassified' }
BrAnchoredCenterLeftReferencePoint >> from: aBounds [
	^ aBounds centerLeft
]

{ #category : #'gt - extensions' }
BrAnchoredCenterLeftReferencePoint >> gtConfigurePreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignCenter.
	]
]
