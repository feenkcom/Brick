Extension { #name : #BrAnchoredCompositeStrategyEvaluation }

{ #category : #'*Brick-DevTool' }
BrAnchoredCompositeStrategyEvaluation >> gtConfigureDropdownPreferredExtentPreviewElement: anElement [
	self strategy gtConfigureDropdownPreferredExtentPreviewElement: anElement
]

{ #category : #'*Brick-DevTool' }
BrAnchoredCompositeStrategyEvaluation >> gtConfigureTooltipPreferredExtentPreviewElement: anElement [
	self strategy gtConfigureTooltipPreferredExtentPreviewElement: anElement
]

{ #category : #'*Brick-DevTool' }
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
