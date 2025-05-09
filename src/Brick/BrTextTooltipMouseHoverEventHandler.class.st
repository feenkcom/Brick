"
I am {{gtClass:BrPopoverMouseHoverEventHandler}}, dedicated for editor text tooltip attributes.
I am used by {{gtClass:BrTextTooltipAttribute}}. 

"
Class {
	#name : #BrTextTooltipMouseHoverEventHandler,
	#superclass : #BrPopoverMouseHoverEventHandler,
	#instVars : [
		'isEnabled',
		'aptitudeId'
	],
	#category : #'Brick-Attributes - Support'
}

{ #category : #accessing }
BrTextTooltipMouseHoverEventHandler >> aptitudeId [
	^ aptitudeId
]

{ #category : #accessing }
BrTextTooltipMouseHoverEventHandler >> aptitudeId: anObject [
	aptitudeId := anObject
]

{ #category : #'api - accessing' }
BrTextTooltipMouseHoverEventHandler >> eventsToHandle [
	^ Array
		streamContents: [ :aStream | 
			aStream
				nextPutAll: super eventsToHandle;
				nextPut: BrTextTooltipEnableMouseEventHandlerWish;
				nextPut: BrTextTooltipDisableMouseEventHandlerWish;
				nextPut: BrTextTooltipSetAptitudeIdWish ]
]

{ #category : #initialization }
BrTextTooltipMouseHoverEventHandler >> initialize [
	super initialize.
	isEnabled := false
]

{ #category : #accessing }
BrTextTooltipMouseHoverEventHandler >> isEnabled [
	^ isEnabled ifNil: [ false ]
]

{ #category : #accessing }
BrTextTooltipMouseHoverEventHandler >> isEnabled: aBoolean [
	isEnabled := aBoolean
]

{ #category : #printing }
BrTextTooltipMouseHoverEventHandler >> printOn: aStream [
	super printOn: aStream.
	self aptitudeId ifNil: [ ^ self ].

	self aptitudeId printIdOn: aStream
]

{ #category : #private }
BrTextTooltipMouseHoverEventHandler >> startShowLaterTaskDueToEvent: anEvent [
	self isEnabled ifFalse: [ ^ self ].
	super startShowLaterTaskDueToEvent: anEvent
]

{ #category : #'api - event managing' }
BrTextTooltipMouseHoverEventHandler >> textTooltipDisableMouseEventHandlerWish: aWish [
	self aptitudeId = aWish aptitudeId ifFalse: [ ^ self ].
	aWish consumed: true.
	self isEnabled: false.
	self cancelShowLaterTask.
	self startHideLaterTaskDueToEvent: aWish dueToEvent
]

{ #category : #'api - event managing' }
BrTextTooltipMouseHoverEventHandler >> textTooltipEnableMouseEventHandlerWish: aWish [
	self aptitudeId = aWish aptitudeId ifFalse: [ ^ self ].
	aWish consumed: true.
	self isEnabled: true.
	self cancelHideLaterTask.
	self startShowLaterTaskDueToEvent: aWish dueToEvent
]

{ #category : #'api - event managing' }
BrTextTooltipMouseHoverEventHandler >> textTooltipSetAptitudeIdWish: aWish [
	self aptitudeId: aWish aptitudeId.
	aWish consumed: true.
]
