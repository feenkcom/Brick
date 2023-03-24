"
I find an appropriate {{gtClass: BrAnchoredSingleStrategy}} based on a {{gtMethod: BrAnchoredCompositeStrategyFinder >> #preferredExtent: | label=preferred extent}} and {{gtMethod: BrAnchoredCompositeStrategyFinder >> #referenceElement | label=reference element}}.
I am created and used by {{gtClass: BrAnchoredCompositeStrategy}}. 
#Example
For a given dropdown: {{gtExample: BrAnchoredByScripterExamples >> #dropdownBottomRight | noCode | previewHeight = 660 | previewShow = #gtSpaceFor:}}
The composite strategies are as follows: {{gtExample: BrAnchoredCompositeStrategyFinderExamples >> #finder | noCode | previewExpanded=true | previewHeight=230}}
"
Class {
	#name : #BrAnchoredCompositeStrategyFinder,
	#superclass : #Object,
	#instVars : [
		'strategies',
		'referenceElement',
		'preferredExtent',
		'preferredRectangle',
		'maxAreaBounds',
		'maxAreaStrategy',
		'visualAnalysis'
	],
	#category : #'Brick-Anchored - Support'
}

{ #category : #'api - visual analysis' }
BrAnchoredCompositeStrategyFinder >> beForDropdown [
	"I am used for visual user analysis.
	It does not affect computation."
	visualAnalysis := BrAnchoredDropdownVisualAnalysis new
]

{ #category : #'api - visual analysis' }
BrAnchoredCompositeStrategyFinder >> beForTooltip [
	"I am used for visual user analysis.
	It does not affect computation."
	visualAnalysis := BrAnchoredTooltipVisualAnalysis new
]

{ #category : #'private - finding' }
BrAnchoredCompositeStrategyFinder >> evaluateStrategy: aStrategy [
	<return: #BrAnchoredCompositeStrategyEvaluation>
	| aBounds aRectangle |
	aBounds := aStrategy
			availableBoundsIn: self referenceElement
			forPreferredExtent: self preferredExtent.
	aRectangle := Rectangle origin: 0.0 @ 0.0 extent: aBounds extent.

	^ BrAnchoredCompositeStrategyEvaluation new
		strategy: aStrategy;
		bounds: aBounds;
		rectangle: aRectangle;
		isAppropriate: (aRectangle intersect: preferredRectangle) = preferredRectangle;
		referenceElement: self referenceElement;
		preferredExtent: self preferredExtent;
		visualAnalysis: self visualAnalysis.
]

{ #category : #'api - finding' }
BrAnchoredCompositeStrategyFinder >> evaluations [
	^ self strategies collect: [ :aStrategy | 
		self evaluateStrategy: aStrategy ]
]

{ #category : #'api - finding' }
BrAnchoredCompositeStrategyFinder >> find [
	maxAreaBounds := nil.
	maxAreaStrategy := nil.

	^ self strategies
		detect: [ :aStrategy | self isAppropriateStrategy: aStrategy ]
		ifNone: [ maxAreaStrategy ]
]

{ #category : #'gt - extensions' }
BrAnchoredCompositeStrategyFinder >> gtStrategiesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Strategies';
		priority: 2;
		items: [ self evaluations ];
		column: 'Name' text: #name weight: 1;
		column: 'Available Bounds' text: [ :anEvaluation | anEvaluation bounds ] weight: 2;
		column: 'Available Extent'
			text: [ :anEvaluation | (anEvaluation extent x printShowingDecimalPlaces: 2), ' @ ', (anEvaluation extent y printShowingDecimalPlaces: 2) ];
		column: 'Extra Space'
			text: [ :anEvaluation | 
				| aText anExtraExtent |
				aText := '' asRopedText.
				
				anExtraExtent := anEvaluation extent - preferredExtent.
				
				anExtraExtent x < 0  ifTrue: [ 
					aText append: ((anExtraExtent x printShowingDecimalPlaces: 2) asRopedText foreground: BrGlamorousColors errorBackgroundColor) ].
				anExtraExtent x > 0 ifTrue: [ 
					aText append: ((anExtraExtent x printShowingDecimalPlaces: 2) asRopedText foreground: BrGlamorousColors successBackgroundColor) ].
				anExtraExtent x isZero ifTrue: [ 
					aText append: (anExtraExtent x asRopedText) ].
					
				aText append: (' @ ' asRopedText foreground: BrGlamorousColors disabledButtonTextColor).
					
				anExtraExtent y < 0  ifTrue: [ 
					aText append: ((anExtraExtent y printShowingDecimalPlaces: 2) asRopedText foreground: BrGlamorousColors errorBackgroundColor) ].
				anExtraExtent y > 0 ifTrue: [ 
					aText append: ((anExtraExtent y printShowingDecimalPlaces: 2) asRopedText foreground: BrGlamorousColors successBackgroundColor) ].
				anExtraExtent y isZero ifTrue: [ 
					aText append: (anExtraExtent y asRopedText foreground: BrGlamorousColors disabledButtonTextColor) ].
					
				aText ];
		column: 'Is Appropriate'
			text: [ :anEvaluation | 
				| aText |
				aText := anEvaluation isAppropriate asRopedText.
				anEvaluation isAppropriate
					ifTrue: [ aText foreground: BrGlamorousColors successBackgroundColor ]
					ifFalse: [ aText foreground: BrGlamorousColors errorBackgroundColor ].
				aText ]
			width: 90
]

{ #category : #'gt - extensions' }
BrAnchoredCompositeStrategyFinder >> gtStrategyBoundsFor: aView [
	<gtView>
	self strategies ifEmpty: [ ^ aView empty ].
	self referenceElement ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Strategy Bounds';
		priority: 1;
		stencil: [ BrAnchoredVisualAnalysisElement new
				finder: self;
				margin: (BlInsets all: 10) ]
]

{ #category : #'private - finding' }
BrAnchoredCompositeStrategyFinder >> isAppropriateStrategy: aStrategy [
	<return: #Boolean>
	| anEvaluation aBounds aRectangle |
	anEvaluation := self evaluateStrategy: aStrategy.
	aBounds := anEvaluation bounds.
	aRectangle := anEvaluation rectangle.
	
	(maxAreaBounds isNil or: [ 
		aRectangle area > maxAreaBounds asRectangle area ])
			ifTrue: [ 
				maxAreaBounds := aBounds.
				maxAreaStrategy := aStrategy ].
	
	^ anEvaluation isAppropriate
]

{ #category : #accessing }
BrAnchoredCompositeStrategyFinder >> preferredExtent [
	^ preferredExtent
]

{ #category : #accessing }
BrAnchoredCompositeStrategyFinder >> preferredExtent: aPoint [
	preferredExtent := aPoint.
	preferredRectangle := Rectangle origin: 0.0@0.0 extent: aPoint.
]

{ #category : #printing }
BrAnchoredCompositeStrategyFinder >> printOn: aStream [
	super printOn: aStream.

	preferredExtent ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: 'preferred extent: ';
		space;
		print: preferredExtent;
		nextPut: $)
]

{ #category : #accessing }
BrAnchoredCompositeStrategyFinder >> referenceElement [
	^ referenceElement
]

{ #category : #accessing }
BrAnchoredCompositeStrategyFinder >> referenceElement: anObject [
	referenceElement := anObject
]

{ #category : #accessing }
BrAnchoredCompositeStrategyFinder >> strategies [
	^ strategies ifNil: [ #() ]
]

{ #category : #accessing }
BrAnchoredCompositeStrategyFinder >> strategies: anObject [
	strategies := anObject
]

{ #category : #'api - visual analysis' }
BrAnchoredCompositeStrategyFinder >> visualAnalysis [
	^ visualAnalysis
]
