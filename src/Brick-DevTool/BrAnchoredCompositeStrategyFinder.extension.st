Extension { #name : #BrAnchoredCompositeStrategyFinder }

{ #category : #'*Brick-DevTool' }
BrAnchoredCompositeStrategyFinder >> beForDropdown [
	"I am used for visual user analysis.
	It does not affect computation."
	visualAnalysis := BrAnchoredDropdownVisualAnalysis new
]

{ #category : #'*Brick-DevTool' }
BrAnchoredCompositeStrategyFinder >> beForTooltip [
	"I am used for visual user analysis.
	It does not affect computation."
	visualAnalysis := BrAnchoredTooltipVisualAnalysis new
]

{ #category : #'*Brick-DevTool' }
BrAnchoredCompositeStrategyFinder >> gtStrategyBoundsFor: aView [
	<gtView>
	self strategies ifEmpty: [ ^ aView empty ].
	self referenceElement ifNil: [ ^ aView empty ].

	^ aView explicit
		title: 'Strategy bounds';
		priority: 1;
		stencil: [ BrAnchoredVisualAnalysisElement new
				finder: self;
				margin: (BlInsets all: 10) ]
]
