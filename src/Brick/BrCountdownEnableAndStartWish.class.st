"
I inform {{gtClass:BrCountdownGeometryAptitude}} that animation should be enabled and started.
I am equivalent to calling {{gtMethod:BrCountdownGeometryAptitude >> #enableAnimation}}. 

"
Class {
	#name : #BrCountdownEnableAndStartWish,
	#superclass : #BrWish,
	#instVars : [
		'isDisableFinishedAction'
	],
	#category : #'Brick-Countdown - Events'
}

{ #category : #'api - instance creation' }
BrCountdownEnableAndStartWish class >> withFinishedAction [
	^ self new enableFinishedAction
]

{ #category : #'api - instance creation' }
BrCountdownEnableAndStartWish class >> withoutFinishedAction [
	^ self new disableFinishedAction
]

{ #category : #'api - initialization' }
BrCountdownEnableAndStartWish >> disableFinishedAction [
	isDisableFinishedAction := true
]

{ #category : #'api - initialization' }
BrCountdownEnableAndStartWish >> enableFinishedAction [
	isDisableFinishedAction := false
]

{ #category : #testing }
BrCountdownEnableAndStartWish >> isDisableFinishedAction [
	"True value means that the finished action should not be called.
	False value means that the finished action may be called."

	^ isDisableFinishedAction ifNil: [ false ]
]
