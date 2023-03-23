"
I am a result of an {{gtClass: BrAnchoredSingleStrategy}} evaluation.
I am created and used by {{gtClass: BrAnchoredCompositeStrategyFinder}}. 

"
Class {
	#name : #BrAnchoredCompositeStrategyEvaluation,
	#superclass : #Object,
	#instVars : [
		'strategy',
		'bounds',
		'rectangle',
		'isAppropriate',
		'referenceElement',
		'preferredExtent',
		'visualAnalysis'
	],
	#category : #'Brick-Anchored - Support'
}

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> bounds [
	^ bounds
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> bounds: anObject [
	bounds := anObject
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> extent [
	^ self bounds extent
]

{ #category : #'gt - extensions' }
BrAnchoredCompositeStrategyEvaluation >> gtDetails [
	^ OrderedDictionary new
		at: 'Name' put: self name;
		at: 'Available Bounds' put: self bounds;
		at: 'Preferred Extent' put: self preferredExtent;
		at: 'Available Extent'
			put: (self extent x printShowingDecimalPlaces: 2) , ' @ '
					, (self extent y printShowingDecimalPlaces: 2);
		at: 'Extra Space'
			put: ([ :anEvaluation | 
				| aText anExtraExtent |
				aText := '' asRopedText.

				anExtraExtent := anEvaluation extent - preferredExtent.

				anExtraExtent x < 0
					ifTrue: [ aText
							append: ((anExtraExtent x printShowingDecimalPlaces: 2) asRopedText
									foreground: BrGlamorousColors errorBackgroundColor) ].
				anExtraExtent x > 0
					ifTrue: [ aText
							append: ((anExtraExtent x printShowingDecimalPlaces: 2) asRopedText
									foreground: BrGlamorousColors successBackgroundColor) ].
				anExtraExtent x isZero ifTrue: [ aText append: anExtraExtent x asRopedText ].

				aText
					append: (' @ ' asRopedText foreground: BrGlamorousColors disabledButtonTextColor).

				anExtraExtent y < 0
					ifTrue: [ aText
							append: ((anExtraExtent y printShowingDecimalPlaces: 2) asRopedText
									foreground: BrGlamorousColors errorBackgroundColor) ].
				anExtraExtent y > 0
					ifTrue: [ aText
							append: ((anExtraExtent y printShowingDecimalPlaces: 2) asRopedText
									foreground: BrGlamorousColors successBackgroundColor) ].
				anExtraExtent y isZero
					ifTrue: [ aText
							append: (anExtraExtent y asRopedText
									foreground: BrGlamorousColors disabledButtonTextColor) ].

				aText ] value: self);
		at: 'Is Appropriate'
			put: ([ :anEvaluation | 
				| aText |
				aText := anEvaluation isAppropriate asRopedText.
				anEvaluation isAppropriate
					ifTrue: [ aText foreground: BrGlamorousColors successBackgroundColor ]
					ifFalse: [ aText foreground: BrGlamorousColors errorBackgroundColor ].
				aText ] value: self);
		yourself
]

{ #category : #'gt - extensions' }
BrAnchoredCompositeStrategyEvaluation >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 2;
		items: [ self gtDetails associations ];
		column: 'Name' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #'gt - extensions' }
BrAnchoredCompositeStrategyEvaluation >> gtSpaceFor: aView [
	<gtView>
	strategy ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Preview';
		priority: 1;
		stencil: [ BrAnchoredVisualAnalysisElement new
				referenceElement: self referenceElement
					preferredExtent: self preferredExtent
					visualAnalysis: self visualAnalysis
					evaluations: {self};
				margin: (BlInsets all: 10) ]
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> isAppropriate [
	^ isAppropriate
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> isAppropriate: anObject [
	isAppropriate := anObject
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> name [
	^ self strategy gtStrategiesNameText
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> origin [
	^ self bounds origin
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> preferredExtent [
	^ preferredExtent
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> preferredExtent: anObject [
	preferredExtent := anObject
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> rectangle [
	^ rectangle
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> rectangle: anObject [
	rectangle := anObject
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> referenceElement [
	^ referenceElement
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> referenceElement: anObject [
	referenceElement := anObject
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> strategy [
	^ strategy
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> strategy: anObject [
	strategy := anObject
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> visualAnalysis [
	^ visualAnalysis
]

{ #category : #accessing }
BrAnchoredCompositeStrategyEvaluation >> visualAnalysis: anObject [
	visualAnalysis := anObject
]
