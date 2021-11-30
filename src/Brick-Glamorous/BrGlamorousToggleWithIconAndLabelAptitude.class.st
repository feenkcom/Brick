Class {
	#name : #BrGlamorousToggleWithIconAndLabelAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Toggle'
}

{ #category : #initialization }
BrGlamorousToggleWithIconAndLabelAptitude >> initialize [
	super initialize.
	
	self add: BrGlamorousButtonIconAptitude new.	
	self add: BrGlamorousTextLabelAptitude new.
	self add: (BrGlamorousToggleRectangularAptitude new cornerRadius: 0).
	self add: BrGlamorousToggleBackgroundAptitude new.
]
