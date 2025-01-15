"
I define basic appearance of menu widgets, e.g., geometry, border.
"
Class {
	#name : #BrMenuCommonAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #initialization }
BrMenuCommonAptitude >> initialize [
	super initialize.

	self
		addChangeProperty: #(widget geometry)
		with: [ BlRoundedRectangleGeometry cornerRadius: BrMenuConstants cornerRadius ].
]
