"
I cache {{gtClass:BrWithExplicitPopoverAptitude}} instances for a given text line element.
I am used by {{gtClass:BrTextTooltipAttribute}} and {{gtClass:BrTextTooltipMouseHoverEventHandler}}. 
I inform the event handler, that it should be disabled and its tooltip hidden. 

"
Class {
	#name : #BrTextTooltipDisableMouseEventHandlerWish,
	#superclass : #BrPopoverWish,
	#instVars : [
		'aptitudeId',
		'dueToEvent'
	],
	#category : #'Brick-Attributes - Support'
}

{ #category : #accessing }
BrTextTooltipDisableMouseEventHandlerWish >> aptitudeId [
	^ aptitudeId
]

{ #category : #accessing }
BrTextTooltipDisableMouseEventHandlerWish >> aptitudeId: anObject [
	aptitudeId := anObject
]

{ #category : #accessing }
BrTextTooltipDisableMouseEventHandlerWish >> dueToEvent [
	^ dueToEvent
]

{ #category : #accessing }
BrTextTooltipDisableMouseEventHandlerWish >> dueToEvent: anObject [
	dueToEvent := anObject
]

{ #category : #printing }
BrTextTooltipDisableMouseEventHandlerWish >> printOn: aStream [
	super printOn: aStream.
	self aptitudeId ifNil: [ ^ self ].

	self aptitudeId printIdOn: aStream
]

{ #category : #sending }
BrTextTooltipDisableMouseEventHandlerWish >> sendTo: anObject [
	anObject textTooltipDisableMouseEventHandlerWish: self
]
