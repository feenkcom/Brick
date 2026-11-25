Class {
	#name : #BrMenuItemAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #initialization }
BrMenuItemAptitude >> initialize [
	super initialize.
	self
		add: (BrLazyStyleCommonAptitude new
				default: [ :aStyle :aTheme | aStyle background: aTheme item deselectedColor ];
				when: BlElementState hovered & BlElementState selected
					style: [ :aStyle :aTheme | aStyle background: aTheme item selectedColor ];
				when: BlElementState hovered not & BlElementState selected
					style: [ :aStyle :aTheme | aStyle background: aTheme item hoveredColor ];
				pressed: [ :aStyle :aTheme | aStyle background: aTheme item pressedColor ])
]
