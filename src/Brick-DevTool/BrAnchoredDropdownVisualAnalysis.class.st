"
I define how to visualize dropdown {{gtClass: BrAnchoredCompositeStrategyEvaluation}} instances.
I am used by {{gtClass: BrAnchoredVisualAnalysisElement}}. 

"
Class {
	#name : #BrAnchoredDropdownVisualAnalysis,
	#superclass : #BrAnchoredVisualAnalysisStrategy,
	#category : #'Brick-DevTool-Anchored'
}

{ #category : #accessing }
BrAnchoredDropdownVisualAnalysis >> configurePreferredExtentPreviewElement: aPreferredExtent evaluation: anEvaluation [
	anEvaluation gtConfigureDropdownPreferredExtentPreviewElement: aPreferredExtent
]
