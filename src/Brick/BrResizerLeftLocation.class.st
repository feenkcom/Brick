Class {
	#name : #BrResizerLeftLocation,
	#superclass : #BrResizerLocation,
	#category : #'Brick-Resizer - State'
}

{ #category : #'instance creation' }
BrResizerLeftLocation >> newResizerListener [
	^ BlResizerLeftListener new
]

{ #category : #printing }
BrResizerLeftLocation >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: 'left'
]
