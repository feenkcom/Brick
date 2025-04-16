"
I define basic appearance of menu widgets, e.g., geometry, border.
See more details about pinned elements in {{gtClass:BrPopoverPinnableAptitude}}. 
"
Class {
	#name : #BrPopoverPinnedAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #initialization }
BrPopoverPinnedAptitude >> initialize [
	super initialize.

	self
		addChangeProperty: #(widget border)
		with: [ BlBorder paint: Color veryLightGray width: 1 ].
	self
		addChangeProperty: #(widget outskirts)
		with: [ BlOutskirts outside ].
		
	self add: BrShadowAptitude new
]
