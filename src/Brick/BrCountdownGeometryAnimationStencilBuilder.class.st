"
I create new {{gtClass:BlAnimation}} for the {{gtClass:BrCountdownGeometryAptitude}}. 
I have two parameters:
- {{gtMethod:BrCountdownGeometryAnimationStencilBuilder>>#widget: | label=#selector}}, and 
- {{gtMethod:BrCountdownGeometryAnimationStencilBuilder>>#geometryStencil: | label=#selector}}. 

"
Class {
	#name : #BrCountdownGeometryAnimationStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'widget',
		'geometryStencil'
	],
	#category : #'Brick-Countdown - Helpers'
}

{ #category : #'api - instantiation' }
BrCountdownGeometryAnimationStencilBuilder >> buildDefault [
	^ BlNumberTransition new
		onStepDo: [ :eachOffset |  ];
		from: -90;
		to: 270;
		by: 90;
		duration: 100 milliSeconds;
		onFinishedDo: [  ]
]

{ #category : #accessing }
BrCountdownGeometryAnimationStencilBuilder >> geometryStencil [
	<return: #BlStencil of: #BlElementGeometry>
	^ geometryStencil
]

{ #category : #accessing }
BrCountdownGeometryAnimationStencilBuilder >> geometryStencil: aStencil [
	"Set a geometry stencil which creates BlElementGeometry instances."

	geometryStencil := aStencil
]

{ #category : #'api - instantiation' }
BrCountdownGeometryAnimationStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor push: widget.
	aStencilExecutor push: geometryStencil
]

{ #category : #initialization }
BrCountdownGeometryAnimationStencilBuilder >> reset [
	super reset.
	widget := nil.
	geometryStencil := nil
]

{ #category : #accessing }
BrCountdownGeometryAnimationStencilBuilder >> widget [
	<return: #BlElement>
	^ widget
]

{ #category : #accessing }
BrCountdownGeometryAnimationStencilBuilder >> widget: anElement [
	"Set an element for which animation happens"

	widget := anElement
]
