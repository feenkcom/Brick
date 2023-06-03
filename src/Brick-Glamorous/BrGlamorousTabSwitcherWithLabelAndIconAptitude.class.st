Class {
	#name : #BrGlamorousTabSwitcherWithLabelAndIconAptitude,
	#superclass : #BrGlamorousTabSwitcherAptitude,
	#category : #'Brick-Glamorous-Tabs - Switcher'
}

{ #category : #initialization }
BrGlamorousTabSwitcherWithLabelAndIconAptitude >> initialize [
	super initialize.

	self add: (BrGlamorousButtonLabelAndIconAptitude new).
	
	"self addChangeProperty: #(widget geometry) with: [ BlCircleGeometry new ]."
]
