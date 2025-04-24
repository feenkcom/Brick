Class {
	#name : #BrUpdatingDateAndTimeTask,
	#superclass : #BlRepeatedTask,
	#instVars : [
		'printer',
		'dateAndTime',
		'labelUpdater'
	],
	#category : #'Brick-Time - Support'
}

{ #category : #accessing }
BrUpdatingDateAndTimeTask >> dateAndTime [
	<return: #DateAndTime>
	^ dateAndTime
]

{ #category : #accessing }
BrUpdatingDateAndTimeTask >> dateAndTime: aDateAndTime [
	dateAndTime := aDateAndTime
]

{ #category : #'private - event handling' }
BrUpdatingDateAndTimeTask >> elementRemovedFromSceneGraphEvent: anEvent [
	delay := 0 milliSeconds.
	super elementRemovedFromSceneGraphEvent: anEvent
]

{ #category : #initialization }
BrUpdatingDateAndTimeTask >> initialize [
	super initialize.
	delay := 0 milliSeconds.
	printer := BrDateAndTimeSinceNowPrinter new.
	labelUpdater := [ :anElement :aString | anElement text: aString ]
]

{ #category : #'api - testing' }
BrUpdatingDateAndTimeTask >> isIndefiniteTermTask [
	"Identifies whether the task may be enqueued indefinitely.
	BlScripter uses it to ignore such tasks while pulsing."

	^ true
]

{ #category : #'api - initialization' }
BrUpdatingDateAndTimeTask >> labelUpdater: aBlock [
	"Label update is an object that understands #value:value:.
	The message arguments are:
	- anElement whose label should be updated regularly, and
	- aString representing new label value."

	labelUpdater := aBlock
]

{ #category : #hooks }
BrUpdatingDateAndTimeTask >> onEnqueuedInElement: anElement [
	super onEnqueuedInElement: anElement.

	element == anElement ifTrue: [ ^ self ].

	delay := 0 milliSeconds
]

{ #category : #'api - running' }
BrUpdatingDateAndTimeTask >> onRun [
	| aTimeLabel |
	dateAndTime ifNil: [ ^ self stop ].

	aTimeLabel := BrDateAndTimeLabel new
			time: dateAndTime;
			now: self time now.
	printer value: aTimeLabel.
	aTimeLabel hasOutput
		ifTrue: [ labelUpdater value: element value: aTimeLabel output ].

	aTimeLabel hasNextUpdate
		ifTrue: [ delay := aTimeLabel nextUpdate - self time now ]
]

{ #category : #'api - initialization' }
BrUpdatingDateAndTimeTask >> printer: aPrinter [
	"Printer is an object that understands #value:.
	The message argument is {{gtClass:BrDateAndTimeLabel}}.
	The printer has the responsibility to set 
	the object's #output: and #nextUpdate:."

	printer := aPrinter
]

{ #category : #'api - running' }
BrUpdatingDateAndTimeTask >> stop [ 
	super stop.
	delay := 0 milliSeconds
]
