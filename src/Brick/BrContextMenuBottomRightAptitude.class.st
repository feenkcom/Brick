Class {
	#name : #BrContextMenuBottomRightAptitude,
	#superclass : #BrAptitude,
	#category : 'Brick-Context Menu - Look'
}

{ #category : #initialization }
BrContextMenuBottomRightAptitude >> initialize [
	super initialize.
	self
		addChange:
			(BrLookChange new
				up: [ :e | 
					widget
						layout: BlLinearLayout horizontal;
						constraintsDo: [ :c | 
							c horizontal fitContentLimited.
							c vertical fitContentLimited.
							c frame horizontal alignLeft.
							c frame vertical alignTop ].
	
					widget childWithId: #handle ifFound: [ :aHandle |
						widget
							padding: (BlInsets top: 0 left: 0 bottom: aHandle height right: aHandle width);
							removeChild: aHandle;
							addChildFirst: aHandle.
						aHandle constraintsDo: [ :c | 
							c linear horizontal alignLeft.
							c linear vertical alignTop ] ].
					
					widget childWithId: #content ifFound: [ :aContent |
						widget childWithId: #handle ifFound: [ :aHandle |
							aContent
								constraintsDo: [ :c | 
									c horizontal fitContentLimitedOffset: aHandle width.
									c vertical fitContentLimitedOffset: aHandle height ];
								margin: (BlInsets top: aHandle width) ] ] ];
				down: [ :e |  ];
				yourself)
]
