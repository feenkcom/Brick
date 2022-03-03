Class {
	#name : #BrSlideWidget,
	#superclass : #BrAsyncWidget,
	#instVars : [
		'slide',
		'slideElement'
	],
	#category : #'Brick-Async-Widget'
}

{ #category : #accessing }
BrSlideWidget >> defaultStrategy [
	^ BrAsyncElementFutureSlideStrategy new slide: self slide
]

{ #category : #accessing }
BrSlideWidget >> drawOnSpartaCanvas: aCanvas [

	super drawOnSpartaCanvas: aCanvas.

	"If the slide show was removed from a scene graph before all the slides were generated, 
	and then added back in to a graph, we may need to generate our slide."
	slideElement ifNil: [ 
		self needsUpdate ifFalse: [ ^ self ].

		self slide queueAsyncUpdate: self space ]
]

{ #category : #accessing }
BrSlideWidget >> needsUpdate [
	slideElement ifNotNil: [ ^false ].
	
	self slideShowIsAttachedToSceneGraph
		ifFalse: [ ^false ].

	^true
]

{ #category : #accessing }
BrSlideWidget >> slide [
	^ slide 
]

{ #category : #accessing }
BrSlideWidget >> slide: aSlide [
	slide := aSlide.
	strategy := self defaultStrategy
]

{ #category : #accessing }
BrSlideWidget >> slideElement: anElement [
	slideElement := anElement.

	self stencil: [ anElement ]
]

{ #category : #accessing }
BrSlideWidget >> slideShowIsAttachedToSceneGraph [

	"Answer a boolean indicating whether the receiver's slide show is attached to a scene graph.
	The receiver will only be attached to a scene graph while it is the current slide."

	^ self slide slideShow slidesContainer topMostParent
		  isAttachedToSceneGraph
]
