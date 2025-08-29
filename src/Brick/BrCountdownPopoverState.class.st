"
Animation is stopped due to {{gtClass:BrWithExplicitPopoverAptitude}} (dropdown or context menu).
To handle popover (dropdown or context menu), {{gtClass:BrCountdownGeometryAptitude}} needs to be initialized with:
- {{gtMethod:BrCountdownGeometryAptitude >> withDropdownEventHandlers}}, or
- {{gtMethod:BrCountdownGeometryAptitude >> withContextMenuEventHandlers}}. 

"
Class {
	#name : #BrCountdownPopoverState,
	#superclass : #BrCountdownGeometryState,
	#category : #'Brick-Countdown - Helpers'
}

{ #category : #'api - state' }
BrCountdownPopoverState >> unpopover [
	^ BrCountdownGeometryState ready
]
