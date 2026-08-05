Class {
	#name : #BlDevScripterClickDragStep,
	#superclass : #BlDevScripterInteractionStep,
	#instVars : [
		'whileDragMoveDelta',
		'beforeClickMoveDelta',
		'isDoubleClick'
	],
	#category : 'Brick-Examples-Scripter-Steps'
}

{ #category : #actions }
BlDevScripterClickDragStep >> beforeClickMoveBy: aBlVector [
	beforeClickMoveDelta := aBlVector
]

{ #category : #accessing }
BlDevScripterClickDragStep >> defaultLabel [
	^ 'Click / Double-Click Drag'
]

{ #category : #actions }
BlDevScripterClickDragStep >> playOn: aScripter [
	| aStartPosition aNewPosition anElement centerOfElement |
	anElement := self target findTargetStartingInScripter: aScripter.
	anElement topMostParent forceLayout.
	centerOfElement := anElement bounds inSpace center.
	aStartPosition := centerOfElement + beforeClickMoveDelta.
	(isDoubleClick isNotNil and: [isDoubleClick])
		ifTrue: 
			[BlSpace simulateEvents: 
					{BlMouseDownEvent primary position: aStartPosition.
					BlMouseUpEvent primary position: aStartPosition}
				on: anElement].
	BlSpace simulateEvent: (BlMouseDownEvent primary position: aStartPosition)
		on: anElement.
	aNewPosition := aStartPosition + whileDragMoveDelta.
	self setMousePosition: aNewPosition in: aScripter.
	BlSpace simulateMouseMoveOn: anElement from: aStartPosition to: aNewPosition.
	BlSpace simulateEvent: (BlMouseUpEvent primary position: aNewPosition)
		on: anElement.
	aScripter pulse
]

{ #category : #action }
BlDevScripterClickDragStep >> useDoubleClick [
	isDoubleClick := true
]

{ #category : #actions }
BlDevScripterClickDragStep >> whileDragMoveBy: aBlVector [
	whileDragMoveDelta := aBlVector
]