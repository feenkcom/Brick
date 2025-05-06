Class {
	#name : #BrPopoverExplicitRelocator,
	#superclass : #BrPopoverContainerRelocator,
	#instVars : [
		'globalBounds'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #accessing }
BrPopoverExplicitRelocator >> globalBounds [
	^ globalBounds
]

{ #category : #accessing }
BrPopoverExplicitRelocator >> globalBounds: anObject [
	globalBounds := anObject
]

{ #category : #'api - relocating' }
BrPopoverExplicitRelocator >> relocateGiven: anAnchorElement [
	menuContainer
		layoutDo: [ :aLayout | aLayout anchorBounds: (menuContainer globalBoundsToLocal: globalBounds) asRectangle ]
]
