Class {
	#name : #BrDefaultListRowDataBinder,
	#superclass : #BrListRowDataBinder,
	#category : #'Brick-List - Stencil'
}

{ #category : #'api - instantiation' }
BrDefaultListRowDataBinder >> buildDefault [
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
