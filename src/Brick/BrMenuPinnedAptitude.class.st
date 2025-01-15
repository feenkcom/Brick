Class {
	#name : #BrMenuPinnedAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #initialization }
BrMenuPinnedAptitude >> initialize [
	super initialize.

	self
		addChangeProperty: #(widget border)
		with: [ BlBorder paint: Color veryLightGray width: 1 ].
	self
		addChangeProperty: #(widget outskirts)
		with: [ BlOutskirts outside ].
		
	self add: BrShadowAptitude new
]
