Class {
	#name : #BrGlamorousDefaultDarkTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousDefaultDarkTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #defaultShadowColor put: BrAntColors gray8.
	self constantAt: #primaryShadowColor put: BrAntColors blue4.
	self constantAt: #primaryBorderColor put: BrAntColors blue4.
	self constantAt: #strongBorderColor put: BrAntColors gray3.
	self
		constantAt: #newsBackgroundColor
		put: BrGlamorousColors newsBackgroundColor.
	self constantAt: #subtleBorderColor put: BrAntColors gray10.
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
	self constantAt: #appBackground put: BrAntColors gray9 .
	self constantAt: #contentBackground put: BrAntColors gray11.
	self constantAt: #backdropBackground put: BrAntColors gray10.
	self
		constantAt: #backdropEmphasisBackground
		put: (Color fromHexString: '#B3B3B3').
	self constantAt: #navigationBackground put: (Color fromHexString: '#333333')
]
