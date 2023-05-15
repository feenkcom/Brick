Class {
	#name : #BrGlamorousToggleGroupAptitude,
	#superclass : #BrToggleGroupAptitude,
	#category : #'Brick-Glamorous-Toggle'
}

{ #category : #initialization }
BrGlamorousToggleGroupAptitude >> initialize [
	super initialize.
	self
		addChangeProperty: #(widget layout)
		with: [ BlLinearLayout horizontal cellSpacing: 0 ].
	self
		addChangeProperty: #(widget geometry)
		with: [ BlRoundedRectangleGeometry cornerRadius: 3 ].
	self
		addChangeProperty: #(widget border)
		with:
			[ BlBorder paint: self theme button defaultBorderColor width: 1 ].
]
