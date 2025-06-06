Class {
	#name : #BrLabelExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-Label'
}

{ #category : #'examples - label' }
BrLabelExamples >> glamorousLabel [
	<gtExample>
	<return: #BrLabel>
	| aLabel |
	aLabel := BrLabel new.
	aLabel aptitude: BrGlamorousLabelAptitude new.

	aLabel forceLayout.

	self assert: (aLabel viewModel isKindOf: BrLabelModel).
	self assert: aLabel viewModel text asString equals: 'Label'.
	self assert: (aLabel layout isKindOf: BlLinearLayout).
	self assert: aLabel layout isHorizontal.
	self
		assert: aLabel layout horizontalAlignment
		equals: BlHorizontalAlignment start.
	self assert: aLabel layout verticalAlignment equals: BlVerticalAlignment center.
	self assert: aLabel constraints horizontal resizer isFitContent.
	self assert: aLabel constraints vertical resizer isFitContent.
	self assert: aLabel margin equals: BlInsets empty.
	self assert: aLabel padding equals: BlInsets empty.
	self assert: aLabel children size equals: 1.
	self assert: (aLabel children first isKindOf: BlTextElement).
	self assert: aLabel children first constraints horizontal resizer isFitContent.
	self assert: aLabel children first constraints vertical resizer isFitContent.
	self assert: aLabel children first margin equals: BlInsets empty.
	self assert: aLabel children first padding equals: (BlInsets all: 1).

	^ aLabel
]

{ #category : #'examples - label' }
BrLabelExamples >> glamorousLabelWithFontSize [
	<gtExample>
	<return: #BrLabel>
	| aLabel |
	aLabel := self glamorousLabelWithText.
	aLabel aptitude fontSize: 20.

	^ aLabel
]

{ #category : #'examples - label' }
BrLabelExamples >> glamorousLabelWithText [
	<gtExample>
	<return: #BrLabel>
	| aLabel |
	aLabel := self glamorousLabel.
	aLabel text: 'Hello'.

	self assert: aLabel viewModel text asString equals: 'Hello'.
	self assert: aLabel aptitude text asString equals: 'Hello'.

	^ aLabel
]

{ #category : #'examples - label' }
BrLabelExamples >> glamorousSmallMetadataLabel [
	<gtExample>
	<return: #BrLabel>
	| aLabel |
	aLabel := BrLabel new
		beSmallSize;
		aptitude: BrGlamorousMetadataLabelAptitude;
		text: 'Metadata-Label'.

	^ aLabel
]

{ #category : #'examples - label' }
BrLabelExamples >> glamorousSmallSummaryLabel [
	<gtExample>
	<return: #BrLabel>
	| aLabel |
	aLabel := BrLabel new
		beSmallSize;
		aptitude: BrGlamorousSummaryLabelAptitude;
		text: 'Summary-Label'.

	^ aLabel
]
