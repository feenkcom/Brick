Class {
	#name : #BrCursorElement,
	#superclass : #BlElement,
	#instVars : [
		'textPosition',
		'blinkingTask',
		'blinkingScheduleTask'
	],
	#classVars : [
		'BlinkDelay',
		'BlinkInterval',
		'ShouldBlink'
	],
	#category : #'Brick-Editor-UI'
}

{ #category : #accessing }
BrCursorElement class >> blinkDelay [
	^ BlinkDelay ifNil: [ 1 second ]
]

{ #category : #accessing }
BrCursorElement class >> blinkDelay: aDuration [
	BlinkDelay := aDuration
]

{ #category : #accessing }
BrCursorElement class >> blinkInterval [
	^ BlinkInterval ifNil: [ 1 second ]
]

{ #category : #accessing }
BrCursorElement class >> blinkInterval: aDuration [
	BlinkInterval := aDuration
]

{ #category : #accessing }
BrCursorElement class >> shouldBlink [
	^ ShouldBlink ifNil: [ true ]
]

{ #category : #accessing }
BrCursorElement class >> shouldBlink: aBoolean [
	ShouldBlink := aBoolean
]

{ #category : #'private - blinking' }
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

{ #category : #'hooks - children' }
BrCursorElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	
	self scheduleBlinking
]

{ #category : #'hooks - geometry' }
BrCursorElement >> onPositionInSpaceChanged [
	super onPositionInSpaceChanged.
	
	self stopBlinking.
	self scheduleBlinking
]

{ #category : #'hooks - children' }
BrCursorElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	
	self stopBlinking
]

{ #category : #'private - blinking' }
BrCursorElement >> scheduleBlinking [
	self stopBlinking.
	
	self class shouldBlink
		ifFalse: [ ^ self ].
	
	blinkingScheduleTask := (BlDelayedTaskAction new
		isIndefiniteTermTask: true;
		delay: self class blinkDelay;
		action: [ self startBlinking ]).

	self enqueueTask: blinkingScheduleTask
]

{ #category : #'private - blinking' }
BrCursorElement >> startBlinking [
	blinkingTask := (BlRepeatedTaskAction new
		delay: self class blinkInterval;
		action: [ self doBlink ]).
	self enqueueTask: blinkingTask
]

{ #category : #'private - blinking' }
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
