Class {
	#name : #BrDropdownBottomLeftAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Dropdown - Look'
}

{ #category : #initialization }
BrDropdownBottomLeftAptitude >> initialize [
	super initialize.
	self
		addChange:
			(BrLookChange new
				up: [ :e | 
					| handle content |
					handle := widget childNamed: #handle.
					content := widget childNamed: #content.
					widget
						layout: BlLinearLayout vertical;
						constraintsDo: [ :c | 
							c horizontal fitContentLimited.
							c vertical fitContentLimited.
							c frame horizontal alignRight.
							c frame vertical alignTop ];
						padding:
							(BlInsets
								top: 0
								left: 0
								bottom: 0
								right: 0);
						removeChild: handle;
						addChildFirst: handle.
					content
						constraintsDo: [ :c | 
							c horizontal fitContentLimited.
							c vertical fitContentLimited ].
					handle
						constraintsDo: [ :c | 
							c linear horizontal alignRight.
							c linear vertical alignTop ] ];
				down: [ :e |  ];
				yourself)
]
