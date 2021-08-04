Class {
	#name : #BrDropdownCenterLeftAptitude,
	#superclass : #BrAptitude,
	#category : 'Brick-Dropdown - Look'
}

{ #category : #initialization }
BrDropdownCenterLeftAptitude >> initialize [
	super initialize.
	self
		addChange:
			(BrLookChange new
				up: [ :e | 
					| handle content |
					handle := widget childNamed: #handle.
					content := widget childNamed: #content.
					widget
						layout: BlFrameLayout new;
						constraintsDo: [ :c | 
							c horizontal fitContentLimited.
							c vertical fitContentLimited.
							c frame horizontal alignLeft.
							c frame vertical alignCenter ];
						removeChild: handle;
						addChild: handle.
					content
						margin: (BlInsets left: handle width);
						constraintsDo: [ :c | 
							c horizontal fitContent.
							c vertical fitContentLimitedOffset: handle height ].
					handle
						constraintsDo: [ :c | 
							c frame horizontal alignLeft.
							c frame vertical alignCenter ] ];
				down: [ :e |  ];
				yourself)
]
