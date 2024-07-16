Class {
	#name : #BrColumnedTreeModel,
	#superclass : #BrAbstractTreeModel,
	#category : #'Brick-Tree - Model'
}

{ #category : #'as yet unclassified' }
BrColumnedTreeModel >> columnsDo: aFullBlockClosure [
	| columnModel |
	columnModel := self widgetModels
			detect: [ :each | each class == BrColumnedModel ].
	columnModel columnsDo: aFullBlockClosure
]

{ #category : #initialization }
BrColumnedTreeModel >> defaultRowElementStencil [
	^ BrColumnedTreeRowElementStencilBuilder new
]
