Class {
	#name : #BrGlamorousMaximizerOverlayContentStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'overlayElement'
	],
	#category : #'Brick-Glamorous-Maximizer'
}

{ #category : #'api - instantiation' }
BrGlamorousMaximizerOverlayContentStencilBuilder >> buildDefault [
	"Content element is optional and the stencil builder can return `nil` value.
	
	Overlay content element is:
	- an at-any-level child of a given overlay element, or
	- a new element which is later added as a child to the given overlay element."

	<return: #BrStencil or: #BlElement>
	^ nil
]

{ #category : #'api - instantiation' }
BrGlamorousMaximizerOverlayContentStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.

	aStencilExecutor push: overlayElement
]

{ #category : #initialization }
BrGlamorousMaximizerOverlayContentStencilBuilder >> reset [
	super reset.

	overlayElement := nil
]
