Class {
	#name : #BrScrollPane,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TBrScrollable',
	#classTraits : 'TBrLayoutResizable classTrait + TBrScrollable classTrait',
	#instVars : [
		'scrollable'
	],
	#category : #'Brick-Scrollable - UI'
}

{ #category : #'api - scrollpane' }
BrScrollPane >> content: aStencil [
	self viewModel contentStencil: aStencil
]

{ #category : #initialization }
BrScrollPane >> initialize [
	super initialize.
	
	self viewModel: (BrScrollableModel new).
]
