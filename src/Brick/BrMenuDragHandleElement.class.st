Class {
	#name : #BrMenuDragHandleElement,
	#superclass : #BrMenuModelElement,
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuDragHandleElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
BrMenuDragHandleElement >> initialize [
	| anElement |
	super initialize.
	anElement := BrFrame new
			background: Color veryLightGray;
			geometry: BlStadiumGeometry new;
			exact: 12 @ 4.
	self addChild: anElement.
	self padding: (BlInsets all: 3).
	self fitContent.
	
	self mouseCursor: BlGrabCursor new.
	self
		when: BlMouseDownEvent
		do: [ :anEvent | self mouseCursor: BlGrabbingCursor new ].
	self when: BlMouseUpEvent do: [ :anEvent | self mouseCursor: BlGrabCursor new ]
]
