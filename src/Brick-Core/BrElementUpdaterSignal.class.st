Class {
	#name : #BrElementUpdaterSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'updater'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #'instance creation' }
BrElementUpdaterSignal class >> forUpdater: aBrElementUpdater [
	^ self new
		updater: aBrElementUpdater;
		yourself
]

{ #category : #testing }
BrElementUpdaterSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #accessing }
BrElementUpdaterSignal >> updater [

	^ updater
]

{ #category : #accessing }
BrElementUpdaterSignal >> updater: anObject [

	updater := anObject
]
