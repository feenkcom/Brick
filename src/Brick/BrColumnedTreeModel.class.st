Class {
	#name : 'BrColumnedTreeModel',
	#superclass : 'BrAbstractTreeModel',
	#category : 'Brick-Tree - Model'
}

{ #category : 'initialization' }
BrColumnedTreeModel >> defaultRowElementStencil [
	^ BrColumnedTreeRowElementStencilBuilder new
]
