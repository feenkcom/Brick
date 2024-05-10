Class {
	#name : #BrResizerTopLocation,
	#superclass : #BrResizerLocation,
	#category : #'Brick-Resizer - State'
}

{ #category : #'instance creation' }
BrResizerTopLocation >> newResizerListener [
	^ BlResizerTopListener new
]

{ #category : #accessing }
BrResizerTopLocation >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: 'top'
]
