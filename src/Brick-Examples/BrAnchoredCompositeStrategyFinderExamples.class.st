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
	
	| aScripter aDropdownAnchorElement aDropdownAptitude aDropdownAnchorQuery aReferenceElement aFinder |
	aScripter := BrAnchoredByScripterExamples new dropdownBottomRight.
	
	aDropdownAnchorQuery := aScripter root query // #dropdownAnchor.
	self assert: aDropdownAnchorQuery result size equals: 1.
	aDropdownAnchorElement := aDropdownAnchorQuery result first.
	
	aDropdownAptitude := aDropdownAnchorElement aptitude.
	self assert: (aDropdownAptitude isKindOf: BrWithDropdownAptitude).
	aReferenceElement := aDropdownAptitude root.

	aFinder := aDropdownAptitude strategy 
		finderWithElement: aReferenceElement 
		andPreferredExtent: aDropdownAptitude preferredExtent.
		
	self assert: (aFinder isKindOf: BrAnchoredCompositeStrategyFinder).
	
	^ aFinder
]
