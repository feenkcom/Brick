Class {
	#name : #BrGlamorousShrinkingLabelAptitude,
	#superclass : #BrGlamorousLabelAptitude,
	#category : #'Brick-Glamorous-Label'
}

{ #category : #default }
BrGlamorousShrinkingLabelAptitude >> defaultLabelElement [
	^ BlShrinkingTextElement new
		text: 'Label' asRopedText;
		"labelMeasurement;"
		padding: (BlInsets all: 1);
		yourself.
]

{ #category : #initialize }
BrGlamorousShrinkingLabelAptitude >> initialize [
	super initialize.
	labelElement constraintsDo: [:c |
		c horizontal matchParent.
		c vertical matchParent ]
]
