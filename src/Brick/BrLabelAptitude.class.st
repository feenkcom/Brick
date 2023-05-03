Class {
	#name : #BrLabelAptitude,
	#superclass : #BrTextLabelAptitude,
	#category : #'Brick-Label - Look'
}

{ #category : #initialization }
BrLabelAptitude >> initialize [
	super initialize.

	self add: BrLayoutResizerAptitude new inherit.
	self add: (BrLayoutAlignmentAptitude new).
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal ].
]
