Class {
	#name : #BrListStencilExamples,
	#superclass : #Object,
	#category : #'Brick-Examples-List'
}

{ #category : #'examples - list label' }
BrListStencilExamples >> createCustomTextListLabel [
	<gtExample>
	<return: #BrLabel>
	| aStencil anElement |
	aStencil := self listLabelStencil.
	aStencil text: 'Custom label'.
	anElement := aStencil create.

	self assert: anElement text asString equals: 'Custom label'.
	self assert: anElement margin equals: (BlInsets all: 3).
	self
		assert: (anElement states hasState: BrLayoutHorizontalResizerState matchParent).
	self
		assert: (anElement states hasState: BrLayoutVerticalResizerState fitContent).

	^ anElement
]

{ #category : #'examples - list label' }
BrListStencilExamples >> createDefaultListLabel [
	<gtExample>
	<return: #BrLabel>
	| aStencil anElement |
	aStencil := self listLabelStencil.
	anElement := aStencil create.

	self assert: anElement text asString equals: 'Label'.
	self assert: anElement margin equals: (BlInsets all: 3).
	self
		assert: (anElement states hasState: BrLayoutHorizontalResizerState matchParent).
	self
		assert: (anElement states hasState: BrLayoutVerticalResizerState fitContent).

	^ anElement
]

{ #category : #'examples - instance creation' }
BrListStencilExamples >> listLabelStencil [
	<gtExample>
	<return: #BrColumnCellLabelStencil>
	| aStencil |
	aStencil := BrColumnCellLabelStencil new.
	self assert: aStencil text asString equals: 'Label'.

	^ aStencil
]
