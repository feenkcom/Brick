Class {
	#name : #BrPopoverWidgetBoundsRelocator,
	#superclass : #BrPopoverContainerRelocator,
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - relocating' }
BrPopoverWidgetBoundsRelocator >> relocateGiven: aWidget [
	menuContainer parent ifNotNil: [ :aParent |
		menuContainer layoutDo: [ :aLayout | 
			aLayout anchorBounds: (aWidget bounds 
				inParent: aParent) asRectangle ] ]
]
