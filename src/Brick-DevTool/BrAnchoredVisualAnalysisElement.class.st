"
I visualize {{gtClass: BrAnchoredVisualAnalysis}}. 
"
Class {
	#name : #BrAnchoredVisualAnalysisElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'scenePreview',
		'scalableScenePreview',
		'strategyItems',
		'evaluations',
		'visualAnalysis',
		'referenceElement',
		'preferredExtent'
	],
	#category : #'Brick-DevTool-Anchored'
}

{ #category : #'private - updating' }
BrAnchoredVisualAnalysisElement >> evaluationBackgroundColorFor: anEvaluation [
	^ anEvaluation isAppropriate
		ifTrue: [ BrGlamorousColors successBackgroundColor ]
		ifFalse: [ BrGlamorousColors errorBackgroundColor ]
]

{ #category : #'private - updating' }
BrAnchoredVisualAnalysisElement >> evaluationBorderColorFor: anEvaluation [
	^ anEvaluation isAppropriate
		ifTrue: [ BrGlamorousColors successBorderColor ]
		ifFalse: [ BrGlamorousColors errorBorderColor ]
]

{ #category : #accessing }
BrAnchoredVisualAnalysisElement >> evaluations [
	^ evaluations ifNil: [ evaluations := #() ]
]

{ #category : #'api - initialization' }
BrAnchoredVisualAnalysisElement >> finder: aStrategyFinder [
	self
		referenceElement: aStrategyFinder referenceElement
		preferredExtent: aStrategyFinder preferredExtent
		visualAnalysis: aStrategyFinder visualAnalysis
		evaluations: aStrategyFinder evaluations
]

{ #category : #testing }
BrAnchoredVisualAnalysisElement >> hasOneEvaluation [
	^ self evaluations size = 1
]

{ #category : #'private - event handling' }
BrAnchoredVisualAnalysisElement >> hideStrategyPreviewFor: anEvaluation [
	| aQuery |
	aQuery := self query
			// (BrAnchoredVisualAnalysisEvaluationElementId new evaluation: anEvaluation).

	aQuery result ifEmpty: [ ^ self ].

	aQuery result do: [ :anElement | anElement visibility: BlVisibility hidden ]
]

{ #category : #accessing }
BrAnchoredVisualAnalysisElement >> initialize [
	super initialize.
	self matchParent.

	self initializeStrategyItems.
	self initializeScenePreview.

	self addChild: strategyItems.
	self addChild: scalableScenePreview
]

{ #category : #accessing }
BrAnchoredVisualAnalysisElement >> initializeScenePreview [
	scenePreview := BrFrame new
			fitContent;
			border: (BlBorder builder
					dashedSmall;
					paint: Color veryLightGray;
					width: 1;
					build);
			clipChildren: false.
	scalableScenePreview := scenePreview asScalableElement
			margin: (BlInsets all: 30);
			border: (BlBorder builder
					dashedSmall;
					paint: Color veryVeryLightGray;
					width: 1;
					build);
			clipChildren: false
]

{ #category : #accessing }
BrAnchoredVisualAnalysisElement >> initializeStrategyItems [
	strategyItems := BrHorizontalFlow new
			hFitContentLimited;
			vFitContent;
			constraintsDo: [ :c | c linear horizontal alignCenter ]
]

{ #category : #'private - updating' }
BrAnchoredVisualAnalysisElement >> newStrategyItemElementFor: anEvaluation [
	| aBackgroundColor aBorderColor aLabel aContainer |
	aBackgroundColor := self evaluationBackgroundColorFor: anEvaluation.
	aBorderColor := self evaluationBorderColorFor: anEvaluation.

	aLabel := BrLabel new
			fitContent;
			aptitude: (BrGlamorousLabelAptitude new foreground: Color white);
			text: anEvaluation name.

	aContainer := BrFrame new
			fitContent;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
			border: (BlBorder paint: aBorderColor width: 1);
			background: aBackgroundColor;
			margin: (BlInsets
					top: 0
					right: 3
					bottom: 3
					left: 0);
			padding: (BlInsets all: 3);
			addChild: aLabel.


	aContainer
		addAptitude: (BrStyleCommonAptitude new
				default: [ :s | 
					s background: aBackgroundColor.
					s border: (BlBorder paint: aBorderColor width: 1) ];
				hovered: [ :s | 
					s background: aBackgroundColor darker.
					s border: (BlBorder paint: aBorderColor darker width: 1).
					s
						do: [ :aWidget | self showStrategyPreviewFor: anEvaluation ]
						after: [ :aWidget | ] ];
				pressed: [ :s |  ]).

	aContainer
		when: BlClickEvent
		do: [ :anEvent | anEvent currentTarget phlow spawnObject: anEvaluation ].

	^ aContainer
]

{ #category : #'private - updating' }
BrAnchoredVisualAnalysisElement >> newStrategyPreviewContainer [
	^ BlElement new
		id: BrAnchoredVisualAnalysisSceneElementId;
		size: self referenceElement extent;
		clipChildren: false
]

{ #category : #'private - updating' }
BrAnchoredVisualAnalysisElement >> newStrategySceneElementFor: anEvaluation [
	| aBackgroundColor aBorderColor aStrategyLabel aContainer aPreferredExtent |
	aBackgroundColor := self evaluationBackgroundColorFor: anEvaluation.
	aBorderColor := self evaluationBorderColorFor: anEvaluation.

	aStrategyLabel := BrLabel new
			fitContent;
			aptitude: (BrGlamorousLabelAptitude new foreground: Color white);
			text: anEvaluation name;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ].

	aPreferredExtent := BrFrame new
			id: #preferredExtentPreview;
			border: (BlBorder paint: (aBorderColor alpha: 0.3) width: 1);
			background: (aBackgroundColor alpha: 0.3);
			exact: self preferredExtent;
			addChild: ((BrLabel new
					fitContent;
					aptitude: (BrGlamorousLabelAptitude new foreground: Color white);
					text: 'Preferred extent';
					constraintsDo: [ :c | 
						c frame horizontal alignCenter.
						c frame vertical alignCenter ]) asScalableElement maxScale: 1).

	self visualAnalysis
		configurePreferredExtentPreviewElement: aPreferredExtent
		evaluation: anEvaluation.

	aContainer := BrFrame new
			id: (BrAnchoredVisualAnalysisEvaluationElementId new evaluation: anEvaluation);
			border: (BlBorder paint: (aBorderColor alpha: 0.2) width: 1);
			background: (aBackgroundColor alpha: 0.2);
			exact: anEvaluation extent;
			clipChildren: false;
			addChild: aStrategyLabel;
			addChild: aPreferredExtent;
			relocate: anEvaluation bounds origin x @ anEvaluation bounds origin y.

	self hasOneEvaluation ifFalse: [ aContainer visibility: BlVisibility hidden ].

	^ aContainer
]

{ #category : #'private - hooks' }
BrAnchoredVisualAnalysisElement >> onValuesChanched [
	self updateStragetyItems.
	self updateScenePreview.
]

{ #category : #accessing }
BrAnchoredVisualAnalysisElement >> preferredExtent [
	^ preferredExtent
]

{ #category : #accessing }
BrAnchoredVisualAnalysisElement >> referenceElement [
	^ referenceElement
]

{ #category : #'api - initialization' }
BrAnchoredVisualAnalysisElement >> referenceElement: aReferenceElement preferredExtent: aPreferredExtent visualAnalysis: aVisualAnalysis evaluations: aCollectionOfEvaluations [
	referenceElement := aReferenceElement.
	preferredExtent := aPreferredExtent.
	visualAnalysis := aVisualAnalysis.
	evaluations := aCollectionOfEvaluations.

	self onValuesChanched
]

{ #category : #'private - event handling' }
BrAnchoredVisualAnalysisElement >> showStrategyPreviewFor: anEvaluation [
	| aSceneQuery |
	aSceneQuery := self query // BrAnchoredVisualAnalysisSceneElementId.

	aSceneQuery result
		do: [ :anElement | 
			| anId |
			anId := BrAnchoredVisualAnalysisEvaluationElementId new evaluation: anEvaluation.
			anElement
				childrenDo: [ :aChild | 
					aChild id = anId
						ifTrue: [ aChild visibility: BlVisibility visible ]
						ifFalse: [ aChild visibility: BlVisibility hidden ] ] ]
]

{ #category : #'private - updating' }
BrAnchoredVisualAnalysisElement >> updateScenePreview [
	| strategyContainer |
	scenePreview removeChildren.

	scenePreview addChild: self referenceElement gtPreviewElement.
	scenePreview addChild: (strategyContainer := self newStrategyPreviewContainer).

	self evaluations do: [ :anEvaluation | 
		strategyContainer addChild: (self newStrategySceneElementFor: anEvaluation) ]
]

{ #category : #'private - updating' }
BrAnchoredVisualAnalysisElement >> updateStragetyItems [
	strategyItems removeChildren.
	
	self hasOneEvaluation ifTrue: [ ^ self ].
	
	self evaluations do: [ :anEvaluation | 
		strategyItems addChild: (self newStrategyItemElementFor: anEvaluation) ]
]

{ #category : #accessing }
BrAnchoredVisualAnalysisElement >> visualAnalysis [
	^ visualAnalysis
]
