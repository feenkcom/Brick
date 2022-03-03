Class {
	#name : #BrAsyncElementFutureWhenVisibleStrategy,
	#superclass : #BrAsyncElementFutureUpdateStrategy,
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureWhenVisibleStrategy >> addEventHandlersOn: anElement onFuture: aFuture [

	| eventHandler |
	eventHandler := BlEventHandler new
		                eventClass: BlElementLayoutChangedEvent;
		                action:
			                (MessageSend
				                 receiver: aFuture
				                 selector: #onElementAddedToSceneGraph:).

	anElement addEventHandler: eventHandler
]

{ #category : #accessing }
BrAsyncElementFutureWhenVisibleStrategy >> needsUpdate: anElement [
	^ anElement isVisibleInSpace
]
