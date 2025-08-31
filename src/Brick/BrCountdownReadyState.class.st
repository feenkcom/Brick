"
Animation is stopped, but will be executed as soon as element is added to a scene.

"
Class {
	#name : #BrCountdownReadyState,
	#superclass : #BrCountdownGeometryState,
	#category : #'Brick-Countdown - Helpers'
}

{ #category : #'api - state' }
BrCountdownReadyState >> ifEnabled: aBlock [
	^ aBlock value
]

{ #category : #'api - state' }
BrCountdownReadyState >> ifReady: aBlock [
	^ aBlock value
]
