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
]
