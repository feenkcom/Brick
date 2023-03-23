"
I am used to overview and easily analyze dropdown positions.
Look at a [feenkcom/gtoolkit#3116](https://github.com/feenkcom/gtoolkit/issues/3116#issuecomment-1480435360) issue comment where we describe how we used it to understand dropdown misplacement issues.
#Example
The following example shows analysis of used dropdown placement strategies. Use your mose to hover individual placement sectors: {{gtExample: BrAnchoredCompositeStrategyFinderExamples>>#finder_AnchorMoreToTheRight_ByOnePixel | noCode | previewHeight=500}} 
"
Class {
	#name : #BrAnchoredContainerOverview,
	#superclass : #Object,
	#instVars : [
		'scripter',
		'elementWithDropdown',
		'dropdownAptitude',
		'referenceElement',
		'finder'
	],
	#category : #'Brick-Examples-Anchored'
}

{ #category : #accessing }
BrAnchoredContainerOverview >> dropdownAptitude [
	^ dropdownAptitude
]

{ #category : #accessing }
BrAnchoredContainerOverview >> dropdownAptitude: anAptitude [
	dropdownAptitude := anAptitude.
	referenceElement := anAptitude root.
	finder := anAptitude strategy
			finderWithElement: referenceElement
			andPreferredExtent: anAptitude preferredExtent
]

{ #category : #accessing }
BrAnchoredContainerOverview >> elementWithDropdown [
	^ elementWithDropdown
]

{ #category : #accessing }
BrAnchoredContainerOverview >> elementWithDropdown: anElement [
	elementWithDropdown := anElement.
	
	dropdownAptitude ifNotNil: [ ^ self ].
	anElement aptitude
		withAllActorsBreadthFirstDo: [ :anAptitude | 
			(anAptitude isKindOf: BrWithDropdownAptitude)
				ifTrue: [ self dropdownAptitude: anAptitude.
					^ self ] ]
]

{ #category : #'gt - extensions' }
BrAnchoredContainerOverview >> gtSpaceFor: aView [
	<gtView>
	self scripter ifNil: [ ^ aView empty ].
	finder ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ | aContainer |
			aContainer := BrFrame new 
				fitContent;
				clipChildren: false.
			aContainer addChild: self scripter root gtPreviewElement.
			aContainer addChild: finder asStrategyBoundsPreviewElement.
			aContainer asScalableElement 
				margin: (BlInsets all: 10);
				clipChildren: false ]
]

{ #category : #'gt - extensions' }
BrAnchoredContainerOverview >> gtStrategiesFor: aView [
	<gtView>
	finder ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Strategies';
		priority: 2;
		object: [ finder ];
		view: #gtStrategiesFor:
]

{ #category : #accessing }
BrAnchoredContainerOverview >> scripter [
	^ scripter
]

{ #category : #accessing }
BrAnchoredContainerOverview >> scripter: anObject [
	scripter := anObject
]
