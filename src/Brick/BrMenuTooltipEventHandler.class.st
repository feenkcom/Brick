Class {
	#name : #BrMenuTooltipEventHandler,
	#superclass : #BrMenuMouseEventHandler,
	#instVars : [
		'hideLaterTask',
		'showLaterTask',
		'containerMouserOverEventHandler',
		'containerMouserOutEventHandler'
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
	self cancelShowLaterTask.
	self cancelHideLaterTask.
	self hide
]

{ #category : #'api - accessing' }
BrMenuTooltipEventHandler >> eventsToHandle [
	^ {BlMouseEnterEvent.
		BlMouseLeaveEvent.
		BlClickEvent.
		BrMenuIsHiddenEvent.
		BrMenuIsVisibleEvent}
]

{ #category : #accessing }
BrMenuTooltipEventHandler >> hideDelay [
	^ 300 milliSeconds
]

{ #category : #initialization }
BrMenuTooltipEventHandler >> initialize [
	super initialize.

	containerMouserOverEventHandler := BlEventHandler
			on: BlMouseOverEvent
			do: [ :anEvent | self onContainerMouseOverEvent: anEvent ].
	containerMouserOutEventHandler := BlEventHandler
			on: BlMouseOutEvent
			do: [ :anEvent | self onContainerMouseOutEvent: anEvent ]
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> menuIsHiddenEvent: anEvent [
	self cancelShowLaterTask.
	self cancelHideLaterTask.
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> menuIsVisibleEvent: anEvent [
	self cancelShowLaterTask.
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> mouseEnterEvent: anEvent [
	"The user mouse entered the anchor widget. 
	Let's therefore:
	- cancel any hide-later-task in case a tooltip is already visible, and
	- start new show-later-task."

	self cancelHideLaterTask.
	(self wantToShowDueToEnterEvent: anEvent) ifFalse: [ ^ self ].
	self startShowLaterTaskDueToEvent: anEvent
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> mouseLeaveEvent: anEvent [
	self cancelShowLaterTask.
	self startHideLaterTaskDueToEvent: anEvent
]

{ #category : #private }
BrMenuTooltipEventHandler >> onContainerMouseOutEvent: anEvent [
	"The user mouse is either:
	1. inside of a menu container child, or
	2. completely left the menu container.
	The second case happens only if the menu container does not cover whole window (a BlSpace extent).
	It can happen only with visible Driller and menu item element at the edge of the menu container. 
	We could cover this case with BlMouseLeaveEvent.
	Let's ignore this case and cancel the hide-later-task as we want to keep the menu around while the
	user mouse is hovering the menu elements."

	self cancelHideLaterTask
]

{ #category : #private }
BrMenuTooltipEventHandler >> onContainerMouseOverEvent: anEvent [
	"The user mouse is outside of any menu container child.
	Let's therefore start the hide-later-task to hide the tooltip."

	self startHideLaterTaskDueToEvent: anEvent
]

{ #category : #initialization }
BrMenuTooltipEventHandler >> onMenuAptitudeInitialized [
	super onMenuAptitudeInitialized.
	self subscribeToMenuContainer
]

{ #category : #'api - hooks' }
BrMenuTooltipEventHandler >> onUninstalledIn: anObject [
	super onUninstalledIn: anObject.
	
	self unsubscribeFromMenuContainer.
]

{ #category : #accessing }
BrMenuTooltipEventHandler >> showDelay [
	^ 1000 milliSeconds
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
BrMenuTooltipEventHandler >> subscribeToMenuContainer [
	self menuAptitude ifNotNil: [ :anAptitude | 
		anAptitude menuContainerDo: [ :aContainer | 
			aContainer addEventHandler: containerMouserOverEventHandler.
			aContainer addEventHandler: containerMouserOutEventHandler ] ].
]

{ #category : #private }
BrMenuTooltipEventHandler >> unsubscribeFromMenuContainer [
	self menuAptitude ifNotNil: [ :anAptitude | 
		anAptitude menuContainerDo: [ :aContainer | 
			aContainer removeEventHandler: containerMouserOverEventHandler.
			aContainer removeEventHandler: containerMouserOutEventHandler ] ].
]

{ #category : #private }
BrMenuTooltipEventHandler >> wantToShowDueToEnterEvent: anEvent [
	^ menuAptitude ifNotNil: #canShow ifNil: [ false ]
]
