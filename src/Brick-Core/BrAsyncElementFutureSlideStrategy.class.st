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
BrAsyncElementFutureSlideStrategy >> needsUpdate: anElement [
	^ self slide slideShow slidesContainer topMostParent isAttachedToSceneGraph
]

{ #category : #accessing }
BrAsyncElementFutureSlideStrategy >> slide [
	^ slide
]

{ #category : #accessing }
BrAsyncElementFutureSlideStrategy >> slide: aSlide [
	slide := aSlide
]
