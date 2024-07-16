Class {
	#name : #BrColumnedTreeRowElementStencilBuilder,
	#superclass : #BrTreeRowElementStencilBuilder,
	#instVars : [
		'columns',
		'columnElements'
	],
	#category : #'Brick-Tree - Stencil'
}

{ #category : #'api - instantiation' }
BrColumnedTreeRowElementStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	| aRowElement theCellElements |
	aRowElement := self createRowElement.
	theCellElements := OrderedCollection new: self columns size.
	columnElements
		ifNotEmpty: [ | aToggleButton |
			aToggleButton := self createExpandCollapseElement
					id: #toggle;
					toggleAction: [ :aToggleElement :aToggleModel | aToggleModel model toggle ].
			theCellElements add: aToggleButton ].
	theCellElements addAll: columnElements.
	aRowElement addChildren: theCellElements.
	^ aRowElement
]

{ #category : #accessing }
BrColumnedTreeRowElementStencilBuilder >> columnElements [
	^ columnElements
]

{ #category : #accessing }
BrColumnedTreeRowElementStencilBuilder >> columnElements: anObject [
	columnElements := anObject
]

{ #category : #accessing }
BrColumnedTreeRowElementStencilBuilder >> columns [
	^ columns
]

{ #category : #accessing }
BrColumnedTreeRowElementStencilBuilder >> columns: anObject [
	columns := anObject
]

{ #category : #'api - instantiation' }
BrColumnedTreeRowElementStencilBuilder >> createExpandCollapseElement [
	^ BrTriangle new
		aptitude: BrGlamorousTriangleInCircleAptitude
]

{ #category : #'api - instantiation' }
BrColumnedTreeRowElementStencilBuilder >> createRowElement [
	^ BlElement new
		layout: BlLinearLayout horizontal alignCenterLeft;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ]
]

{ #category : #'api - instantiation' }
BrColumnedTreeRowElementStencilBuilder >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self itemType;
		push: self columnElements;
		push: self columns
]

{ #category : #initialization }
BrColumnedTreeRowElementStencilBuilder >> reset [
	super reset.
	
	columnElements := nil.
	columns := nil
]
