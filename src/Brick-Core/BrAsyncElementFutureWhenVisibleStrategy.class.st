Class {
	#name : #BrAsyncElementFutureWhenVisibleStrategy,
	#superclass : #BrAsyncElementFutureUpdateStrategy,
	#instVars : [
		'eventHandler'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureWhenVisibleStrategy >> addEventHandlersOn: anElement withFuture: aFuture [
	eventHandler := BlEventHandler new
		eventClass: BlElementLayoutComputedEvent;
		action: (MessageSend
			receiver: aFuture
			selector: #onElementAddedToSceneGraph:).
	anElement addEventHandler: eventHandler
]

{ #category : #accessing }
BrAsyncElementFutureWhenVisibleStrategy >> needsUpdate: anElement [
	^ anElement isVisibleInSpace
]

{ #category : #removing }
BrAsyncElementFutureWhenVisibleStrategy >> removeEventHandlersFrom: anElement withFuture: aFuture [
	anElement removeEventHandler: eventHandler
]
