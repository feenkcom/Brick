"
Animation is currently enabled.
I can be set by:
- dispatching {{gtClass:BrCountdownEnableAndStartWish}} to {{gtClass:BrCountdownGeometryAptitude}}, or 
- calling {{gtMethod:BrCountdownGeometryAptitude >> enableAnimation}}. 
"
Class {
	#name : #BrCountdownEnabledState,
	#superclass : #BrCountdownGeometryState,
	#category : #'Brick-Countdown - Helpers'
}

{ #category : #'api - state' }
BrCountdownEnabledState >> ifEnabled: aBlock [
	^ aBlock value
]

{ #category : #'api - state' }
BrCountdownEnabledState >> ready [
	^ BrCountdownGeometryState ready
]
