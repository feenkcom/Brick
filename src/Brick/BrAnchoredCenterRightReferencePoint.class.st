Class {
	#name : #BrAnchoredCenterRightReferencePoint,
	#superclass : #BrAnchoredReferencePoint,
	#category : #'Brick-Anchored - Support'
}

{ #category : #accessing }
BrAnchoredCenterRightReferencePoint class >> label [
	^ 'Center right'
]

{ #category : #'as yet unclassified' }
BrAnchoredCenterRightReferencePoint >> from: aBounds [
	^ aBounds centerRight
]

{ #category : #'gt - extensions' }
BrAnchoredCenterRightReferencePoint >> gtConfigurePreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignCenter.
	]
]
