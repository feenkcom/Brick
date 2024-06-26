Class {
	#name : #BrSimpleTreeModel,
	#superclass : #BrAbstractTreeModel,
	#instVars : [
		'nodeElementStencil',
		'nodeDataBinder',
		'nodeUnbinder'
	],
	#category : 'Brick-Tree - Model'
}

{ #category : #initialization }
BrSimpleTreeModel >> defaultRowElementStencil [
	^ BrSimpleTreeRowElementStencilBuilder new
]

{ #category : #initialization }
BrSimpleTreeModel >> initialize [
	super initialize.
	
	nodeElementStencil := BrTreeNodeElementStencilBuilder new.
	nodeDataBinder := BrTreeNodeDataBinder new.
	nodeUnbinder := [ :anItemElement :anItem :aTreeNode | ]
]

{ #category : #initialization }
BrSimpleTreeModel >> initializeListeners [
	super initializeListeners.

	self when: BrTreeNodeElementStencilRequest reply: [ :aResponse | aResponse nodeElementStencil: self nodeElementStencil ].
	self when: BrTreeNodeDataBinderRequest reply: [ :aResponse | aResponse nodeDataBinder: self nodeDataBinder ]
]

{ #category : #accessing }
BrSimpleTreeModel >> nodeDataBinder [
	"Return a stencil that is used to bind node data to a given node element"
	<return: #BrTreeNodeDataBinder>

	^ nodeDataBinder
]

{ #category : #accessing }
BrSimpleTreeModel >> nodeDataBinder: aStencil [
	"Set a stencil that will be used to bind node data to a given node element"

	nodeDataBinder := aStencil asStencilBuilder: BrTreeNodeDataBinder.
	self dispatchEvent: (BrTreeNodeDataBinderChangedEvent new nodeDataBinder: nodeDataBinder)
]

{ #category : #accessing }
BrSimpleTreeModel >> nodeElementStencil [
	"Return a stencil that is used to create a node element of a given type"
	<return: #BrTreeNodeElementStencilBuilder>
	
	^ nodeElementStencil
]

{ #category : #accessing }
BrSimpleTreeModel >> nodeElementStencil: aStencil [
	"Set a stencil that will be used to create a node element of a given type"

	nodeElementStencil := aStencil asStencilBuilder: BrTreeNodeElementStencilBuilder.
	self dispatchEvent: (BrTreeNodeElementStencilChangedEvent new nodeElementStencil: nodeElementStencil)
]

{ #category : #accessing }
BrSimpleTreeModel >> nodeUnbinder [
	^ nodeUnbinder
]

{ #category : #accessing }
BrSimpleTreeModel >> nodeUnbinder: anObject [

	nodeUnbinder := anObject.
	self dispatchEvent: (BrTreeNodeUnbinderChangedEvent new nodeUnbinder: nodeUnbinder)
]
