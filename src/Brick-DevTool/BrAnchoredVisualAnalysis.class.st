"
I am used to overview and easily analyze dropdown positions.
Look at a [feenkcom/gtoolkit#3116](https://github.com/feenkcom/gtoolkit/issues/3116#issuecomment-1480435360) issue comment where we describe how we used it to understand dropdown misplacement issues.
#Example
The following example shows analysis of used dropdown placement strategies. Use your mose to hover individual placement sectors: {{gtExample: BrAnchoredCompositeStrategyFinderExamples>>#finder_AnchorMoreToTheRight_ByOnePixel | noCode | previewHeight=500}} 
"
Class {
	#name : #BrAnchoredVisualAnalysis,
	#superclass : #Object,
	#instVars : [
		'scripter',
		'elementWithDropdown',
		'dropdownAptitude',
		'referenceElement',
		'finder'
	],
	#category : #'Brick-DevTool-Anchored'
}

{ #category : #accessing }
BrAnchoredVisualAnalysis >> anchoredAptitude: anAptitude [
	dropdownAptitude := anAptitude.
	referenceElement := anAptitude root.
	finder := anAptitude strategy
			finderWithElement: referenceElement
			andPreferredExtent: anAptitude preferredExtent.
]

{ #category : #accessing }
BrAnchoredVisualAnalysis >> dropdownAptitude [
	^ dropdownAptitude
]

{ #category : #accessing }
BrAnchoredVisualAnalysis >> elementWithDropdown [
	^ elementWithDropdown
]

{ #category : #accessing }
BrAnchoredVisualAnalysis >> elementWithDropdown: anElement [
	elementWithDropdown := anElement.

	dropdownAptitude ifNotNil: [ ^ self ].
	anElement aptitude
		withAllActorsBreadthFirstDo: [ :anAptitude | 
			(anAptitude isKindOf: BrWithAnchoredAptitude)
				ifTrue: [ self anchoredAptitude: anAptitude.
					finder beForDropdown.
					^ self ] ]
]

{ #category : #accessing }
BrAnchoredVisualAnalysis >> elementWithTooltip: anElement [
	elementWithDropdown := anElement.

	dropdownAptitude ifNotNil: [ ^ self ].
	anElement aptitude
		withAllActorsBreadthFirstDo: [ :anAptitude | 
			(anAptitude isKindOf: BrWithAnchoredAptitude)
				ifTrue: [ self anchoredAptitude: anAptitude.
					finder beForTooltip.
					^ self ] ]
]

{ #category : #'gt - extensions' }
BrAnchoredVisualAnalysis >> gtSpaceFor: aView [
	<gtView>
	finder ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ BrAnchoredVisualAnalysisElement new
				finder: finder;
				margin: (BlInsets all: 10) ]
]

{ #category : #'gt - extensions' }
BrAnchoredVisualAnalysis >> gtStrategiesFor: aView [
	<gtView>
	finder ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Strategies';
		priority: 2;
		object: [ finder ];
		view: #gtStrategiesFor:
]

{ #category : #printing }
BrAnchoredVisualAnalysis >> printOn: aStream [
	super printOn: aStream.

	finder ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: 'preferred extent: ';
		space;
		print: finder preferredExtent;
		nextPut: $)
]

{ #category : #accessing }
BrAnchoredVisualAnalysis >> scripter [
	^ scripter
]

{ #category : #accessing }
BrAnchoredVisualAnalysis >> scripter: anObject [
	scripter := anObject
]
