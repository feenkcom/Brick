"
I cache {{gtClass:BrWithExplicitPopoverAptitude}} instances for a given text line element.
I am used by {{gtClass:BrTextTooltipAttribute}} and {{gtClass:BrTextTooltipMouseHoverEventHandler}}. 
I inform the event handler, that it should be disabled and its tooltip hidden. 

"
Class {
	#name : #BrTextTooltipDisableMouseEventHandlerWish,
	#superclass : #BrPopoverWish,
	#instVars : [
		'dueToEvent',
		'subtext'
	],
	#category : #'Brick-Attributes - Support'
}

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
	self subtext ifNil: [ ^ self ].
	self subtext printOn: aStream
]

{ #category : #sending }
BrTextTooltipDisableMouseEventHandlerWish >> sendTo: anObject [
	anObject textTooltipDisableMouseEventHandlerWish: self
]

{ #category : #accessing }
BrTextTooltipDisableMouseEventHandlerWish >> subtext [
	^ subtext
]

{ #category : #accessing }
BrTextTooltipDisableMouseEventHandlerWish >> subtext: aSubText [
	subtext := aSubText
]
