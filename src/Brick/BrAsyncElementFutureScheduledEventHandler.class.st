"
I handle two events: {{gtClass:BrAsyncElementFutureScheduledEvent}} and {{gtClass:BrWidgetPermanentlyRemovedEvent}}. 
My responsibility is to cancel all future promises if an element is permanently removed.
"
Class {
	#name : #BrAsyncElementFutureScheduledEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'futurePromises'
	],
	#category : #'Brick-! Core - Events'
}

{ #category : #'api - convenience' }
BrAsyncElementFutureScheduledEventHandler class >> ensureEventHandlerIn: anElement [
	"In case anElement does not have this event handler, I add it."

	(anElement eventDispatcher hasEventHandlerSuchThat: [ :eachEventHandler | 
		eachEventHandler class = self ]) 
			ifTrue: [ ^ self ].
		
	anElement addEventHandler: self new
]

{ #category : #'api - event managing' }
BrAsyncElementFutureScheduledEventHandler >> asyncElementFutureScheduledEvent: anEvent [
	self registerFuturePromise: anEvent futurePromise comingFrom: anEvent target
]

{ #category : #'api - futures' }
BrAsyncElementFutureScheduledEventHandler >> cancelPendingFuturePromises [
	futurePromises asArray do: [ :eachFuturePromise | eachFuturePromise cancelHard ]
]

{ #category : #'api - accessing' }
BrAsyncElementFutureScheduledEventHandler >> eventsToHandle [
	^ {BrAsyncElementFutureScheduledEvent.
		BrWidgetPermanentlyRemovedEvent}
]

{ #category : #initialization }
BrAsyncElementFutureScheduledEventHandler >> initialize [
	super initialize.

	futurePromises := AsyncSharedOrderedCollection new
]

{ #category : #'api - futures' }
BrAsyncElementFutureScheduledEventHandler >> pendingFuturePromises [
	^ futurePromises asArray
]

{ #category : #'api - futures' }
BrAsyncElementFutureScheduledEventHandler >> registerFuturePromise: aFuturePromise comingFrom: anElement [
	futurePromises add: aFuturePromise.
	
	aFuturePromise
		then: [ self unregisterFuturePromise: aFuturePromise ]
		otherwise: [ self unregisterFuturePromise: aFuturePromise ]
]

{ #category : #'api - futures' }
BrAsyncElementFutureScheduledEventHandler >> unregisterFuturePromise: aFuturePromise [
	futurePromises remove: aFuturePromise
]

{ #category : #'api - event managing' }
BrAsyncElementFutureScheduledEventHandler >> widgetPermanentlyRemovedEvent: anEvent [
	self cancelPendingFuturePromises
]
