Class {
	#name : #BrAsyncElementFutureSlideStrategy,
	#superclass : #BrAsyncElementFutureUpdateStrategy,
	#instVars : [
		'slide',
		'space'
	],
	#category : #'Brick-Core-Futures'
}

{ #category : #accessing }
BrAsyncElementFutureSlideStrategy >> addEventHandlersOn: anElement withFuture: aFuture [

	| eventHandler |
	eventHandler := BlEventHandler new
		                eventClass: BlElementLayoutComputedEvent;
		                action:
			                (MessageSend
				                 receiver: aFuture
				                 selector: #onElementAddedToSceneGraph:).

	anElement addEventHandler: eventHandler
]

{ #category : #accessing }
BrAsyncElementFutureSlideStrategy >> needsUpdate: anElement [
	^ self slide slideShow slidesContainer topMostParent isVisibleInSpace
]

{ #category : #accessing }
BrAsyncElementFutureSlideStrategy >> slide [
	^ slide
]

{ #category : #accessing }
BrAsyncElementFutureSlideStrategy >> slide: aSlide [
	slide := aSlide
]
