"
I am an abstract class.
My subclasses define how to visualize {{gtClass: BrAnchoredCompositeStrategyEvaluation}} instances.
I am used by {{gtClass: BrAnchoredVisualAnalysisElement}}. 

"
Class {
	#name : #BrAnchoredVisualAnalysisStrategy,
	#superclass : #Object,
	#category : #'Brick-DevTool-Anchored'
}

{ #category : #accessing }
BrAnchoredVisualAnalysisStrategy >> configurePreferredExtentPreviewElement: aPreferredExtent evaluation: anEvaluation [
	self subclassResponsibility
]
