Class {
	#name : #BrColumnedList,
	#superclass : #BrUngroupedList,
	#instVars : [
		'columnedModel'
	],
	#category : #'Brick-List-Ungrouped-Elements'
}

{ #category : #'api - scripting' }
BrColumnedList >> column [
	<return: #BrColumn>

	^ self viewModel column
]

{ #category : #initialization }
BrColumnedList >> defaultListModel [
	^ BrColumnedListModel new
]

{ #category : #initialization }
BrColumnedList >> initialize [
	super initialize.

	self aptitude: BrColumnedListAptitude + BrGlamorousWithVerticalScrollbarAptitude
]

{ #category : #initialization }
BrColumnedList >> rowDataBinder: aBrListRowDataBinderOrBlock [
	"An item type stencil can be a #value-able of the form [ :aRowElement :aTreeNode :aRowPosition | ]"

	self viewModel rowDataBinder: aBrListRowDataBinderOrBlock
]

{ #category : #'api - scripting' }
BrColumnedList >> rowStencil: aRowStencil [
	self aptitude rowStencilBuilder: aRowStencil
]
