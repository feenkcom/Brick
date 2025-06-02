Class {
	#name : #BrGlamorousDefaultDarkTheme,
	#superclass : #BrGlamorousDefaultTheme,
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #initialization }
BrGlamorousDefaultDarkTheme >> initializeColors [
	super initializeColors.

	distinctTenStrongColors := BrGlamorousColors distinctTenStrongColors.

	newsBackgroundColor := BrGlamorousColors newsBackgroundColor.

	lightBorderColor := BrGlamorousColors lightBorderColor.

	expandCollapseTriangleBackgroundColor := BrGlamorousColors expandCollapseTriangleBackgroundColor.

	shadowColor := BrGlamorousColors shadowColor.

	distinctTenLightColors := BrGlamorousColors distinctTenLightColors.


]

{ #category : #initialization }
BrGlamorousDefaultDarkTheme >> initializeConstants [
	super initializeConstants.

	self constantAt: #defaultShadowColor put: (BrGlamorousColors defaultShadowColor).
	self constantAt: #primaryBorderColor put: (BrGlamorousColors primaryBorderColor).

]

{ #category : #initialization }
BrGlamorousDefaultDarkTheme >> initializeThemeable [
	super initializeThemeable.

	defaultShadowColor := self
			color: [ :aTheme | aTheme default constantAt: #defaultShadowColor ]
			source: [ :aTheme | aTheme default defaultShadowColor ].

	primaryBorderColor := self
			color: [ :aTheme | aTheme default constantAt: #primaryBorderColor ]
			source: [ :aTheme | aTheme default primaryBorderColor ].

	darkBorderColor := self
			color: [ :aTheme | BrGlamorousColors darkBorderColor ]
			source: [ :aTheme | aTheme default darkBorderColor ]
]
