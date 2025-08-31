"
I inform {{gtClass:BrCountdownGeometryAptitude}} that animation should be stopped and disabled.
I am equivalent to calling {{gtMethod:BrCountdownGeometryAptitude >> #disableAnimation}}. 

"
Class {
	#name : #BrCountdownDisableAndStopWish,
	#superclass : #BrWish,
	#instVars : [
		'isDisableFinishedAction'
	],
	#category : #'Brick-Countdown - Events'
}

{ #category : #'api - instance creation' }
BrCountdownDisableAndStopWish class >> withFinishedAction [
	^ self new enableFinishedAction
]

{ #category : #'api - instance creation' }
BrCountdownDisableAndStopWish class >> withoutFinishedAction [
	^ self new disableFinishedAction
]

{ #category : #'api - initialization' }
BrCountdownDisableAndStopWish >> disableFinishedAction [
	isDisableFinishedAction := true
]

{ #category : #'api - initialization' }
BrCountdownDisableAndStopWish >> enableFinishedAction [
	isDisableFinishedAction := false
]

{ #category : #'api - testing' }
BrCountdownDisableAndStopWish >> isDisableFinishedAction [
	"True value means that the finished action should not be called.
	False value means that the finished action may be called."

	^ isDisableFinishedAction ifNil: [ false ]
]
