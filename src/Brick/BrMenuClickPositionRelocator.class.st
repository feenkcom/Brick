Class {
	#name : #BrMenuClickPositionRelocator,
	#superclass : #BrMenuContainerRelocator,
	#instVars : [
		'topLeftShift',
		'center',
		'extent'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #'api - initialization' }
BrMenuClickPositionRelocator >> extent: aPoint [
	"Set bounds extent"

	extent := aPoint.
	center := extent / 2.0
]

{ #category : #initialization }
BrMenuClickPositionRelocator >> initialize [
	super initialize.

	topLeftShift := 0 @ 0.
	extent := 4 @ 4.
	center := extent / 2.0
]

{ #category : #'api - relocating' }
BrMenuClickPositionRelocator >> mouseUp: anEvent given: aWidget [
	super mouseUp: anEvent given: aWidget.
	
	topLeftShift := aWidget globalPointToLocal: anEvent position
]

{ #category : #'api - relocating' }
BrMenuClickPositionRelocator >> relocateGiven: aWidget [
	menuContainer parent
		ifNotNil: [ :aParent | 
			menuContainer
				layoutDo: [ :aLayout | 
					| aWidgetRectangle aShiftedRectangle|
					aWidgetRectangle := (aWidget bounds inParent: aParent) asRectangle.
					aShiftedRectangle := self shiftedWidgetBounds: aWidgetRectangle.
					aLayout anchorBounds: aShiftedRectangle ] ]
]

{ #category : #accessing }
BrMenuClickPositionRelocator >> shiftedWidgetBounds: aWidgetRectangle [
	<return: #Rectangle>
	| anOrigin |
	anOrigin := aWidgetRectangle origin translateBy: topLeftShift - center.
	^ anOrigin extent: extent.
]
