Class {
	#name : #BrGlamorousButtonLayoutAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #initialization }
BrGlamorousButtonLayoutAptitude >> initialize [
	super initialize.
	
	self add: BrLayoutAlignmentAptitude new.
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal ]
]
