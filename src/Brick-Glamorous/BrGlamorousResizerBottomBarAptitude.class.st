Class {
	#name : #BrGlamorousResizerBottomBarAptitude,
	#superclass : #BrAptitude,
	#category : 'Brick-Glamorous-Resizer'
}

{ #category : #accessing }
BrGlamorousResizerBottomBarAptitude >> initialize [
	super initialize.
	self
		addChangeProperty: #(widget background)
		with: [ self theme editor borderColor alpha: 0.5 ].
	self
		addChangeProperty: #(widget geometry)
		with: [ BlRoundedRectangleGeometry cornerRadius: 2 ].
	self
		addChangeProperty: #(widget constraints vertical resizer)
		with: [ BlLayoutResizer exact: 4.0 ].
	self
		addChangeProperty: #(widget constraints horizontal resizer)
		with: [ BlLayoutResizer exact: 70.0 ].
	self addChangeProperty: #(widget margin) with: [ BlInsets bottom: 4 ].
	self
		addChange:
			(BrLookChange new
				up: [ :e | 
					self widget
						constraintsDo: [ :c | 
							c ignoreByLayout.
							c ignored vertical alignBottom.
							c ignored horizontal alignCenter ] ];
				down: [ :e |  ];
				yourself)
]
