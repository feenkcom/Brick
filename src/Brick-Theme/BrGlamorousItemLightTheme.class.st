Class {
	#name : #BrGlamorousItemLightTheme,
	#superclass : #BrGlamorousItemTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousItemLightTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #selectedColor put: BrGlamorousColors selectedListItemColor.
	self
		constantAt: #deselectedColor
		put: BrGlamorousColors deselectedListItemColor.
	self constantAt: #hoveredColor put: BrGlamorousColors hoveredListItemColor.
	self constantAt: #defaultColor put: BrGlamorousColors defaultListItemColor.
	self
		constantAt: #focusedBorderColor
		put: BrGlamorousColors focusedListItemBorder.
	self constantAt: #pressedColor put: BrGlamorousColors pressedListItemColor
]
