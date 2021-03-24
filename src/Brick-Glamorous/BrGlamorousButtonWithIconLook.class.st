Class {
	#name : #BrGlamorousButtonWithIconLook,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Buttons'
}

{ #category : #initialization }
BrGlamorousButtonWithIconLook >> initialize [
	super initialize.
	
	self addAll: {
		BrGlamorousButtonExteriorLook new.
		BrGlamorousButtonRectangularLook new.
		BrGlamorousButtonIconLook new.
		BrGlamorousButtonWithLabelTooltipLook new
	}
]
