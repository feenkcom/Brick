Class {
	#name : #BrPopoverMouseHoverEventHandler,
	#superclass : #BrPopoverMouseEventHandler,
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
BrPopoverMouseHoverEventHandler >> cancelHideLaterTask [
	hideLaterTask ifNotNil: [ :aTask | aTask stop ].
	hideLaterTask := nil
]

{ #category : #private }
BrPopoverMouseHoverEventHandler >> cancelShowLaterTask [
	showLaterTask ifNotNil: [ :aTask | aTask stop ].
	showLaterTask := nil
]

{ #category : #initialization }
BrPopoverMouseHoverEventHandler >> defaultHideDelay [
	^ 300 milliSeconds
]

{ #category : #initialization }
BrPopoverMouseHoverEventHandler >> defaultShowDelay [
	^ 1000 milliSeconds
]

{ #category : #'api - accessing' }
BrPopoverMouseHoverEventHandler >> eventsToHandle [
	^ {BlMouseEnterEvent.
		BlMouseLeaveEvent.
		BrPopoverIsHiddenEvent.
		BrPopoverIsVisibleEvent.
		BrPopoverElementAdded.
		BrPopoverElementRemoved}
]

{ #category : #accessing }
BrPopoverMouseHoverEventHandler >> hideDelay [
	^ hideDelay ifNil: [ hideDelay := self defaultHideDelay ]
]

{ #category : #accessing }
BrPopoverMouseHoverEventHandler >> hideDelay: aDuration [
	hideDelay := aDuration
]

{ #category : #initialization }
BrPopoverMouseHoverEventHandler >> initialize [
	super initialize.
	menuElementMouseEnterEventHandler := BlEventHandler
			on: BlMouseEnterEvent
			do: [ :anEvent | self onMenuElementMouseEnterEvent: anEvent ].
	menuElementMouseLeaveEventHandler := BlEventHandler
			on: BlMouseLeaveEvent
			do: [ :anEvent | self onMenuElementMouseLeaveEvent: anEvent ]
]

{ #category : #'api - event managing' }
BrPopoverMouseHoverEventHandler >> menuElementAddedEvent: anEvent [
	"Register mouse enter and leave events, detecting when to hide/show tooltip."

	anEvent source == menuAptitude ifFalse: [ ^ self ].
	
	anEvent
		menuElementDo: [ :anElement | 
			anElement addEventHandler: menuElementMouseEnterEventHandler.
			anElement addEventHandler: menuElementMouseLeaveEventHandler ]
]

{ #category : #'api - event managing' }
BrPopoverMouseHoverEventHandler >> menuElementRemovedEvent: anEvent [
	"Unregister mouse enter and leave events from a removed menu element."

	anEvent source == menuAptitude ifFalse: [ ^ self ].
	
	anEvent
		menuElementDo: [ :anElement | 
			anElement removeEventHandler: menuElementMouseEnterEventHandler.
			anElement removeEventHandler: menuElementMouseLeaveEventHandler ]
]

{ #category : #'api - event managing' }
BrPopoverMouseHoverEventHandler >> menuIsHiddenEvent: anEvent [
	anEvent source == menuAptitude ifFalse: [ ^ self ].

	self cancelShowLaterTask.
	self cancelHideLaterTask
]

{ #category : #'api - event managing' }
BrPopoverMouseHoverEventHandler >> menuIsVisibleEvent: anEvent [
	anEvent source == menuAptitude ifFalse: [ ^ self ].

	self cancelShowLaterTask
]

{ #category : #'api - event managing' }
BrPopoverMouseHoverEventHandler >> mouseEnterEvent: anEvent [
	"The user mouse entered the anchor widget. 
	Let's therefore:
	- cancel any hide-later-task in case a tooltip is already visible, and
	- start new show-later-task in case a tooltip is not visible."

	self cancelHideLaterTask.
	(self wantToShowDueToEnterEvent: anEvent) ifFalse: [ ^ self ].
	self startShowLaterTaskDueToEvent: anEvent
]

{ #category : #'api - event managing' }
BrPopoverMouseHoverEventHandler >> mouseLeaveEvent: anEvent [
	"The user mouse left the anchor widget. 
	Let's therefore:
	- cancel any show-later-task in case a tooltip is about to be displayed, and
	- start new hide-later-task in case a tooltip is already visible."

	self cancelShowLaterTask.
	self startHideLaterTaskDueToEvent: anEvent
]

{ #category : #private }
BrPopoverMouseHoverEventHandler >> onMenuElementMouseEnterEvent: anEvent [
	"The user mouse entered the menu element.
	Let's therefore cancel any hide-later-task."

	self cancelHideLaterTask
]

{ #category : #private }
BrPopoverMouseHoverEventHandler >> onMenuElementMouseLeaveEvent: anEvent [
	"The user mouse left the menu element.
	Let's therefore start the hide-later-task."

	self startHideLaterTaskDueToEvent: anEvent
]

{ #category : #accessing }
BrPopoverMouseHoverEventHandler >> showDelay [
	^ showDelay ifNil: [ showDelay := self defaultShowDelay ]
]

{ #category : #accessing }
BrPopoverMouseHoverEventHandler >> showDelay: aDuration [
	showDelay := aDuration
]

{ #category : #private }
BrPopoverMouseHoverEventHandler >> startHideLaterTaskDueToEvent: anEvent [ 
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
BrPopoverMouseHoverEventHandler >> startShowLaterTaskDueToEvent: anEvent [
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
BrPopoverMouseHoverEventHandler >> wantToShowDueToEnterEvent: anEvent [
	^ menuAptitude ifNotNil: #canShow ifNil: [ false ]
]
