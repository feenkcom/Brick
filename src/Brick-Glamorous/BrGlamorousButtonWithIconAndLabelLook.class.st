Class {
	#name : #BrGlamorousButtonWithIconAndLabelLook,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Buttons'
}

{ #category : #initialization }
BrGlamorousButtonWithIconAndLabelLook >> initialize [
	super initialize.
	
	self addAll: {
		BrGlamorousButtonExteriorLook new.
		BrGlamorousButtonRectangularLook new.
		BrGlamorousButtonIconLook new.
		BrGlamorousButtonLabelLook new.
	}
]
