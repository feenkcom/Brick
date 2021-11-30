Class {
	#name : #BrGlamorousToggleWithLabelAndIconAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Toggle'
}

{ #category : #initialization }
BrGlamorousToggleWithLabelAndIconAptitude >> initialize [
	super initialize.
	
	self add: BrGlamorousTextLabelAptitude new.
	self add: BrGlamorousButtonIconAptitude new.
	self add: (BrGlamorousToggleRectangularAptitude new cornerRadius: 0).
	self add: BrGlamorousToggleBackgroundAptitude new
]
