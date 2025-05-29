"
I define basic appearance of {{gtClass:BrMenuSteppedElement}}. 
"
Class {
	#name : #BrPopoverContainerAptitude,
	#superclass : #BrAptitude,
	#category : #'Brick-Menu - Aptitude'
}

{ #category : #initialization }
BrPopoverContainerAptitude >> initialize [
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
		with: [ self theme default contentBackground ].

	self add: BrShadowAptitude new
]
