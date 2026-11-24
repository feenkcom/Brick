Class {
	#name : #BrGlamorousDefaultLightTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousDefaultLightTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #defaultShadowColor put: BrGlamorousColors defaultShadowColor.
	self constantAt: #primaryShadowColor put: BrGlamorousColors primaryBorderColor.
	self constantAt: #primaryBorderColor put: BrGlamorousColors primaryBorderColor.
	self constantAt: #darkBorderColor put: BrGlamorousColors darkBorderColor.
	self
		constantAt: #newsBackgroundColor
		put: BrGlamorousColors newsBackgroundColor.
	self constantAt: #lightBorderColor put: BrGlamorousColors lightBorderColor.
	self
		constantAt: #expandCollapseTriangleBackgroundColor
		put: BrGlamorousColors expandCollapseTriangleBackgroundColor.
	self constantAt: #shadowColor put: BrGlamorousColors shadowColor.
	self
		constantAt: #distinctTenStrongColors
		put: BrGlamorousColors distinctTenStrongColors.
	self
		constantAt: #distinctTenLightColors
		put: BrGlamorousColors distinctTenLightColors.
	self
		constantAt: #appBackground
		put: BrGlamorousColors defaultHeaderBackgroundColor.
	self constantAt: #contentBackground put: Color white.
	self constantAt: #backdropBackground put: BrGlamorousColors backdropColor.
	self
		constantAt: #backdropEmphasisBackground
		put: (Color fromHexString: '#D9D9D9').
	self
		constantAt: #navigationBackground
		put: BrGlamorousColors neutralBackgroundColor
]
