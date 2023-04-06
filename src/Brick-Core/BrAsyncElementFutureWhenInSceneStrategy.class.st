Class {
	#name : #BrAsyncElementFutureWhenInSceneStrategy,
	#superclass : #BrAsyncElementFutureUpdateStrategy,
	#instVars : [
		'eventHandler'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureWhenInSceneStrategy >> addEventHandlersOn: anElement withFuture: aFuture [
	eventHandler := BlEventHandler new
		eventClass: BlElementAddedToSceneGraphEvent;
		action: (MessageSend 
			receiver: aFuture
			selector: #onElementAddedToSceneGraph:).

	anElement addEventHandler: eventHandler
]

{ #category : #accessing }
BrAsyncElementFutureWhenInSceneStrategy >> needsUpdate: anElement [
	^ anElement isAddedToSceneGraph
]

{ #category : #accessing }
BrAsyncElementFutureWhenInSceneStrategy >> removeEventHandlersFrom: anElement withFuture: aFuture [
	anElement removeEventHandler: eventHandler
]
