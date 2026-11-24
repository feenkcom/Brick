Class {
	#name : #BrGlamorousDefaultDarkTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousDefaultDarkTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #defaultShadowColor put: BrAntColors gray8.
	self constantAt: #primaryBorderColor put: BrGlamorousColors primaryBorderColor.
	self constantAt: #appBackground put: BrAntColors gray8.
	self constantAt: #contentBackground put: BrAntColors gray9.
	self constantAt: #backdropBackground put: BrAntColors gray9.
	self
		constantAt: #backdropEmphasisBackground
		put: (Color fromHexString: '#B3B3B3').
	self constantAt: #navigationBackground put: (Color fromHexString: '#333333')
]
