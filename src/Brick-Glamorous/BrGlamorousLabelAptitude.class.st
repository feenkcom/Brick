Class {
	#name : #BrGlamorousLabelAptitude,
	#superclass : #BrGlamorousTextLabelAptitude,
	#category : #'Brick-Glamorous-Label'
}

{ #category : #initialization }
BrGlamorousLabelAptitude >> initialize [
	super initialize.
	
	self add: BrLayoutAlignmentAptitude new.
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal ].
		
	self
		add:
			(BrLazyStyleCommonAptitude new
				@ labelElement;
				default: [ :aStyle | aStyle foreground: self theme label textColor  ])
]
