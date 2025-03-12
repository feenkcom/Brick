Class {
	#name : #BrMenuTooltipEventHandler,
	#superclass : #BrMenuMouseEventHandler,
	#instVars : [
		'hideLaterTask',
		'showLaterTask'
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
	(self wantToShowDueToEnterEvent: anEvent) ifFalse: [ ^ self ].
	self cancelHideLaterTask.
	self startShowLaterTaskDueToEvent: anEvent
]

{ #category : #'api - event managing' }
BrMenuTooltipEventHandler >> mouseLeaveEvent: anEvent [
	self cancelShowLaterTask.
	self startHideLaterTaskDueToEvent: anEvent
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
BrMenuTooltipEventHandler >> wantToShowDueToEnterEvent: anEvent [
	^ menuAptitude ifNotNil: #canShow ifNil: [ false ]
]
