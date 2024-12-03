Class {
	#name : #BrMenuDragHandleElement,
	#superclass : #BrMenuModelElement,
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuDragHandleElement >> initialize [
	super initialize.
	self background: Color veryLightGray.
	self geometry: BlStadiumGeometry new.
	self exact: 12 @ 4.
	
	self mouseCursor: BlGrabCursor new.
	self
		when: BlMouseDownEvent
		do: [ :anEvent | self mouseCursor: BlGrabbingCursor new ].
	self
		when: BlMouseUpEvent
		do: [ :anEvent | self mouseCursor: BlGrabCursor new ].
]
