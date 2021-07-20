"
I am used by default by both simple and columned trees to update the row element according to the node
"
Class {
	#name : #BrDefaultTreeRowDataBinder,
	#superclass : #BrTreeRowDataBinder,
	#category : 'Brick-Tree - Stencil'
}

{ #category : #'api - instantiation' }
BrDefaultTreeRowDataBinder >> buildDefault [
	self rowElement
		childNamed: #toggle
		ifFound: [ :aToggleElement | 
			aToggleElement viewModel model: self itemNode.
			aToggleElement
				hide: self itemNode canBeExpanded not;
				expanded: self itemNode isExpanded;
				disabled: self itemNode canBeExpanded not.
			aToggleElement margin: (aToggleElement margin withLeft: self itemNode depth * 15) ]
]
