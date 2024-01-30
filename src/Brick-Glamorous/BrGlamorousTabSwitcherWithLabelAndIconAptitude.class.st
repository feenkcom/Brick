Class {
	#name : #BrGlamorousTabSwitcherWithLabelAndIconAptitude,
	#superclass : #BrGlamorousTabSwitcherAptitude,
	#category : #'Brick-Glamorous-Tabs - Switcher'
}

{ #category : #initialization }
BrGlamorousTabSwitcherWithLabelAndIconAptitude >> initialize [
	super initialize.

	self add: (BrGlamorousButtonLabelAndIconAptitude new
		defaultColor: Color black;
		hoveredColor: Color black;
		pressedColor: Color black;
		selectedColor: Color black).
	
	self addChangeProperty: #(widget geometry) with: [ 
		BlStadiumGeometry new ].
]
