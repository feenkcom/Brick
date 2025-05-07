"
I am {{gtClass:BrPopoverContainerRelocator}}. 
I set {{gtMethod:BlSteppedLayout >> #anchorBounds:}} centered around a {{gtMethod: BlMouseEvent >> #position}} with a given {{gtMethod:BrPopoverClickPositionRelocator >> #extent: | label=#selector}}. 

"
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
	"Set anchor bounds extent.
	The stepped layout anchor bounds are centered around mouse (click) event positions."

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
BrPopoverClickPositionRelocator >> mouseEvent: anEvent given: anAnchorElement [
	super mouseEvent: anEvent given: anAnchorElement.

	"Remember distance of the mouse event compared to the given anchor element"
	topLeftShift := anAnchorElement globalPointToLocal: anEvent position
]

{ #category : #'api - relocating' }
BrPopoverClickPositionRelocator >> relocateGiven: anAnchorElement [
	"Set stepped layout anchor bounds around the mouse (click) event position"

	menuContainer parent
		ifNotNil: [ :aTopMostParent | 
			menuContainer
				layoutDo: [ :aLayout | 
					| aShiftedBounds aShiftedBoundsInTopMostParent aShiftedBoundsInContainer aShiftedRectangle |
					aShiftedBounds := BlBounds origin: topLeftShift - center extent: extent.
					aShiftedBoundsInTopMostParent := aTopMostParent localBoundsToMine: aShiftedBounds fromChild: anAnchorElement.
					aShiftedBoundsInContainer := menuContainer parentBoundsToLocal: aShiftedBoundsInTopMostParent.
					aShiftedRectangle := aShiftedBoundsInContainer asRectangle.
					aLayout anchorBounds: aShiftedRectangle ] ]
]
