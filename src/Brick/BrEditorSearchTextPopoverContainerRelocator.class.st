Class {
	#name : #BrEditorSearchTextPopoverContainerRelocator,
	#superclass : #BrPopoverContainerRelocator,
	#category : #'Brick-Editor - Search Support'
}

{ #category : #'api - relocating' }
BrEditorSearchTextPopoverContainerRelocator >> relocateGiven: anAnchorElement [
	menuContainer parent
		ifNotNil: [ :aParent | 
			menuContainer
				layoutDo: [ :aLayout | 
					| aBounds anInsideRectangle aTopRightRectangle |
					aBounds := anAnchorElement bounds inParent: aParent.
					anInsideRectangle := aBounds asRectangle
							intersect: aParent bounds asRectangle.
					aTopRightRectangle := anInsideRectangle topRight - (2 @ 0)
							corner: anInsideRectangle topRight + (0 @ 2).
					aLayout anchorBounds: aTopRightRectangle ] ]
]
