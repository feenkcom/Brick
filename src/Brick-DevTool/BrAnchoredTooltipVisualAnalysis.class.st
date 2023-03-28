"
I define how to visualize tooltip {{gtClass: BrAnchoredCompositeStrategyEvaluation}} instances.
I am used by {{gtClass: BrAnchoredVisualAnalysisElement}}. 

"
Class {
	#name : #BrAnchoredTooltipVisualAnalysis,
	#superclass : #BrAnchoredVisualAnalysisStrategy,
	#category : #'Brick-DevTool-Anchored'
}

{ #category : #accessing }
BrAnchoredTooltipVisualAnalysis >> configurePreferredExtentPreviewElement: aPreferredExtent evaluation: anEvaluation [
	anEvaluation gtConfigureTooltipPreferredExtentPreviewElement: aPreferredExtent
]
