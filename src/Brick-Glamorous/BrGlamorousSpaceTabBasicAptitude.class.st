Class {
	#name : #BrGlamorousSpaceTabBasicAptitude,
	#superclass : #BrTabAptitude,
	#category : #'Brick-Glamorous-Tabs - Support'
}

{ #category : #initialization }
BrGlamorousSpaceTabBasicAptitude >> initialize [
	super initialize.
	self add: BrGlamorousSpaceTabActionbarAptitude new.
	self add: BrLayoutAlignmentAptitude new.
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal ].
	self
		add:
			(BrLazyStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle margin: (BlInsets top: 0 right: 1).
					aStyle
						geometry:
							(BlRoundedRectangleGeometry
								cornerRadii:
									(BlCornerRadii new
										topLeft: 4;
										topRight: 4;
										bottomLeft: 0;
										bottomRight: 0)).
					aStyle
						padding:
							(BlInsets
								top: 4
								left: 10
								bottom: 4
								right: 10) ];
				when: (BlElementState deselected & BlElementState hovered not)
					style: [ :aStyle | aStyle background: Color transparent ];
				when: (BlElementState deselected & BlElementState hovered)
					style: [ :aStyle | aStyle background: self theme default backdropBackground ];
				selected: [ :aStyle | aStyle background: self theme default backdropBackground ])
]
