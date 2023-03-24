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
	| aScripter |
	aScripter := BrAnchoredByScripterExamples new dropdownBottomRight.
	
	^ aScripter userData at: BrAnchoredVisualAnalysis
]

{ #category : #'examples - finder' }
BrAnchoredCompositeStrategyFinderExamples >> finder_AnchorMoreToTheRight [
	<gtExample>
	| aScripter  |
	aScripter := BrAnchoredByScripterExamples new dropdownBottomRight_AnchorMoreToTheRight.
	
	^ aScripter userData at: BrAnchoredVisualAnalysis
]

{ #category : #'examples - finder' }
BrAnchoredCompositeStrategyFinderExamples >> finder_AnchorMoreToTheRight_ByOnePixel [
	<gtExample>
	| aScripter |
	aScripter := BrAnchoredByScripterExamples new dropdownBottomRight_AnchorMoreToTheRight_ByOnePixel.
	
	^ aScripter userData at: BrAnchoredVisualAnalysis
]
