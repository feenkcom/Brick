Class {
	#name : #BrCursorElement,
	#superclass : #BlElement,
	#instVars : [
		'textPosition',
		'blinkingTask',
		'blinkingScheduleTask'
	],
	#category : #'Brick-Editor-UI'
}

{ #category : #initialization }
BrCursorElement >> doBlink [
	(self opacity > 0.5)
		ifTrue: [ self opacity: 0.0 ]
		ifFalse: [ self opacity: 1.0 ]
]

{ #category : #initialization }
BrCursorElement >> initialize [
	super initialize.
	
	textPosition := 0.
	self focusability: BlFocusability none.
	
	self scheduleBlinking
]

{ #category : #'as yet unclassified' }
BrCursorElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	self scheduleBlinking
]

{ #category : #'as yet unclassified' }
BrCursorElement >> onPositionInSpaceChanged [
	super onPositionChanged.
	
	self stopBlinking.
	self scheduleBlinking
]

{ #category : #'as yet unclassified' }
BrCursorElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	
	self scheduleBlinking
]

{ #category : #'as yet unclassified' }
BrCursorElement >> scheduleBlinking [
	self opacity: 1.0.
	blinkingScheduleTask ifNotNil: [ :aTask | aTask stop ].
	blinkingTask ifNotNil: [ :aTask | aTask stop ].
	blinkingScheduleTask := (BlDelayedTaskAction new
		delay: 1 second;
		action: [ self startBlinking ]).

	self enqueueTask: blinkingScheduleTask
]

{ #category : #'as yet unclassified' }
BrCursorElement >> startBlinking [
	blinkingTask := (BlRepeatedTaskAction new
		delay: 1 second;
		action: [ self doBlink ]).
	self enqueueTask: blinkingTask
]

{ #category : #accessing }
BrCursorElement >> stopBlinking [
	blinkingScheduleTask ifNotNil: [ :aTask | aTask stop ].
	blinkingTask ifNotNil: [ :aTask | aTask stop ].
	blinkingScheduleTask := nil.
	blinkingTask := nil.
	
	self opacity: 1.0
]

{ #category : #accessing }
BrCursorElement >> textPosition [
	^ textPosition
]

{ #category : #accessing }
BrCursorElement >> textPosition: aNumber [
	textPosition := aNumber.
	self requestLayout
]
