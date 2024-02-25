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
	| aDuration |
	aDuration := aTimeLabel absolute.
	aDuration < 15 seconds
		ifTrue: [ ^ aTimeLabel output: 'just now' within: 15 seconds ].
	aDuration < 1 minute
		ifTrue: [ ^ aTimeLabel outputRelative: 'less than minute' within: 1 minute ].
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
	aDuration < 2 days
		ifTrue: [ ^ aTimeLabel
				output: (aTimeLabel isPositive ifTrue: [ 'yesterday' ] ifFalse: [ 'tomorrow' ])
				within: 1 day ].
	aDuration < 30 days
		ifTrue: [ ^ aTimeLabel
				outputNumber: aDuration days
				unit: 'day'
				within: 1 day ].
	^ aTimeLabel outputDate
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
