"
I define basic appearance of menu widgets, e.g., geometry, border.
"
Class {
	#name : #BrPopoverCommonAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #initialization }
BrPopoverCommonAptitude >> initialize [
	super initialize.

	self
		addChangeProperty: #(widget geometry)
		with: [ BlRoundedRectangleGeometry cornerRadius: BrMenuConstants cornerRadius ].
]
