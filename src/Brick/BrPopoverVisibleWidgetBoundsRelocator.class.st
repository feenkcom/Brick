"
I am {{gtClass:BrPopoverContainerRelocator}}. 
I set {{gtMethod:BlSteppedLayout >> #anchorBounds:}} of the same bounds as a given anchor element.
If the anchor element is outside of a container parent element, I shift the stepped layout anchor bounds to a visible area.
"
Class {
	#name : #BrPopoverVisibleWidgetBoundsRelocator,
	#superclass : #BrPopoverContainerRelocator,
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - relocating' }
BrPopoverVisibleWidgetBoundsRelocator >> relocateGiven: anAnchorElement reason: aReason [
	menuContainer parent ifNotNil: [ :aParent |
		menuContainer layoutDo: [ :aLayout | 
			| aBounds anInsideRectangle |
			aBounds := anAnchorElement bounds inParent: aParent.
			anInsideRectangle := aBounds asRectangle 
				blocRelocateFullyInsideRectangle: aParent bounds asRectangle.
			aLayout anchorBounds: anInsideRectangle ] ]
]
