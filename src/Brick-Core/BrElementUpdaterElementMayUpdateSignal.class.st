Class {
	#name : #BrElementUpdaterElementMayUpdateSignal,
	#superclass : #BrElementUpdaterSignal,
	#instVars : [
		'isAboutToUpdate'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrElementUpdaterElementMayUpdateSignal >> isAboutToUpdate [
	^ isAboutToUpdate
]

{ #category : #accessing }
BrElementUpdaterElementMayUpdateSignal >> isAboutToUpdate: anObject [
	isAboutToUpdate := anObject
]

{ #category : #printing }
BrElementUpdaterElementMayUpdateSignal >> printOneLineContentsOn: stream [
	self isAboutToUpdate
		ifTrue: [ stream nextPutAll: 'PROCESSED ' ]
		ifFalse: [ stream nextPutAll: 'SKIPPED ' ].
	super printOneLineContentsOn: stream
]
