"
I define basic appearance of {{gtClass:BrMenuSteppedElement}}. 
"
Class {
	#name : #BrMenuContainerAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #initialization }
BrMenuContainerAptitude >> initialize [
	super initialize.

	self
		addChangeProperty: #(widget geometry)
		with: [ BlChildrenWrappingGeometry
				cornerRadius: BrMenuConstants cornerRadius
				enlargedBy: 1 ].
	self
		addChangeProperty: #(widget border)
		with: [ BlBorder paint: Color veryLightGray width: 1 ].
	self addChangeProperty: #(widget outskirts) with: [ BlOutskirts outside ].
	self
		addChangeProperty: #(widget background)
		with: [ self theme default contentBackgroundColor ].

	self add: BrShadowAptitude new
]
