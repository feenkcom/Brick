Class {
	#name : #BrFlowList,
	#superclass : #BrUngroupedList,
	#category : #'Brick-List-Ungrouped-Elements'
}

{ #category : #initialization }
BrFlowList >> defaultListModel [
	^ BrSimpleListModel new
]

{ #category : #initialization }
BrFlowList >> initialize [
	super initialize.

	self aptitude: BrFlowListAptitude new.
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
]

{ #category : #accessing }
BrFlowList >> stencil: aListRowStencilBuilder [
	self aptitude itemStencilBuilder: aListRowStencilBuilder
]
