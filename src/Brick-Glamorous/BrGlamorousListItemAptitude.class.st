Class {
	#name : #BrGlamorousListItemAptitude,
	#superclass : #BrLazyStyleCommonAptitude,
	#category : #'Brick-Glamorous-List, Tree'
}

{ #category : #initialization }
BrGlamorousListItemAptitude >> initialize [
	super initialize.
	self
		default: [ :aStyle | aStyle background: self theme item deselectedColor ];
		hovered: [ :aStyle | aStyle background: self theme item hoveredColor ];
		pressed: [ :aStyle | aStyle background: self theme item pressedColor ];
		focused: [ :aStyle | aStyle border: (BlBorder paint: self theme item focusedBorderColor width: 1) ];
		selected: [ :aStyle | aStyle background: self theme item selectedColor ]
]
