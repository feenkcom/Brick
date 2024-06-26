"
children := 5 timesCollect: [ :anIndex |
	| accordion |
	accordion := BrAccordion new.
	accordion look: BrGlamorousAccordionLook new.
	accordion margin: (BlInsets all: 5).
	accordion stencil: [
		(GtDocumenter editorForText: 'Hello world')
			constraintsDo: [ :c | c vertical fitContent ] ].

	header := BrButton new.
	header look: BrGlamorousAccordionHeaderLook new.
	header label: 'Header ', anIndex asString .
	header action: [ accordion toggle ].

	accordion addChildFirst: header.
	accordion ].


container := BlElement new.
container layout: BlLinearLayout vertical.
container padding: (BlInsets all: 10).
container constraintsDo: [ :c |
	c horizontal matchParent.
	c vertical fitContent ].

container addChildren: children.
container
"
Class {
	#name : #BrAccordion,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TBrExpandable',
	#classTraits : 'TBrLayoutResizable classTrait + TBrExpandable classTrait',
	#category : 'Brick-Accordion - UI'
}

{ #category : #'api - expandable' }
BrAccordion >> collapse [
	self states addState: BrCollapsedState uniqueInstance
]

{ #category : #'api - accordion' }
BrAccordion >> content: aStencil [
	self viewModel contentStencil: aStencil
]

{ #category : #'api - expandable' }
BrAccordion >> expand [
	self states addState: BrExpandedState uniqueInstance
]

{ #category : #'api - accordion' }
BrAccordion >> header: aStencil [
	self viewModel headerStencil: aStencil
]

{ #category : #initialization }
BrAccordion >> initialize [
	super initialize.
	
	self viewModel: BrAccordionModel new
]

{ #category : #'api - expandable' }
BrAccordion >> isExpanded [
	"Return true if an widget is expanded (has expanded state), false otherwise"
	<return: #Boolean>

	^ self states hasState: BrExpandedState uniqueInstance
]
