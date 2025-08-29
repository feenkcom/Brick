"
Animation is stopped due to a mouse hover.
"
Class {
	#name : #BrCountdownHoverState,
	#superclass : #BrCountdownGeometryState,
	#category : #'Brick-Countdown - Helpers'
}

{ #category : #'api - state' }
BrCountdownHoverState >> ifPopover: aBlock [
	^ aBlock value
]

{ #category : #'api - state' }
BrCountdownHoverState >> popover [
	^ BrCountdownGeometryState popover
]

{ #category : #'api - state' }
BrCountdownHoverState >> unhover [
	^ BrCountdownGeometryState ready
]
