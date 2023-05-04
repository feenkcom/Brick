Class {
	#name : #BrGlamorousSpaceTabBasicAptitude,
	#superclass : #BrTabAptitude,
	#category : #'Brick-Glamorous-Tabs - Support'
}

{ #category : #initialization }
BrGlamorousSpaceTabBasicAptitude >> initialize [
	super initialize.
	self add: BrGlamorousSpaceTabActionbarAptitude new.
	self add: BrLayoutResizerAptitude inherit.
	self add: BrLayoutAlignmentAptitude new.
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal ].
	self
		add:
			(BrStyleCommonAptitude new
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
				deselected: [ :aStyle | 
					aStyle background:
						self theme default backdropColor darker ];
				when: [ :aState | aState deselected & aState hovered ]
					style: [ :aStyle | aStyle background: self theme default backdropColor ];
				selected: [ :aStyle | aStyle background: self theme default backdropColor ])
]
