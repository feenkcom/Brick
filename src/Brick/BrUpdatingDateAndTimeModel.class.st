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
