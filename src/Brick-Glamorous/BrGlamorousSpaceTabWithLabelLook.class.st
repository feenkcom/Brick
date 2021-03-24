Class {
	#name : #BrGlamorousSpaceTabWithLabelLook,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Tabs - Space'
}

{ #category : #initialization }
BrGlamorousSpaceTabWithLabelLook >> initialize [
	super initialize.
	
	self add: (BrGlamorousTextLabelLook new foreground: Color black).
	self add: BrGlamorousSpaceTabBasicLook new.
]
