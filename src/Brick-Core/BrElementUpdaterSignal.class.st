Class {
	#name : #BrElementUpdaterSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'updater',
		'element',
		'elementSpace'
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
BrElementUpdaterSignal >> element [
	^ element
]

{ #category : #accessing }
BrElementUpdaterSignal >> elementSpace [
	^ elementSpace
]

{ #category : #accessing }
BrElementUpdaterSignal >> isElementInSpace [
	^ elementSpace isNotNil
]

{ #category : #printing }
BrElementUpdaterSignal >> printOneLineContentsOn: stream [
	stream print: element.
	self isElementInSpace ifFalse: [
		stream nextPutAll: ' is not in space' ].
	stream nextPutAll: ', updaterID: '.
	stream print: updater identityHash.
	super printOneLineContentsOn: stream
]

{ #category : #accessing }
BrElementUpdaterSignal >> updater [

	^ updater
]

{ #category : #accessing }
BrElementUpdaterSignal >> updater: anUpdater [

	anUpdater ifNil: [ ^ self ].

	updater := anUpdater.
	element := anUpdater element.
	elementSpace := anUpdater element ifNotNil: #space.
]
