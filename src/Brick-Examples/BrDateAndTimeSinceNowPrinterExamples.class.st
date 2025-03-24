"
I exemplify {{gtClass:BrDateAndTimeSinceNowPrinter}}. 
#Example
{{gtExample:BrDateAndTimeSinceNowPrinterExamples >> #asDemoListElement | codeExpanded=false | previewExpanded=true | previewHeight=480 }}
"
Class {
	#name : #BrDateAndTimeSinceNowPrinterExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Time - Support'
}

{ #category : #'examples - demo' }
BrDateAndTimeSinceNowPrinterExamples >> asDemoLabelElement [
	<gtExample>
	| aLabel |
	aLabel := self newTimeElement.
	aLabel
		addAptitude: BrShadowAptitude;
		background: Color white;
		padding: (BlInsets all: 30);
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].
	self updateTimeElement: aLabel time: DateAndTime now.
	^ BrFrame new
		matchParent;
		addChild: aLabel
]

{ #category : #'examples - demo' }
BrDateAndTimeSinceNowPrinterExamples >> asDemoListElement [
	<gtExample>
	^ BrVerticalPane new
		matchParent;
		addChild: (BrLabel new
				beLargeSize;
				text: 'Past time';
				aptitude: BrGlamorousLabelAptitude new bold);
		addChild: (self newColumnedListWithDurations: self pastDurations)
]

{ #category : #asserting }
BrDateAndTimeSinceNowPrinterExamples >> assertResult: aResult output: aString nextUpdate: aDateAndTime [
	self assert: aResult isNotNil description: [ 'Result must be non-nil' ].
	self assert: aResult output equals: aString.
	self assert: aResult nextUpdate equals: aDateAndTime
]

{ #category : #examples }
BrDateAndTimeSinceNowPrinterExamples >> basicPrinter [
	<gtExample>
	| aPrinter |
	aPrinter := BrDateAndTimeSinceNowPrinter new.

	^ aPrinter
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> fiftyNineMinutesAgo [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 59 minutes now: aNow.
	self
		assertResult: aResult
		output: '59 minutes ago'
		nextUpdate: aNow + 1 minutes.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> fiftyNineMinutesAgo59Minutes59Seconds [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 59 minutes + 59 seconds now: aNow.
	self
		assertResult: aResult
		output: '59 minutes ago'
		nextUpdate: aNow + 1 second.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> fiveHoursAgo [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 5 hours now: aNow.
	self
		assertResult: aResult
		output: '5 hours ago'
		nextUpdate: aNow + 1 hour.
	^ aResult
]

{ #category : #'gt - extensions' }
BrDateAndTimeSinceNowPrinterExamples >> gtDemoFor: aView [
	<gtClassView>
	^ aView explicit
		title: 'Demo';
		priority: 60;
		stencil: [ self asDemoListElement ]
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> hourAgo [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 1 hour now: aNow.
	self
		assertResult: aResult
		output: '1 hour ago'
		nextUpdate: aNow + 1 hour.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> hourAgoPlus1Second [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 1 hour + 1 second now: aNow.
	self
		assertResult: aResult
		output: '1 hour ago'
		nextUpdate: aNow + 59 minutes + 59 seconds.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> hourAgoPlus59Minutes59Seconds [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 1 hour + 59 minutes + 59 seconds now: aNow.
	self
		assertResult: aResult
		output: '1 hour ago'
		nextUpdate: aNow + 1 second.
	^ aResult
]

{ #category : #'examples - future' }
BrDateAndTimeSinceNowPrinterExamples >> inFuture [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter after: 59 minutes + 59 seconds now: aNow.
	self
		assertResult: aResult
		output: 'in future'
		nextUpdate: aNow + 59 minutes + 59 seconds.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> justNow0Seconds [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 0 seconds now: aNow.
	self
		assertResult: aResult
		output: 'just now'
		nextUpdate: aNow + 15 seconds.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> justNow14Seconds [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 14 seconds now: aNow.
	self
		assertResult: aResult
		output: 'just now'
		nextUpdate: aNow + 1 seconds.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> lessThanMinuteAgo15Seconds [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 15 seconds now: aNow.
	self
		assertResult: aResult
		output: 'less than one minute ago'
		nextUpdate: aNow + 45 seconds.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> lessThanMinuteAgo59Seconds [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 59 seconds now: aNow.
	self
		assertResult: aResult
		output: 'less than one minute ago'
		nextUpdate: aNow + 1 second.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> minuteAgo1Minute [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 1 minute now: aNow.
	self
		assertResult: aResult
		output: '1 minute ago'
		nextUpdate: aNow + 1 minutes.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> minuteAgo1Minute1Second [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 1 minute + 1 second now: aNow.
	self
		assertResult: aResult
		output: '1 minute ago'
		nextUpdate: aNow + 59 seconds.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> minuteAgo1Minute59Second [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 1 minute + 59 seconds now: aNow.
	self
		assertResult: aResult
		output: '1 minute ago'
		nextUpdate: aNow + 1 second.
	^ aResult
]

{ #category : #'examples - demo' }
BrDateAndTimeSinceNowPrinterExamples >> newColumnedListWithDurations: aCollection [
	| aList aNow allItems |
	aNow := DateAndTime now.
	allItems := aCollection collect: [ :aDuration | aNow - aDuration ].
	aList := BrColumnedList new
			matchParent;
			items: allItems.

	aList column
		matchParent;
		title: 'Widget';
		cellStencil: [ :anItemType :aColumn :anIndex | self newTimeElement ];
		dataBinder: [ :aLabel :aTime | self updateTimeElement: aLabel time: aTime ].

	aList column
		matchParent;
		title: 'Updates at';
		cellStencil: [ :anItemType :aColumn :anIndex | 
			| aLabel |
			aLabel := self newTimeElement.
			aLabel updatingDateAndTimeModel
				printer: [ :aTimeLabel | 
					| anOutput aTmpTimeLabel |
					aTmpTimeLabel := BrDateAndTimeSinceNowPrinter new
							time: aTimeLabel time
							now: aTimeLabel now.

					anOutput := 'updates in {1}'
							format: {aTmpTimeLabel nextUpdateIn gtHumanReadableString}.
					aTimeLabel output: anOutput within: 1 second ].
			aLabel ];
		dataBinder: [ :aLabel :aTime | self updateTimeElement: aLabel time: aTime ].

	^ aList
]

{ #category : #'examples - demo' }
BrDateAndTimeSinceNowPrinterExamples >> newTimeElement [
	<gtExample>
	^ BrLabel new
		updatingDateAndTimeModel;
		aptitude: BrGlamorousLabelAptitude new;
		addAptitude: (BrGlamorousWithExplicitTooltipAptitude text: '');
		yourself
]

{ #category : #support }
BrDateAndTimeSinceNowPrinterExamples >> now [
	^ '2024-02-25T11:00:00.000000+00:00' asDateAndTime
]

{ #category : #'examples - demo' }
BrDateAndTimeSinceNowPrinterExamples >> pastDurations [
	^ {0 seconds.
		14 seconds.
		15 seconds.
		16 seconds.
		59 seconds.
		1 minute.
		61 seconds.
		90 seconds.
		30 minutes.
		1 hour.
		5 hours.
		1 day + 1 second.
		5 days.
		7 days.
		95 days.
		399 days.
		5 years + 90 days}
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> sevenDaysAgo [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 7 days now: aNow.
	self
		assertResult: aResult
		output: '18 February 2024'
		nextUpdate: aNow + 1 day.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> thirtyMinutesAgo [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 30 minutes now: aNow.
	self
		assertResult: aResult
		output: '30 minutes ago'
		nextUpdate: aNow + 1 minutes.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> thirtyMinutesAnd1SecondAgo [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 30 minutes + 1 second now: aNow.
	self
		assertResult: aResult
		output: '30 minutes ago'
		nextUpdate: aNow + 59 seconds.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> twentyThreeHoursAgoPlus59Minutes59Seconds [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 23 hours + 59 minutes + 59 seconds now: aNow.
	self
		assertResult: aResult
		output: '23 hours ago'
		nextUpdate: aNow + 1 second.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> twoDaysAgo [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 2 days now: aNow.
	self
		assertResult: aResult
		output: '2 days ago'
		nextUpdate: aNow + 1 day.
	^ aResult
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> twoMinutesAgo2Minutes [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 2 minutes now: aNow.
	self
		assertResult: aResult
		output: '2 minutes ago'
		nextUpdate: aNow + 1 minutes.
	^ aResult
]

{ #category : #'examples - demo' }
BrDateAndTimeSinceNowPrinterExamples >> updateTimeElement: aLabel time: aTime [
	<gtExample>
	aLabel updatingDateAndTime: aTime.
	^ aLabel aptitude
		findActor: BrGlamorousWithExplicitTooltipAptitude
		ifFound: [ :aTooltip | 
			aTooltip
				text: (String streamContents: [ :s | aTime asLocal printSeparateDateAndTimeOn: s ]) ]
		ifNone: [  "ignore" ]
]

{ #category : #'examples - past' }
BrDateAndTimeSinceNowPrinterExamples >> yesterday [
	<gtExample>
	| aPrinter aNow aResult |
	aPrinter := self basicPrinter.
	aNow := self now.
	aResult := aPrinter before: 1 day now: aNow.
	self
		assertResult: aResult
		output: 'yesterday'
		nextUpdate: aNow + 1 day.
	^ aResult
]
