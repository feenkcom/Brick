Class {
	#name : #BrGlamorousMaximizerOverlayHostAptitude,
	#superclass : #BrMaximizerHostAptitude,
	#traits : 'TBlElementQuery',
	#classTraits : 'TBlElementQuery classTrait',
	#instVars : [
		'targetQuery',
		'overlayStencilBuilder',
		'closeButtonStencil',
		'contentElementBuilderStencil'
	],
	#category : #'Brick-Glamorous-Maximizer'
}

{ #category : #'api - initialization' }
BrGlamorousMaximizerOverlayHostAptitude >> closeButton: aStencil [
	closeButtonStencil := aStencil asStencil
]

{ #category : #'api - initialization' }
BrGlamorousMaximizerOverlayHostAptitude >> contentElement: aStencilBuilder [
	"Set a content element which is added as an overlay element child.
	The stencil builder receives an overlay element argument: [ :anOverlayElement | nil ].
	
	The stencil builder returns:
	- `nil` value (and the overlay element is thefore used, content element is optional), or
	- an at-any-level child of a given overlay element, or
	- a new element which is later added as a child to the given overlay element.
	
	Both, element-to-maximize and close button are added
	- to the content element, or
	- to the overlay element if the content element is not defined."

	contentElementBuilderStencil := aStencilBuilder asStencilBuilder: BrGlamorousMaximizerOverlayContentStencilBuilder
]

{ #category : #initialization }
BrGlamorousMaximizerOverlayHostAptitude >> initialize [
	super initialize.
	
	"empty selector, means we apply it on the widget itself"
	targetQuery := BlElementLazyQuery new.

	overlayStencilBuilder := BrGlamorousMaximizerOverlayStencilBuilder new.
	contentElementBuilderStencil := BrGlamorousMaximizerOverlayContentStencilBuilder new.
	closeButtonStencil := BrGlamorousMaximizerCloseButtonStencil new
]

{ #category : #hooks }
BrGlamorousMaximizerOverlayHostAptitude >> onMaximize: aMaximizeWish [
	| hostElement overlayElement contentElement |
	hostElement := (targetQuery findOne: self widget) result.

	overlayElement := overlayStencilBuilder
			preferredBackground: aMaximizeWish preferredBackground;
			attachTo: hostElement;
			asElement.

	contentElement := contentElementBuilderStencil build ifNotNil: #asElement.
	
	BrGlamorousMaximizerSwitcher new
			maximizerAptitude: aMaximizeWish maximizerAptitude;
			hostElement: hostElement;
			elementToMaximize: aMaximizeWish elementToMaximize;
			containerElement: overlayElement;
			contentElement: contentElement;
			closeButton: closeButtonStencil asElement;
			switch
]

{ #category : #'api - initialization' }
BrGlamorousMaximizerOverlayHostAptitude >> overlay: aStencilBuilder [
	overlayStencilBuilder := aStencilBuilder asStencilBuilder: BrGlamorousMaximizerOverlayStencilBuilder
]

{ #category : #'api - query' }
BrGlamorousMaximizerOverlayHostAptitude >> queryStep: aBlElementStep [
	targetQuery queryStep: aBlElementStep
]
