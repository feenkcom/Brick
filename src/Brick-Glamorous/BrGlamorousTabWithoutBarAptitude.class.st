Class {
	#name : #BrGlamorousTabWithoutBarAptitude,
	#superclass : #BrTabAptitude,
	#category : #'Brick-Glamorous-Tabs'
}

{ #category : #initialization }
BrGlamorousTabWithoutBarAptitude >> initialize [
	super initialize.

	self
		add: (BrGlamorousTextLabelAptitude new
				foreground: self theme label defaultTextForeground).
	self add: BrLayoutAlignmentAptitude new.
	self addChangeProperty: #(widget layout) with: [ BlLinearLayout horizontal ].

	self
		add: (BrStyleCommonAptitude new
				default: [ :aStyle | 
					aStyle
						padding: (BlInsets
								top: 10
								left: 12
								bottom: 10
								right: 12) ])
]
