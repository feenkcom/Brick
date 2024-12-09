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
		with: [ BlRoundedRectangleGeometry cornerRadius: 4 ].
	self
		addChangeProperty: #(widget border)
		with: [ BlBorder paint: Color veryLightGray width: 1 ].
	self
		addChangeProperty: #(widget outskirts)
		with: [ BlOutskirts outside ].
	self
		addChangeProperty: #(widget background)
		with: [ self theme default contentBackgroundColor ].
]
