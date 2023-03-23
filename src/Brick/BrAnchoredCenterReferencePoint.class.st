Class {
	#name : #BrAnchoredCenterReferencePoint,
	#superclass : #BrAnchoredReferencePoint,
	#category : #'Brick-Anchored - Support'
}

{ #category : #'as yet unclassified' }
BrAnchoredCenterReferencePoint >> from: aBounds [
	^ aBounds center
]

{ #category : #'gt - extensions' }
BrAnchoredCenterReferencePoint >> gtConfigurePreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignCenter.
	]
]

{ #category : #accessing }
BrAnchoredCenterReferencePoint >> label [
	^ 'Center'
]
