Class {
	#name : #BrGlamorousButtonIconAptitude,
	#superclass : #BrIconAptitude,
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #initialization }
BrGlamorousButtonIconAptitude >> initialize [
	super initialize.

	self
		add: (BrSizeAdjustmentAptitude new
				@ [ self icon ];
				huge: [ :aStyle | aStyle scaleBy: 2 ];
				large: [ :aStyle | aStyle scaleBy: 1.5 ];
				normal: [ :aStyle | aStyle scaleBy: 1 ];
				small: [ :aStyle | aStyle scaleBy: 0.75 ];
				tiny: [ :aStyle | aStyle scaleBy: 0.75 ];
				mini: [ :aStyle | aStyle scaleBy: 0.5 ]).
	self
		add: (BrLazyStyleCommonAptitude new
				@ [ self icon ];
				@ [ :anIcon | anIcon geometry isKindOf: BlSvgPath ];
				default: [ :aStyle | aStyle background: self theme button defaultTextForeground ];
				hovered: [ :aStyle | aStyle background: self theme button hoveredTextColor ];
				pressed: [ :aStyle | aStyle background: self theme button pressedTextColor ];
				disabled: [ :aStyle | aStyle background: self theme button disabledTextColor ];
				selected: [ :aStyle | aStyle background: self theme button hoveredTextColor ])
]
