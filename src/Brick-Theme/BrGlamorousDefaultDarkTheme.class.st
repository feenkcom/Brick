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
	self constantAt: #primaryShadowColor put: BrAntColors blue8.
	self constantAt: #primaryBorderColor put: BrAntColors blue8.
	self constantAt: #strongBorderColor put: BrAntColors gray3.
	self constantAt: #subtleBorderColor put: BrAntColors gray9.
	self
		constantAt: #newsBackgroundColor
		put: BrGlamorousColors newsBackgroundColor.
	self
		constantAt: #expandCollapseTriangleBackgroundColor
		put: BrGlamorousColors expandCollapseTriangleBackgroundColor.
	self constantAt: #shadowColor put: BrGlamorousColors shadowColor.
	self
		constantAt: #distinctTenStrongColors
		put: (OrderedCollection new				
				add: BrAntColors red4;
				add: BrAntColors blue4;
				add: BrAntColors orange4;
				add: BrAntColors cyan4;
				add: BrAntColors green4;
				add: BrAntColors volcano4;
				add: BrAntColors purple4;
				add: BrAntColors magenta4;
				add: BrAntColors yellow4;
				add: BrAntColors gray4;
				yourself).
	self
		constantAt: #distinctTenLightColors
		put: BrGlamorousColors distinctTenLightColors.
	self constantAt: #navigationBackground put: (Color fromHexString: '#333333')
]
