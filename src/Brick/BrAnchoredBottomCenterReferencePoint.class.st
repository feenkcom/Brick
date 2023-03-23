Class {
	#name : #BrAnchoredBottomCenterReferencePoint,
	#superclass : #BrAnchoredReferencePoint,
	#category : #'Brick-Anchored - Support'
}

{ #category : #accessing }
BrAnchoredBottomCenterReferencePoint class >> label [
	^ 'Bottom center'
]

{ #category : #'as yet unclassified' }
BrAnchoredBottomCenterReferencePoint >> from: aBounds [
	^ aBounds bottomCenter
]

{ #category : #'gt - extensions' }
BrAnchoredBottomCenterReferencePoint >> gtConfigurePreferredExtentPreviewElement: anElement [
	anElement constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom.
	]
]
