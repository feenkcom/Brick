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

	theCellElements := OrderedCollection new: self columns size.	"we should wrap the first column element into another element in order to add a toggle button"
	self columnElements
		ifNotEmpty: [ :theColumnElements | 
			| aFirstColumnWrapper aToggleButton |
			aFirstColumnWrapper := BlElement new
					layout: BlLinearLayout horizontal alignCenterLeft;
					constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical fitContent ].

			self columns first columnWidth applyOn: aFirstColumnWrapper.

			aToggleButton := self createExpandCollapseElement
					toggleAction: [ :aToggleElement :aToggleModel | aToggleModel model toggle ].

			aFirstColumnWrapper
				addChild: aToggleButton as: #toggle;
				addChild: theColumnElements first.

			theCellElements add: aFirstColumnWrapper ].

	self columnElements
		allButFirstDo: [ :eachCellElement | theCellElements add: eachCellElement ].

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
