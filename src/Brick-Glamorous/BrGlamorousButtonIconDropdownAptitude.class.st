Class {
	#name : #BrGlamorousButtonIconDropdownAptitude,
	#superclass : #BrIconDropdownAptitude,
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #initialization }
BrGlamorousButtonIconDropdownAptitude >> defaultIconElement [
	^ BrGlamorousVectorIcons downwards asElement
]

{ #category : #initialization }
BrGlamorousButtonIconDropdownAptitude >> initialize [
	super initialize.
			
	self add: (BrSizeAdjustmentAptitude new
		@ [ self icon ];
		huge: [ :aStyle | aStyle scaleBy: 2 ];
		large: [ :aStyle | aStyle scaleBy: 1.5 ];
		normal: [ :aStyle | aStyle scaleBy: 1 ];
		small: [ :aStyle | aStyle scaleBy: 0.75 ];
		tiny: [ :aStyle | aStyle scaleBy: 0.75 ];
		mini: [ :aStyle | aStyle scaleBy: 0.5 ])
]
