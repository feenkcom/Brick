Class {
	#name : #BrMenuTooltipHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'hideLaterTask',
		'showLaterTask',
		'menuAptitude'
	],
	#category : #'Brick-Menu - Support'
}

{ #category : #private }
BrMenuTooltipHandler >> canHide [
	^ menuAptitude ifNotNil: #canHide ifNil: [ false ]
]

{ #category : #private }
BrMenuTooltipHandler >> canShow [
	^ menuAptitude ifNotNil: #canShow ifNil: [ false ]
]

{ #category : #private }
BrMenuTooltipHandler >> cancelHideLaterTask [
	hideLaterTask ifNotNil: [ :aTask | aTask stop ].
	hideLaterTask := nil
]

{ #category : #private }
BrMenuTooltipHandler >> cancelShowLaterTask [
	showLaterTask ifNotNil: [ :aTask | aTask stop ].
	showLaterTask := nil
]

{ #category : #'api - event managing' }
BrMenuTooltipHandler >> clickEvent: anEvent [
	(self wantToShowDueToEnterEvent: anEvent) ifFalse: [ ^ self ].
	self cancelShowLaterTask.
	self cancelHideLaterTask.
	self hide
]

{ #category : #'api - accessing' }
BrMenuTooltipHandler >> eventsToHandle [
	^ {BlMouseEnterEvent.
		BlMouseLeaveEvent.
		BlClickEvent.
		BrMenuIsHiddenEvent.
		BrMenuIsVisibleEvent}
]

{ #category : #private }
BrMenuTooltipHandler >> hide [
	"Hide tooltip"

	menuAptitude ifNotNil: #hide
]

{ #category : #accessing }
BrMenuTooltipHandler >> hideDelay [
	^ 300 milliSeconds
]

{ #category : #accessing }
BrMenuTooltipHandler >> menuAptitude [
	<return: #BrWithExplicitMenuAptitude>
	^ menuAptitude
]

{ #category : #accessing }
BrMenuTooltipHandler >> menuAptitude: aBrWithExplicitMenuAptitude [
	menuAptitude := aBrWithExplicitMenuAptitude
]

{ #category : #'api - event managing' }
BrMenuTooltipHandler >> menuIsHiddenEvent: anEvent [
	self cancelShowLaterTask.
	self cancelHideLaterTask.
]

{ #category : #'api - event managing' }
BrMenuTooltipHandler >> menuIsVisibleEvent: anEvent [
	self cancelShowLaterTask.
]

{ #category : #'api - event managing' }
BrMenuTooltipHandler >> mouseEnterEvent: anEvent [
	(self wantToShowDueToEnterEvent: anEvent) ifFalse: [ ^ self ].
	self cancelHideLaterTask.
	self startShowLaterTaskDueToEvent: anEvent
]

{ #category : #'api - event managing' }
BrMenuTooltipHandler >> mouseLeaveEvent: anEvent [
	self cancelShowLaterTask.
	self startHideLaterTaskDueToEvent: anEvent
]

{ #category : #accessing }
BrMenuTooltipHandler >> showDelay [
	^ 1000 milliSeconds
]

{ #category : #private }
BrMenuTooltipHandler >> showDueToEvent: anEvent [
	"Show tooltip"

	menuAptitude ifNotNil: [ :anAptitude | anAptitude showDueTo: anEvent ]
]

{ #category : #private }
BrMenuTooltipHandler >> startHideLaterTaskDueToEvent: anEvent [ 
	| aTask |
	self cancelHideLaterTask.
	
	hideLaterTask := aTask := BlDelayedTaskAction new
			delay: self hideDelay;
			action: [ 
				self hide.
				hideLaterTask := nil ];
			yourself.
			
	anEvent currentTarget enqueueTask: aTask
]

{ #category : #private }
BrMenuTooltipHandler >> startShowLaterTaskDueToEvent: anEvent [
	| aTask |
	self canShow ifFalse: [ ^ self ].
	self cancelShowLaterTask.
	
	showLaterTask := aTask := BlDelayedTaskAction new
		delay: self showDelay;
		action: [ 
			self showDueToEvent: anEvent. 
			showLaterTask := nil ];
		yourself.
		
	anEvent currentTarget enqueueTask: aTask
]

{ #category : #private }
BrMenuTooltipHandler >> wantToShowDueToEnterEvent: anEvent [
	^ menuAptitude ifNotNil: #canShow ifNil: [ false ]
]
