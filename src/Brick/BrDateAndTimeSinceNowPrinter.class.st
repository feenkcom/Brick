"
I print {{gtClass:DateAndTime}} in a human readable duration, e.g., ""just now"", ""1 minute ago"".
See more examples in {{gtClass:BrDateAndTimeSinceNowPrinterExamples}}.
#Example
{{gtExample:BrDateAndTimeSinceNowPrinterExamples >> #asDemoListElement | codeExpanded=false | previewExpanded=true | previewHeight=480 }}
"
Class {
	#name : #BrDateAndTimeSinceNowPrinter,
	#superclass : #Object,
	#category : #'Brick-Time - Support'
}

{ #category : #'api - printing' }
BrDateAndTimeSinceNowPrinter >> after: aDuration now: aNow [
	<return: #BrDateAndTimeLabel>
	^ self time: aNow + aDuration now: aNow
]

{ #category : #'api - printing' }
BrDateAndTimeSinceNowPrinter >> before: aDuration now: aNow [
	<return: #BrDateAndTimeLabel>
	^ self time: aNow - aDuration now: aNow
]

{ #category : #'api - printing' }
BrDateAndTimeSinceNowPrinter >> build: aTimeLabel [
	^ aTimeLabel isPositive
		ifTrue: [ self buildPast: aTimeLabel ]
		ifFalse: [ self buildFuture: aTimeLabel ]
]

{ #category : #'api - printing' }
BrDateAndTimeSinceNowPrinter >> buildFuture: aTimeLabel [
	| aDuration |
	aDuration := aTimeLabel absolute.
	aTimeLabel output: 'in future'.
	aTimeLabel nextUpdateIn: aDuration.
	^ aTimeLabel
]

{ #category : #'api - printing' }
BrDateAndTimeSinceNowPrinter >> buildPast: aTimeLabel [
	| aDuration |
	aDuration := aTimeLabel absolute.
	aDuration < 15 seconds
		ifTrue: [ ^ aTimeLabel output: 'just now' in: 15 seconds - aDuration ].
	aDuration < 1 minute
		ifTrue: [ ^ aTimeLabel outputRelative: 'less than one minute' within: 1 minute ].
	aDuration < 1 hour
		ifTrue: [ ^ aTimeLabel
				outputNumber: aDuration minutes
				unit: 'minute'
				within: 1 minute ].
	aDuration < 1 day
		ifTrue: [ ^ aTimeLabel
				outputNumber: aDuration hours
				unit: 'hour'
				within: 1 hour ].
	aDuration < 2 days ifTrue: [ ^ aTimeLabel output: 'yesterday' within: 1 day ].
	aDuration < 7 days
		ifTrue: [ ^ aTimeLabel
				outputNumber: aDuration days
				unit: 'day'
				within: 1 day ].
	^ aTimeLabel outputDate
]

{ #category : #'api - printing' }
BrDateAndTimeSinceNowPrinter >> time: aTime [
	<return: #BrDateAndTimeLabel>
	^ self time: aTime now: DateAndTime now
]

{ #category : #'api - printing' }
BrDateAndTimeSinceNowPrinter >> time: aTime now: aNow [
	"Print how much time has passed until now.
	It is printed as a duration label in a simplified human readable way.
	- aTime is the time to print
	- aNow is a current time
	Both arguments are DateAndTime instances."

	<return: #BrDateAndTimeLabel>
	| aLabel |
	aLabel := BrDateAndTimeLabel new.
	aLabel time: aTime.
	aLabel now: aNow.
	self build: aLabel.
	^ aLabel
]

{ #category : #'api - printing' }
BrDateAndTimeSinceNowPrinter >> value: aBrDateAndTimeLabel [
	self build: aBrDateAndTimeLabel
]
