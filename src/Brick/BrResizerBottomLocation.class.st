Class {
	#name : #BrResizerBottomLocation,
	#superclass : #BrResizerLocation,
	#category : #'Brick-Resizer - State'
}

{ #category : #'instance creation' }
BrResizerBottomLocation >> newResizerListener [
	^ BlResizerBottomListener new minimumExtent: (0@30)
]

{ #category : #printing }
BrResizerBottomLocation >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: 'bottom'
]
