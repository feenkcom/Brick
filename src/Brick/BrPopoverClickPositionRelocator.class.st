Class {
	#name : #BrPopoverClickPositionRelocator,
	#superclass : #BrPopoverContainerRelocator,
	#instVars : [
		'center',
		'extent',
		'topLeftShift'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - initialization' }
BrPopoverClickPositionRelocator >> extent: aPoint [
	"Set bounds extent"

	extent := aPoint.
	center := extent / 2.0
]

{ #category : #initialization }
BrPopoverClickPositionRelocator >> initialize [
	super initialize.

	topLeftShift := 0 @ 0.
	extent := BrMenuConstants handleExtent.
	center := extent / 2.0
]

{ #category : #'api - relocating' }
BrPopoverClickPositionRelocator >> mouseUp: anEvent given: aWidget [
	super mouseUp: anEvent given: aWidget.
	
	topLeftShift := aWidget globalPointToLocal: anEvent position
]

{ #category : #'api - relocating' }
BrPopoverClickPositionRelocator >> relocateGiven: aWidget [
	menuContainer parent
		ifNotNil: [ :aTopMostParent | 
			menuContainer
				layoutDo: [ :aLayout | 
					| aShiftedBounds aShiftedBoundsInTopMostParent aShiftedBoundsInContainer aShiftedRectangle |
					aShiftedBounds := BlBounds origin: topLeftShift - center extent: extent.
					aShiftedBoundsInTopMostParent := aTopMostParent localBoundsToMine: aShiftedBounds fromChild: aWidget.
					aShiftedBoundsInContainer := menuContainer parentBoundsToLocal: aShiftedBoundsInTopMostParent.
					aShiftedRectangle := aShiftedBoundsInContainer asRectangle.
					aLayout anchorBounds: aShiftedRectangle ] ]
]
