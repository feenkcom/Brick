"
I cache {{gtClass:BrWithExplicitPopoverAptitude}} instances for a given text line element.
I am used by {{gtClass:BrTextTooltipAttribute}} and {{gtClass:BrTextTooltipMouseHoverEventHandler}}. 
I inform the event handler, that it can be enabled and tooltip displayed. 

"
Class {
	#name : #BrTextTooltipEnableMouseEventHandlerWish,
	#superclass : #BrPopoverWish,
	#instVars : [
		'aptitudeId',
		'dueToEvent'
	],
	#category : #'Brick-Editor-Attributes - Support'
}

{ #category : #accessing }
BrTextTooltipEnableMouseEventHandlerWish >> aptitudeId [
	^ aptitudeId
]

{ #category : #accessing }
BrTextTooltipEnableMouseEventHandlerWish >> aptitudeId: anObject [
	aptitudeId := anObject
]

{ #category : #accessing }
BrTextTooltipEnableMouseEventHandlerWish >> dueToEvent [
	^ dueToEvent
]

{ #category : #accessing }
BrTextTooltipEnableMouseEventHandlerWish >> dueToEvent: anObject [
	dueToEvent := anObject
]

{ #category : #sending }
BrTextTooltipEnableMouseEventHandlerWish >> sendTo: anObject [
	anObject textTooltipEnableMouseEventHandlerWish: self
]
