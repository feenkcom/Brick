Class {
	#name : #BrGlamorousToggleWithCheckedIconAndLabelAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Glamorous-Toggle'
}

{ #category : #initialization }
BrGlamorousToggleWithCheckedIconAndLabelAptitude >> initialize [
	super initialize.
	
	self add: BrGlamorousButtonIconAptitude new.	
	self add: BrGlamorousTextLabelAptitude new.
	self add: (BrGlamorousToggleRectangularAptitude new cornerRadius: 0).
	self add: BrGlamorousToggleBackgroundAptitude new.

	self add: (BrToggleAptitude new
		// #icon;
		activated: [ :aStyle | aStyle visibility: BlVisibility visible ];
		default: [ :aStyle | aStyle visibility: BlVisibility hidden ])
]
