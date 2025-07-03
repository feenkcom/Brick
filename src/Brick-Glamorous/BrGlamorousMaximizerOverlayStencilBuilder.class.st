Class {
	#name : #BrGlamorousMaximizerOverlayStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'attachTo',
		'preferredBackground'
	],
	#category : #'Brick-Glamorous-Maximizer'
}

{ #category : #accessing }
BrGlamorousMaximizerOverlayStencilBuilder >> attachTo [
	^ attachTo
]

{ #category : #accessing }
BrGlamorousMaximizerOverlayStencilBuilder >> attachTo: anObject [
	attachTo := anObject
]

{ #category : #'api - instantiation' }
BrGlamorousMaximizerOverlayStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	^ BlOverlayElement new
		id: #'maximizer--overlay';
		in: [ :theOverlay | 
			theOverlay
				background: (self preferredBackground ifNil: [ theOverlay theme default backdropBackground ]).
			self attachTo ifNotNil: [ :anElement | theOverlay attachTo: anElement ] ];
		layout: BlFrameLayout new;
		padding: (BlInsets all: 20);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]

{ #category : #'api - instantiation' }
BrGlamorousMaximizerOverlayStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: self attachTo;
		push: self preferredBackground
]

{ #category : #accessing }
BrGlamorousMaximizerOverlayStencilBuilder >> preferredBackground [
	^ preferredBackground
]

{ #category : #accessing }
BrGlamorousMaximizerOverlayStencilBuilder >> preferredBackground: aBackground [
	preferredBackground := aBackground
]

{ #category : #'api - instantiation' }
BrGlamorousMaximizerOverlayStencilBuilder >> reset [
	super reset.
	attachTo := nil.
	preferredBackground := nil
]
