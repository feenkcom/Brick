Class {
	#name : #BrAsyncElementFutureWhenInSceneStrategy,
	#superclass : #BrAsyncElementFutureUpdateStrategy,
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureWhenInSceneStrategy >> addEventHandlersOn: anElement withFuture: aFuture [

	| eventHandler |
	eventHandler := BlEventHandler new
		                eventClass: BlElementAddedToSceneGraphEvent;
		                action:
			                (MessageSend
				                 receiver: aFuture
				                 selector: #onElementAddedToSceneGraph:).

	anElement addEventHandler: eventHandler
]

{ #category : #accessing }
BrAsyncElementFutureWhenInSceneStrategy >> needsUpdate: anElement [
	^ anElement isAttachedToSceneGraph
]
