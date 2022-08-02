"
I am a super class of all state change related events.

They must be sent by subclasses of {{gtClass:BrStateModel}}

"
Class {
	#name : #BrStateChangedEvent,
	#superclass : #BrChangeEvent,
	#category : #'Brick-! Core - Events'
}

{ #category : #'instance creation' }
BrStateChangedEvent class >> state: anObject [
	^ self new state: anObject
]

{ #category : #accessing }
BrStateChangedEvent >> state: anObject [
	"Override me to properly set the given state"

	self subclassResponsibility
]
