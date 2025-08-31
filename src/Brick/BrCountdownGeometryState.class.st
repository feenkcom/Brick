"
I represent a current {{gtClass:BlAnimation}} state in {{gtClass:BrCountdownGeometryAptitude}}. 
"
Class {
	#name : #BrCountdownGeometryState,
	#superclass : #Object,
	#classVars : [
		'Disabled',
		'Enabled',
		'Hovered',
		'Popover',
		'Ready',
		'Running'
	],
	#category : #'Brick-Countdown - Helpers'
}

{ #category : #'instance creation' }
BrCountdownGeometryState class >> disabled [
	^ Disabled ifNil: [ Disabled := BrCountdownDisabledState new ]
]

{ #category : #'instance creation' }
BrCountdownGeometryState class >> enabled [
	^ Enabled ifNil: [ Enabled := BrCountdownEnabledState new ]
]

{ #category : #'instance creation' }
BrCountdownGeometryState class >> hovered [
	^ Hovered ifNil: [ Hovered := BrCountdownHoverState new ]
]

{ #category : #'instance creation' }
BrCountdownGeometryState class >> popover [
	^ Popover ifNil: [ Popover := BrCountdownPopoverState new ]
]

{ #category : #'instance creation' }
BrCountdownGeometryState class >> ready [
	^ Ready ifNil: [ Ready := BrCountdownReadyState new ]
]

{ #category : #'instance creation' }
BrCountdownGeometryState class >> running [
	^ Running ifNil: [ Running := BrCountdownRunningState new ]
]

{ #category : #'api - state' }
BrCountdownGeometryState >> disable [
	^ BrCountdownGeometryState disabled
]

{ #category : #'api - state' }
BrCountdownGeometryState >> enable [
	^ self
]

{ #category : #'api - state' }
BrCountdownGeometryState >> finish [
	^ self
]

{ #category : #'api - state' }
BrCountdownGeometryState >> hover [
	^ self
]

{ #category : #'api - state' }
BrCountdownGeometryState >> ifEnabled: aBlock [
	"Evaluate block if animation is enabled and therefore can be started."

	
]

{ #category : #'api - state' }
BrCountdownGeometryState >> ifPopover: aBlock [
	"Evaluate block if 
	- animation should be stopped due to opened popover, or
	- state changed to popover."

	
]

{ #category : #'api - state' }
BrCountdownGeometryState >> ifReady: aBlock [
	"Evaluate block if animation should be started, e.g., after added to scene."

	
]

{ #category : #'api - state' }
BrCountdownGeometryState >> ifRunFinished: aBlock [
	"Evaluate block if animation finished callback can be avaluated."

	
]

{ #category : #'api - state' }
BrCountdownGeometryState >> ifRunning: aBlock [
	"Evaluate block if animation is running (or is about to be started)."

	
]

{ #category : #'api - state' }
BrCountdownGeometryState >> ifScene: aBlock [
	"Evaluate block if animation should be started after added to a scene graph."

	
]

{ #category : #'api - state' }
BrCountdownGeometryState >> popover [
	^ self
]

{ #category : #'api - state' }
BrCountdownGeometryState >> ready [
	^ self
]

{ #category : #'api - state' }
BrCountdownGeometryState >> unhover [
	^ self
]

{ #category : #'api - state' }
BrCountdownGeometryState >> unpopover [
	^ self
]
