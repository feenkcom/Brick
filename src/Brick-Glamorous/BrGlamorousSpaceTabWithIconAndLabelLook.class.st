Class {
	#name : #BrGlamorousSpaceTabWithIconAndLabelLook,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Tabs - Space'
}

{ #category : #initialization }
BrGlamorousSpaceTabWithIconAndLabelLook >> initialize [
	super initialize.
	
	self add: BrGlamorousSpaceTabIconLook new.
	self add: (BrGlamorousTextLabelLook new foreground: Color black).
	self add: BrGlamorousSpaceTabBasicLook new.
]
