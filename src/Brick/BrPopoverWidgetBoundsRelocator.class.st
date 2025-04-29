"
I am {{gtClass:BrPopoverContainerRelocator}}. 
I set {{gtMethod:BlSteppedLayout >> #anchorBounds:}} of the same bounds as a given anchor element.

"
Class {
	#name : #BrPopoverWidgetBoundsRelocator,
	#superclass : #BrPopoverContainerRelocator,
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - relocating' }
BrPopoverWidgetBoundsRelocator >> relocateGiven: anAnchorElement reason: aReason [
	menuContainer parent ifNotNil: [ :aParent |
		menuContainer layoutDo: [ :aLayout | 
			aLayout anchorBounds: (anAnchorElement bounds 
				inParent: aParent) asRectangle ] ]
]
