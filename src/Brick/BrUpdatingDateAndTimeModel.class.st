"
I am a {{gtClass:BrWidgetModel | label=widget model}}, representing {{gtClass:DateAndTime}} instances in a human readable way as a duration since a present moment, e.g., ""just now"", ""1 minute ago"". 
#Usage
The following method shows how can I be initialized: {{gtExample:BrDateAndTimeSinceNowPrinterExamples >> #newTimeElement }}

#Examples
The following method shows how a {{gtClass:DateAndTime}} instance can be set or updated: {{gtExample: BrDateAndTimeSinceNowPrinterExamples >> #asDemoLabelElement | codeExpanded=false | previewExpanded=true}}


"
Class {
	#name : #BrUpdatingDateAndTimeModel,
	#superclass : #BrWidgetModel,
	#instVars : [
		'timeTask',
		'dateAndTime',
		'printer'
	],
	#category : #'Brick-Time - Support'
}

{ #category : #'api - initialization' }
BrUpdatingDateAndTimeModel >> dateAndTime: aDateAndTime [
	dateAndTime := aDateAndTime.

	self updateTimeTask
]

{ #category : #'api - hooks' }
BrUpdatingDateAndTimeModel >> onInstalledIn: anElement [
	super onInstalledIn: anElement.

	self updateTimeTask
]

{ #category : #'api - hooks' }
BrUpdatingDateAndTimeModel >> onUninstalledIn: anElement [
	timeTask ifNotNil: [ :aTask | aTask stop ].

	super onUninstalledIn: anElement
]

{ #category : #'api - initialization' }
BrUpdatingDateAndTimeModel >> printer: anObject [
	printer := anObject
]

{ #category : #actions }
BrUpdatingDateAndTimeModel >> stopUpdateTask [
	timeTask ifNotNil: [ :aTask | aTask stop ]. 
]

{ #category : #accessing }
BrUpdatingDateAndTimeModel >> updateTimeTask [
	self
		widgetDo: [ :aWidget | 
			timeTask ifNotNil: [ :aTask | aTask stop ].
			dateAndTime ifNotNil: [ :aDateAndTime | 
				timeTask := BrUpdatingDateAndTimeTask new
					dateAndTime: aDateAndTime.
				printer ifNotNil: [ :aPrinter | 
					timeTask printer: printer ].
				aWidget enqueueTask: timeTask ] ]
]
