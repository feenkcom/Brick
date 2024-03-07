Class {
	#name : #BrDateAndTimeLabel,
	#superclass : #Object,
	#instVars : [
		'output',
		'nextUpdate',
		'time',
		'now',
		'duration',
		'absolute'
	],
	#category : #'Brick-Time - Support'
}

{ #category : #'api - accessing' }
BrDateAndTimeLabel >> absolute [
	<return: #Duration>
	^ absolute ifNil: [ absolute := self duration abs ]
]

{ #category : #'api - accessing' }
BrDateAndTimeLabel >> duration [
	<return: #Duration>
	^ duration ifNil: [ duration := now - time ]
]

{ #category : #printing }
BrDateAndTimeLabel >> gtDisplayOn: stream [
	self output ifNil: [ ^ super gtDisplayOn: stream ].
	self output gtDisplayOn: stream
]

{ #category : #'gt - extensions' }
BrDateAndTimeLabel >> gtOverview [
	| aDictionary |
	aDictionary := OrderedDictionary new.

	self time <= self now
		ifTrue: [ aDictionary
				at: 'Time' put: self time;
				at: 'Now' put: self now ]
		ifFalse: [ aDictionary
				at: 'Now' put: self now;
				at: 'Time' put: self time ].

	aDictionary
		at: 'Duration' put: self duration;
		at: 'Absolute duration' put: self absolute;
		at: 'Time <= Now' put: self isPositive;
		at: 'Output' put: self output;
		at: 'Next update at [time]' put: self nextUpdate.

	self hasNextUpdate ifTrue: [ 
		aDictionary 
			at: 'Next update in [duration]' 
			put: self nextUpdateIn ].

	^ aDictionary
]

{ #category : #'gt - extensions' }
BrDateAndTimeLabel >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Time';
		priority: 1;
		items: [ self gtOverview associations ];
		column: 'Name' text: #key;
		column: 'Value' text: #value weight: 2;
		send: #value
]

{ #category : #'api - testing' }
BrDateAndTimeLabel >> hasNextUpdate [
	<return: #Boolean>
	^ self nextUpdate isNotNil
]

{ #category : #'api - testing' }
BrDateAndTimeLabel >> hasOutput [
	<return: #Boolean>
	^ self output isNotNil
]

{ #category : #'api - testing' }
BrDateAndTimeLabel >> isPositive [
	^ self duration = self absolute
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> nextUpdate [
	"Return when the time output should be updated."

	<return: #DateAndTime>
	^ nextUpdate
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> nextUpdate: aDateAndTime [
	"Set when the time output should be updated."

	nextUpdate := aDateAndTime
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> nextUpdateIn [
	^ self hasNextUpdate
		ifTrue: [ self nextUpdate - self now ]
		ifFalse: [ 0 seconds ]
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> nextUpdateIn: aDuration [
	| aTime |
	aTime := self now + aDuration.
	self nextUpdate: aTime
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> nextUpdateWithin: aDuration [
	| aDiff |
	aDiff := aDuration - self duration + (self duration roundDownTo: aDuration).
	self nextUpdateIn: aDiff
]

{ #category : #'api - accessing' }
BrDateAndTimeLabel >> now [
	"Return the current date and time."

	<return: #DateAndTime>
	^ now
]

{ #category : #'api - initialization' }
BrDateAndTimeLabel >> now: aDateAndTime [
	"Set the current date and time."

	now := aDateAndTime
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> output [
	"Return the time output that should be displayed"

	<return: #String>
	^ output
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> output: aString [
	"Set the time output that should be displayed"

	output := aString
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> output: aString in: aDuration [
	self output: aString.
	self nextUpdateIn: aDuration
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> output: aString within: aDuration [
	self output: aString.
	self nextUpdateWithin: aDuration
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> outputDate [
	self output: self time asDate asString within: 1 day
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> outputNumber: anInteger unit: aUnit [
	| anOutput |
	anOutput := String
			streamContents: [ :aStream | 
				self isPositive ifFalse: [ aStream nextPutAll: 'in ' ].
				aStream nextPutAll: anInteger asString.
				aStream space.
				aStream nextPutAll: (aUnit asPluralBasedOn: anInteger).
				self isPositive ifTrue: [ aStream nextPutAll: ' ago' ] ].

	self output: anOutput
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> outputNumber: anInteger unit: aUnit in: aDuration [
	self outputNumber: anInteger unit: aUnit.
	self nextUpdateIn: aDuration
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> outputNumber: anInteger unit: aUnit within: aDuration [
	self outputNumber: anInteger unit: aUnit.
	self nextUpdateWithin: aDuration
]

{ #category : #'api - output' }
BrDateAndTimeLabel >> outputRelative: aString within: aDuration [
	| anOutput |
	anOutput := String
			streamContents: [ :aStream | 
				self isPositive ifFalse: [ aStream nextPutAll: 'in ' ].
				aStream nextPutAll: aString.
				self isPositive ifTrue: [ aStream nextPutAll: ' ago' ] ].
	self output: anOutput.
	self nextUpdateWithin: aDuration
]

{ #category : #printing }
BrDateAndTimeLabel >> printOn: aStream [
	super printOn: aStream.
	self output ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		nextPutAll: self output asString;
		nextPut: $)
]

{ #category : #'api - accessing' }
BrDateAndTimeLabel >> time [
	"Return the date and time that should be displayed."

	<return: #DateAndTime>
	^ time
]

{ #category : #'api - initialization' }
BrDateAndTimeLabel >> time: aDateAndTime [
	"Return the date and time that should be displayed."

	time := aDateAndTime
]
