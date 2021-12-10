Class {
	#name : #BrElementUpdaterSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'updater'
	],
	#category : #'Brick-! Core - Support'
}

{ #category : #'instance creation' }
BrElementUpdaterSignal class >> forUpdater: aBrElementUpdater [
	^ self new
		updater: aBrElementUpdater;
		yourself
]

{ #category : #accessing }
BrElementUpdaterSignal >> updater [

	^ updater
]

{ #category : #accessing }
BrElementUpdaterSignal >> updater: anObject [

	updater := anObject
]
