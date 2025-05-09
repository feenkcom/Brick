"
I am {{gtClass:BrPopoverMouseHoverEventHandler}}, dedicated for editor text tooltip attributes.
I am used by {{gtClass:BrTextTooltipAttribute}}. 

"
Class {
	#name : #BrTextTooltipMouseHoverEventHandler,
	#superclass : #BrPopoverMouseHoverEventHandler,
	#instVars : [
		'isEnabled',
		'subtext'
	],
	#category : #'Brick-Attributes - Support'
}

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
	self subtext ifNil: [ ^ self ].

	self subtext printIdOn: aStream
]

{ #category : #private }
BrTextTooltipMouseHoverEventHandler >> startShowLaterTaskDueToEvent: anEvent [
	self isEnabled ifFalse: [ ^ self ].
	super startShowLaterTaskDueToEvent: anEvent
]

{ #category : #accessing }
BrTextTooltipMouseHoverEventHandler >> subtext [
	^ subtext
]

{ #category : #accessing }
BrTextTooltipMouseHoverEventHandler >> subtext: aSubtext [
	subtext := aSubtext
]

{ #category : #'api - event managing' }
BrTextTooltipMouseHoverEventHandler >> textTooltipDisableMouseEventHandlerWish: aWish [
	self subtext = aWish subtext ifFalse: [ ^ self ].
	aWish consumed: true.
	self isEnabled: false.
	self cancelShowLaterTask.
	self startHideLaterTaskDueToEvent: aWish dueToEvent
]

{ #category : #'api - event managing' }
BrTextTooltipMouseHoverEventHandler >> textTooltipEnableMouseEventHandlerWish: aWish [
	self subtext = aWish subtext ifFalse: [ ^ self ].
	aWish consumed: true.
	self isEnabled: true.
	self cancelHideLaterTask.
	self startShowLaterTaskDueToEvent: aWish dueToEvent
]

{ #category : #'api - event managing' }
BrTextTooltipMouseHoverEventHandler >> textTooltipSetAptitudeIdWish: aWish [
	self subtext: aWish subtext.
	aWish consumed: true.
]
