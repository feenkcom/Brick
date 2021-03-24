Class {
	#name : #BrGlamorousSpaceTabWithIconLook,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Tabs - Space'
}

{ #category : #initialization }
BrGlamorousSpaceTabWithIconLook >> initialize [
	super initialize.
	
	self add: BrIconLook new.
	self add: BrGlamorousSpaceTabBasicLook new.
]
