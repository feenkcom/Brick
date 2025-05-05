"
I exemplify {{gtClass: BrAnchoredCompositeStrategyFinder}}. 
"
Class {
	#name : #BrAnchoredCompositeStrategyFinderExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Anchored'
}

{ #category : #'examples - finder' }
BrAnchoredCompositeStrategyFinderExamples >> finder [
	<gtExample>
	<return: #BrAnchoredVisualAnalysis>
	| aScripter |
	aScripter := BrAnchoredByScripterExamples new dropdownBottomRight.

	^ aScripter userData at: BrAnchoredVisualAnalysis
]

{ #category : #'examples - finder' }
BrAnchoredCompositeStrategyFinderExamples >> finder_AnchorMoreToTheRight [
	<gtExample>
	<return: #BrAnchoredVisualAnalysis>
	| aScripter |
	aScripter := BrAnchoredByScripterExamples new
			dropdownBottomRight_AnchorMoreToTheRight.

	^ aScripter userData at: BrAnchoredVisualAnalysis
]

{ #category : #'examples - finder' }
BrAnchoredCompositeStrategyFinderExamples >> finder_AnchorMoreToTheRight_ByOnePixel [
	<gtExample>
	<return: #BrAnchoredVisualAnalysis>
	| aScripter |
	aScripter := BrAnchoredByScripterExamples new
			dropdownBottomRight_AnchorMoreToTheRight_ByOnePixel.

	^ aScripter userData at: BrAnchoredVisualAnalysis
]
