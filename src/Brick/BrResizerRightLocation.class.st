Class {
	#name : #BrResizerRightLocation,
	#superclass : #BrResizerLocation,
	#category : #'Brick-Resizer - State'
}

{ #category : #'instance creation' }
BrResizerRightLocation >> newResizerListener [
	^ BlResizerRightListener new
]

{ #category : #printing }
BrResizerRightLocation >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: 'right'
]
