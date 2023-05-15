Class {
	#name : #BrGlamorousSpaceTabActionbarAptitude,
	#superclass : #BrGlamorousTabActionbarAptitude,
	#category : #'Brick-Glamorous-Tabs - Support'
}

{ #category : #initialization }
BrGlamorousSpaceTabActionbarAptitude >> initialize [
	super initialize.

	actionbarContainer padding: actionbarContainer padding + (BlInsets top: 2).

	self add: (BrLazyStyleCommonAptitude new
		@ actionbarContainer;
		when: (BlElementState deselected & BlElementState hovered not)
			style: [ :aStyle | aStyle visibility: BlVisibility hidden ];
		when: (BlElementState deselected & BlElementState hovered)
			style: [ :aStyle | aStyle visibility: BlVisibility visible ];
		selected: [ :aStyle | aStyle visibility: BlVisibility visible ])
]
