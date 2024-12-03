Class {
	#name : #BrMenuDragHandleElement,
	#superclass : #BrMenuModelElement,
	#instVars : [
		'pullHandler',
		'targetElement'
	],
	#category : #'Brick-Menu - UI'
}

{ #category : #initialization }
BrMenuDragHandleElement >> initialize [
	super initialize.
	self addEventHandler: (pullHandler := BlPullHandler new disallowOutOfBounds).
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
	self
		when: BlDragEndEvent
		do: [ :anEvent | self mouseCursor: BlGrabCursor new ].
	self 
		when: BlPullEvent
		do: [ :anEvent | self onPullEvent: anEvent ]
]

{ #category : #'hooks - children' }
BrMenuDragHandleElement >> onAddedToParent [
	super onAddedToParent.
	targetElement ifNotNil: [ ^ self ].
	self targetElement: self parent
]

{ #category : #'event handling' }
BrMenuDragHandleElement >> onPullEvent: anEvent [ 
	| anElement |
	anElement := targetElement ifNil: [ anEvent currentTarget ].
	anEvent consumed: true.
	true ifTrue: [ ^ self ].
	anElement constraintsDo: [ :c | 
		c stepped relativeBounds ifNotNil: [ :aBounds | 
			aBounds inspectOnce.
			anEvent inspectOnce.
			c stepped relativeBounds: aBounds - anEvent delta ] ].
]

{ #category : #'api - initialization' }
BrMenuDragHandleElement >> targetElement: anElement [
	targetElement := anElement.
	pullHandler targetElement: anElement
]
