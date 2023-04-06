"
I am used to explore how {{gtClass:BlMouseProcessor}} {{gtMethod: BlMouseProcessor >> #processPicking: | label=picks}} {{gtClass:BlElement | label=elements}}. 
#Example
You can inspect a mouse processor of the following example, using `aScripter space mouseProcessor`: {{gtExample: GtWorldByScripterExamples >> #cannotClickOnCoderIssue | codeExpanded=false}}

The inspection of the mouse processor will look as follows: {{gtExample: GtWorldByScripterExamples >> #cannotClickOnCoderIssue | noCode | previewHeight=450}}
"
Class {
	#name : #BlMouseProcessorExaminedTargetElement,
	#superclass : #Object,
	#instVars : [
		'event',
		'element',
		'space'
	],
	#category : #'Brick-DevTool-Mouse Processor'
}

{ #category : #accessing }
BlMouseProcessorExaminedTargetElement >> element [
	^ element
]

{ #category : #accessing }
BlMouseProcessorExaminedTargetElement >> element: anObject [
	element := anObject
]

{ #category : #accessing }
BlMouseProcessorExaminedTargetElement >> event [
	^ event
]

{ #category : #accessing }
BlMouseProcessorExaminedTargetElement >> event: anObject [
	event := anObject
]

{ #category : #'gt - extensions' }
BlMouseProcessorExaminedTargetElement >> gtLastClickEventPickedElementFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 10;
		stencil: [ self spacePreview ]
]

{ #category : #accessing }
BlMouseProcessorExaminedTargetElement >> space [
	^ space
]

{ #category : #accessing }
BlMouseProcessorExaminedTargetElement >> space: anObject [
	space := anObject
]

{ #category : #ui }
BlMouseProcessorExaminedTargetElement >> spacePreview [
	| aSpacePreview aPickedElement anElementPosition aClickPosition aTopContainer anElementBoundsPreview anElementSize aGeomertyBounds aBounds aGeometryBoundsPreview aLegend aPointPreview |
	aTopContainer := BlElement new
			layout: BlLinearLayout vertical;
			padding: (BlInsets all: 10);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].
	aSpacePreview := BlElement new
			background: Color white;
			aptitude: BrShadowAptitude new;
			size: self space extent.

	aPickedElement := self element.
	anElementPosition := aPickedElement bounds inSpace position.
	anElementSize := aPickedElement extent.
	aClickPosition := self event position - (6 @ 6).

	aSpacePreview
		addChild: (aPickedElement gtPreviewElement relocate: anElementPosition).

	anElementBoundsPreview := BlElement new
			layout: BlFrameLayout new;
			border: (BlBorder paint: (Color gray alpha: 0.5) width: 1);
			size: anElementSize;
			relocate: anElementPosition.
	aSpacePreview 
		addChild: anElementBoundsPreview
		as: #'element-preview--bounds'.

	aGeomertyBounds := aPickedElement geometryBoundsInSpace.
	aBounds := aPickedElement bounds.

	aGeometryBoundsPreview := BlElement new
			layout: BlFrameLayout new;
			border: (BlBorder paint: Color purple width: 1);
			size: aGeomertyBounds extent;
			relocate: aGeomertyBounds origin.

	aSpacePreview 
		addChild: aGeometryBoundsPreview 
		as: #'element-preview--geometry-bounds'.

	aPointPreview := BlElement new
		geometry: BlCircleGeometry new;
		size: 12 @ 12;
		background: (Color white alpha: 0.25);
		border: (BlBorder paint: (Color blue alpha: 0.5) width: 1);
		relocate: aClickPosition.
		
	aSpacePreview
		addChild: aPointPreview 
		as: #'element-preview--event-position'.

	aTopContainer 
		addChild: aSpacePreview
		as: #'element-preview--space-bounds'.

	aLegend := BrHorizontalFlow new
			padding: (BlInsets top: 10);
			hFitContentLimited;
			vFitContent;
			constraintsDo: [ :c | 
				c linear horizontal alignCenter
			].

	aLegend
		addChild: (BlElement new
				size: 16 @ 16;
				border: anElementBoundsPreview border;
				constraintsDo: [ :c | c flow vertical alignCenter ]).

	aLegend
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'element bounds';
				margin: (BlInsets left: 5);
				constraintsDo: [ :c | c flow vertical alignCenter ]).
				
	aLegend
		addChild: (BlElement new
				size: 16 @ 16;
				border: aGeometryBoundsPreview border;
				margin: (BlInsets left: 5);
				constraintsDo: [ :c | c flow vertical alignCenter ]).

	aLegend
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'geometry bounds';
				margin: (BlInsets left: 5);
				constraintsDo: [ :c | c flow vertical alignCenter ]).
				
	aLegend
		addChild: (BlElement new
				size: 12 @ 12;
				geometry: BlCircleGeometry new;
				border: aPointPreview border;
				margin: (BlInsets left: 5);
				constraintsDo: [ :c | c flow vertical alignCenter ]).

	aLegend
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: 'event position';
				margin: (BlInsets left: 5);
				constraintsDo: [ :c | c flow vertical alignCenter ]).

	aTopContainer 
		addChild: aLegend 
		as: #'element-preview--legend'.

	^ aTopContainer asScalableElement maxScale: 1.0
]
