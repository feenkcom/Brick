Class {
	#name : #BrMenuWidgetBoundsRelocator,
	#superclass : #BrMenuContainerRelocator,
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - relocating' }
BrMenuWidgetBoundsRelocator >> relocateGiven: aWidget [
	menuContainer parent ifNotNil: [ :aParent |
		menuContainer layoutDo: [ :aLayout | 
			aLayout anchorBounds: (aWidget bounds 
				inParent: aParent) asRectangle ] ]
]
