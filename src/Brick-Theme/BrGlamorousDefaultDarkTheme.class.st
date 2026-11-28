Class {
	#name : #BrGlamorousDefaultDarkTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousDefaultDarkTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #appBackground put: BrAntColors gray9.
	self constantAt: #contentBackground put: BrAntColors gray10.
	self constantAt: #backdropBackground put: BrAntColors gray10.
	self
		constantAt: #backdropEmphasisBackground
		put: (Color fromHexString: '#B3B3B3').

	self constantAt: #defaultShadowColor put: BrAntColors gray8.
	self constantAt: #primaryShadowColor put: BrAntColors blue6.
	self constantAt: #shadowColor put: BrGlamorousColors shadowColor.
	self constantAt: #primaryBorderColor put: BrAntColors blue6.
	self constantAt: #strongBorderColor put: BrAntColors gray3.
	self constantAt: #subtleBorderColor put: BrAntColors gray7.
	self
		constantAt: #newsBackgroundColor
		put: BrAntColors orange2.
	self
		constantAt: #expandCollapseTriangleBackgroundColor
		put: BrGlamorousColors expandCollapseTriangleBackgroundColor.
	self
		constantAt: #distinctTenStrongColors
		put: (OrderedCollection new				
				add: BrAntColors red2;
				add: BrAntColors blue2;
				add: BrAntColors orange2;
				add: BrAntColors cyan3;
				add: BrAntColors green2;
				add: BrAntColors purple2;
				add: BrAntColors volcano3;
				add: BrAntColors magenta3;
				add: BrAntColors yellow2;
				add: BrAntColors gray4;
				yourself).
	self
		constantAt: #distinctTenLightColors
		put: BrGlamorousColors distinctTenLightColors.
	self constantAt: #navigationBackground put: (Color fromHexString: '#333333')
]
