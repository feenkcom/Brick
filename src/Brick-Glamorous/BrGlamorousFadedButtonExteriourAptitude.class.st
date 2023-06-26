Class {
	#name : #BrGlamorousFadedButtonExteriourAptitude,
	#superclass : #BrLazyStyleCommonAptitude,
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #accessing }
BrGlamorousFadedButtonExteriourAptitude >> initialize [
	super initialize.

	self
		default: [ :aStyle | aStyle background: self theme button fadedBackgroundColor ];
		hovered: [ :aStyle | aStyle background: self theme button focusedFadedBackgroundColor ];
		selected: [ :aStyle | aStyle background: self theme button focusedFadedBackgroundColor ]
]
