Class {
	#name : #BrGlamorousDefaultLightTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousDefaultLightTheme >> initializeConstants [
	super initializeConstants.
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
