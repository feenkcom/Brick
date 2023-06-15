Class {
	#name : #BrGlamorousButtonWithLabelAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'labelAptitude'
	],
	#category : #'Brick-Glamorous-Buttons'
}

{ #category : #accessing }
BrGlamorousButtonWithLabelAptitude >> foreground: aColor [
	labelAptitude defaultColor: aColor
]

{ #category : #initialization }
BrGlamorousButtonWithLabelAptitude >> initialize [
	super initialize.
	
	self addAll: {
		BrGlamorousButtonExteriorAptitude new.
		BrGlamorousButtonRectangularAptitude new.
		labelAptitude := BrGlamorousButtonLabelAptitude new.
	}
]
