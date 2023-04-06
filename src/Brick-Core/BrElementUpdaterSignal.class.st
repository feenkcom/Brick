Class {
	#name : #BrElementUpdaterSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'updater',
		'element',
		'isElementAttachedToSpace'
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
BrElementUpdaterSignal >> isElementAttachedToSpace [
	^ isElementAttachedToSpace
]

{ #category : #printing }
BrElementUpdaterSignal >> printOneLineContentsOn: stream [
	stream print: element.
	self isElementAttachedToSpace ifFalse: [
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
	isElementAttachedToSpace := element
		ifNotNil: [ :anElement | anElement isAttachedToSceneGraph ]
		ifNil: [ false ]
]
