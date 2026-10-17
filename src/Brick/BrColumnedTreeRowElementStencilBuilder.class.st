Class {
	#name : #BrColumnedTreeRowElementStencilBuilder,
	#superclass : #BrTreeRowElementStencilBuilder,
	#instVars : [
		'columns',
		'columnElements'
	],
	#category : #'Brick-Tree - Stencil'
}

{ #category : #building }
BrColumnedTreeRowElementStencilBuilder >> buildDefault [
	| row toggle |
	row := self createRowElement.
	columnElements ifEmpty: [ ^ row ].
	toggle := self createExpandCollapseElement
		id: #toggle;
		toggleAction: [ :element :model | model model toggle ];
		constraintsDo: [ :c | c ignoreByLayout. c ignored horizontal alignLeft. c ignored vertical alignCenter ].
	columnElements first clipChildren: true.
	row addChildren: columnElements.
	row addChild: toggle.
	^ row
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
	^ BrInlineExpanderElement new
		aptitude: BrGlamorousTriangleInCircleExpanderAptitude
]

{ #category : #building }
BrColumnedTreeRowElementStencilBuilder >> createRowElement [
	^ BlElement new
		layout: (BlLinearLayout horizontal alignCenterLeft cellSpacing: BrColumn defaultCellSpacing);
		constraintsDo: [ :c | c horizontal matchParent. c vertical fitContent ]
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
