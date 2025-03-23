Class {
	#name : #BrMenuTooltipEventHandler,
	#superclass : #BrMenuMouseEventHandler,
	#instVars : [
		'hideLaterTask',
		'showLaterTask',
		'menuElementMouseEnterEventHandler',
		'menuElementMouseLeaveEventHandler',
		'hideDelay',
		'showDelay'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #private }
BrMenuTooltipEventHandler >> cancelHideLaterTask [
	hideLaterTask ifNotNil: [ :aTask | aTask stop ].
	hideLaterTask := nil
]

{ #category : #private }
BrMenuTooltipEventHandler >> cancelShowLaterTask [
	showLaterTask ifNotNil: [ :aTask | aTask stop ].
	showLaterTask := nil
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> clickEvent: anEvent [
	(self wantToShowDueToEnterEvent: anEvent) ifFalse: [ ^ self ].
	anEvent consumed: true.
	self cancelShowLaterTask.
	self cancelHideLaterTask.
	self hide
]

{ #category : #initialization }
BrMenuTooltipEventHandler >> defaultHideDelay [
	^ 300 milliSeconds
]

{ #category : #initialization }
BrMenuTooltipEventHandler >> defaultShowDelay [
	^ 1000 milliSeconds
]

{ #category : #'api - accessing' }
BrMenuTooltipEventHandler >> eventsToHandle [
	^ {BlMouseEnterEvent.
		BlMouseLeaveEvent.
		BlClickEvent.
		BrMenuIsHiddenEvent.
		BrMenuIsVisibleEvent.
		BrMenuElementAdded.
		BrMenuElementRemoved}
]

{ #category : #accessing }
BrMenuTooltipEventHandler >> hideDelay [
	^ hideDelay ifNil: [ hideDelay := self defaultHideDelay ]
]

{ #category : #accessing }
BrMenuTooltipEventHandler >> hideDelay: aDuration [
	hideDelay := aDuration
]

{ #category : #initialization }
BrMenuTooltipEventHandler >> initialize [
	super initialize.
	menuElementMouseEnterEventHandler := BlEventHandler
			on: BlMouseEnterEvent
			do: [ :anEvent | self onMenuElementMouseEnterEvent: anEvent ].
	menuElementMouseLeaveEventHandler := BlEventHandler
			on: BlMouseLeaveEvent
			do: [ :anEvent | self onMenuElementMouseLeaveEvent: anEvent ]
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> menuElementAddedEvent: anEvent [
	"Register mouse enter and leave events, detecting when to hide/show tooltip."

	anEvent source == menuAptitude ifFalse: [ ^ self ].
	
	anEvent
		menuElementDo: [ :anElement | 
			anElement addEventHandler: menuElementMouseEnterEventHandler.
			anElement addEventHandler: menuElementMouseLeaveEventHandler ]
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> menuElementRemovedEvent: anEvent [
	"Unregister mouse enter and leave events from a removed menu element."

	anEvent source == menuAptitude ifFalse: [ ^ self ].
	
	anEvent
		menuElementDo: [ :anElement | 
			anElement removeEventHandler: menuElementMouseEnterEventHandler.
			anElement removeEventHandler: menuElementMouseLeaveEventHandler ]
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> menuIsHiddenEvent: anEvent [
	anEvent source == menuAptitude ifFalse: [ ^ self ].

	self cancelShowLaterTask.
	self cancelHideLaterTask
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> menuIsVisibleEvent: anEvent [
	anEvent source == menuAptitude ifFalse: [ ^ self ].

	self cancelShowLaterTask
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> mouseEnterEvent: anEvent [
	"The user mouse entered the anchor widget. 
	Let's therefore:
	- cancel any hide-later-task in case a tooltip is already visible, and
	- start new show-later-task in case a tooltip is not visible."

	self cancelHideLaterTask.
	(self wantToShowDueToEnterEvent: anEvent) ifFalse: [ ^ self ].
	self startShowLaterTaskDueToEvent: anEvent
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> mouseLeaveEvent: anEvent [
	"The user mouse left the anchor widget. 
	Let's therefore:
	- cancel any show-later-task in case a tooltip is about to be displayed, and
	- start new hide-later-task in case a tooltip is already visible."

	self cancelShowLaterTask.
	self startHideLaterTaskDueToEvent: anEvent
]

{ #category : #private }
BrMenuTooltipEventHandler >> onMenuElementMouseEnterEvent: anEvent [
	"The user mouse entered the menu element.
	Let's therefore cancel any hide-later-task."

	self cancelHideLaterTask
]

{ #category : #private }
BrMenuTooltipEventHandler >> onMenuElementMouseLeaveEvent: anEvent [
	"The user mouse left the menu element.
	Let's therefore start the hide-later-task."

	self startHideLaterTaskDueToEvent: anEvent
]

{ #category : #accessing }
BrMenuTooltipEventHandler >> showDelay [
	^ showDelay ifNil: [ showDelay := self defaultShowDelay ]
]

{ #category : #accessing }
BrMenuTooltipEventHandler >> showDelay: aDuration [
	showDelay := aDuration
]

{ #category : #private }
BrMenuTooltipEventHandler >> startHideLaterTaskDueToEvent: anEvent [ 
	| aTask |
	self cancelHideLaterTask.
	
	hideLaterTask := aTask := BlDelayedTaskAction new
			delay: self hideDelay;
			action: [ 
				self hide.
				hideLaterTask := nil ];
			yourself.
			
	self widgetDo: [ :aWidget | 
		aWidget enqueueTask: aTask ]
]

{ #category : #private }
BrMenuTooltipEventHandler >> startShowLaterTaskDueToEvent: anEvent [
	| aTask |
	self canShow ifFalse: [ ^ self ].
	self cancelShowLaterTask.
	
	showLaterTask := aTask := BlDelayedTaskAction new
		delay: self showDelay;
		action: [ 
			self showDueTo: anEvent. 
			showLaterTask := nil ];
		yourself.
		
	self widgetDo: [ :aWidget | 
		aWidget enqueueTask: aTask ]
]

{ #category : #private }
BrMenuTooltipEventHandler >> wantToShowDueToEnterEvent: anEvent [
	^ menuAptitude ifNotNil: #canShow ifNil: [ false ]
]
