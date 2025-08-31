"
Animation is currently disabled.
I can be set by:
- dispatching {{gtClass:BrCountdownDisableAndStopWish}} to {{gtClass:BrCountdownGeometryAptitude}}, or 
- calling {{gtMethod:BrCountdownGeometryAptitude >> disableAnimation}}. 
"
Class {
	#name : #BrCountdownDisabledState,
	#superclass : #BrCountdownGeometryState,
	#category : #'Brick-Countdown - Helpers'
}

{ #category : #'api - state' }
BrCountdownDisabledState >> enable [
	^ BrCountdownGeometryState enabled
]
