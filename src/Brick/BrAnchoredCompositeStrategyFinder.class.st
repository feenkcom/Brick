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
		'maxAreaStrategy'
	],
	#category : #'Brick-Anchored - Support'
}

{ #category : #converting }
BrAnchoredCompositeStrategyFinder >> asStrategyBoundsPreviewElement [
	| theEvaluations aMinOriginX aMinOriginY aMaxCornerX aMaxCornerY |
	theEvaluations := self strategies
			collect: [ :aStrategy | self evaluateStrategy: aStrategy ].

	aMinOriginX := (theEvaluations
			detectMin: [ :anEvaluation | anEvaluation bounds origin x ]) bounds origin x.
	aMinOriginY := (theEvaluations
			detectMin: [ :anEvaluation | anEvaluation bounds origin y ]) bounds origin y.
	aMaxCornerX := (theEvaluations
			detectMax: [ :anEvaluation | anEvaluation bounds corner x ]) bounds corner x.
	aMaxCornerY := (theEvaluations
			detectMax: [ :anEvaluation | anEvaluation bounds corner y ]) bounds corner y.

	^ BlElement new
		size: referenceElement extent;
		border: (BlBorder paint: Color veryLightGray);
		clipChildren: false;
		in: [ :aContainer | 
			theEvaluations
				do: [ :anEvaluation | 
					aContainer
						addChild: (BrFrame new
								border: (BlBorder paint: Color veryLightGray);
								exact: anEvaluation extent;
								clipChildren: false;
								addAptitude: (BrStyleCommonAptitude new
										default: [ :s | s background: BlBackground transparent ];
										hovered: [ :s | 
											s
												background: (anEvaluation isAppropriate
														ifTrue: [ BrGlamorousColors successBackgroundColor alpha: 0.2 ]
														ifFalse: [ BrGlamorousColors errorBackgroundColor alpha: 0.2 ]).
											s 
												do: [ :aWidget | aWidget
													zIndex: 10; 
													addChild: (BrFrame new 
														border: (BlBorder paint: Color black width: 1);
														background: (anEvaluation isAppropriate
															ifTrue: [ BrGlamorousColors successBackgroundColor alpha: 0.3 ]
															ifFalse: [ BrGlamorousColors errorBackgroundColor alpha: 0.3 ]);
														exact: preferredExtent;
														id: #preferredExtentPreview;
														in: [ :aFrame | anEvaluation gtConfigurePreferredExtentPreviewElement: aFrame  ];
														addChild: ((BrLabel new
															fitContent;
															aptitude: (BrGlamorousLabelAptitude new 
																foreground: Color white);
															text: 'Preferred extent';
															constraintsDo: [ :c | 
																c frame horizontal alignCenter.
																c frame vertical alignCenter ]) asScalableElement maxScale: 1)) ] 
												after: [ :aWidget | aWidget 
													elevation: aWidget defaultElevation;
													childWithId: #preferredExtentPreview 
													ifFound: [ :aChild | aChild removeFromParent ] ] ];
										pressed: [ :s | 
											s
												background: (anEvaluation isAppropriate
														ifTrue: [ BrGlamorousColors successBackgroundColor alpha: 0.4 ]
														ifFalse: [ BrGlamorousColors errorBackgroundColor alpha: 0.4 ]) ]);
								when: BlClickEvent
									do: [ :anEvent | anEvent currentTarget phlow spawnObject: anEvaluation ];
								relocate: (anEvaluation bounds origin x + aMinOriginX)
										@ (anEvaluation bounds origin y + aMinOriginY);
								addChild: (BrLabel new
										fitContent;
										aptitude: (BrGlamorousLabelAptitude new
												foreground: (anEvaluation isAppropriate
														ifTrue: [ BrGlamorousColors successBackgroundColor ]
														ifFalse: [ BrGlamorousColors errorBackgroundColor ]));
										text: anEvaluation gtStrategiesNameText;
										constraintsDo: [ :c | 
											c frame horizontal alignCenter.
											c frame vertical alignCenter ])) ] ];
		yourself
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
		isAppropriate: (aRectangle intersect: preferredRectangle) = preferredRectangle
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
		priority: 1;
		items: [ self strategies collect: [ :aStrategy | self evaluateStrategy: aStrategy ] ];
		column: 'Name' text: #gtStrategiesNameText weight: 1;
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
		priority: 2;
		stencil: [ self asStrategyBoundsPreviewElement asScalableElement
				margin: (BlInsets all: 20);
				clipChildren: false ]
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
