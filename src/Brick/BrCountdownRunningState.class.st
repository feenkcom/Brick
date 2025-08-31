"
Animation is in progress.
"
Class {
	#name : #BrCountdownRunningState,
	#superclass : #BrCountdownGeometryState,
	#category : #'Brick-Countdown - Helpers'
}

{ #category : #'api - state' }
BrCountdownRunningState >> enable [
	^ BrCountdownGeometryState enabled
]

{ #category : #'api - state' }
BrCountdownRunningState >> finish [
	^ BrCountdownGeometryState disabled
]

{ #category : #'api - state' }
BrCountdownRunningState >> hover [
	^ BrCountdownGeometryState hovered
]

{ #category : #'api - state' }
BrCountdownRunningState >> ifPopover: aBlock [
	^ aBlock value
]

{ #category : #'api - state' }
BrCountdownRunningState >> ifRunFinished: aBlock [
	^ aBlock value
]

{ #category : #'api - state' }
BrCountdownRunningState >> ifRunning: aBlock [
	^ aBlock value
]
