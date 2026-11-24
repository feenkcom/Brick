Class {
	#name : #BrGlamorousDefaultTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'defaultShadowColor',
		'primaryBorderColor',
		'darkBorderColor',
		'distinctTenStrongColors',
		'newsBackgroundColor',
		'lightBorderColor',
		'expandCollapseTriangleBackgroundColor',
		'shadowColor',
		'distinctTenLightColors',
		'contentBackground',
		'backdropBackground',
		'navigationBackground',
		'appBackground',
		'backdropEmphasisBackground',
		'primaryShadowColor'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousDefaultTheme >> appBackground [
	^ appBackground
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> backdropBackground [
	^ backdropBackground
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> backdropEmphasisBackground [
	^ backdropEmphasisBackground
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> contentBackground [
	^ contentBackground
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> darkBorderColor [
	^ darkBorderColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> darkBorderColor: aColor [
	self
		constantAt: #darkBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> defaultShadowColor [
	^ defaultShadowColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> defaultShadowColor: aColor [
	self
		constantAt: #defaultShadowColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> distinctTenLightColors [
	^ distinctTenLightColors
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> distinctTenLightColors: aCollection [
	self
		constantAt: #distinctTenLightColors
		put: (aCollection collect: [ :aColor | aColor blocResolveColorForTheme: self theme ]).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> distinctTenStrongColors [
	^ distinctTenStrongColors
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> distinctTenStrongColors: aCollection [
	self
		constantAt: #distinctTenStrongColors
		put: (aCollection collect: [ :aColor | aColor blocResolveColorForTheme: self theme ]).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> expandCollapseTriangleBackgroundColor [
	^ expandCollapseTriangleBackgroundColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> expandCollapseTriangleBackgroundColor: aColor [
	self
		constantAt: #expandCollapseTriangleBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #initialization }
BrGlamorousDefaultTheme >> initializeConstants [
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
		put: BrGlamorousColors distinctTenLightColors
]

{ #category : #initialization }
BrGlamorousDefaultTheme >> initializeThemeable [
	super initializeThemeable.

	contentBackground := self
			color: [ :aTheme | aTheme colors contentBackgroundColor ]
			source: [ :aTheme | aTheme default contentBackground ].

	backdropBackground := self
			color: [ :aTheme | aTheme colors backdropBackgroundColor ]
			source: [ :aTheme | aTheme default backdropBackground ].

	backdropEmphasisBackground := self
			color: [ :aTheme | aTheme colors backdropEmphasisBackgroundColor ]
			source: [ :aTheme | aTheme default backdropEmphasisBackground ].

	navigationBackground := self
			color: [ :aTheme | aTheme colors sidebarBackgroundColor ]
			source: [ :aTheme | aTheme default navigationBackground ].

	appBackground := self
			color: [ :aTheme | aTheme colors appBackgroundColor ]
			source: [ :aTheme | aTheme default appBackground ].
	defaultShadowColor := self
			color: [ :aTheme | aTheme default constantAt: #defaultShadowColor ]
			source: [ :aTheme | aTheme default defaultShadowColor ].
	primaryShadowColor := self
			color: [ :aTheme | aTheme default constantAt: #primaryShadowColor ]
			source: [ :aTheme | aTheme default primaryShadowColor ].
	primaryBorderColor := self
			color: [ :aTheme | aTheme default constantAt: #primaryBorderColor ]
			source: [ :aTheme | aTheme default primaryBorderColor ].
	darkBorderColor := self
			color: [ :aTheme | aTheme default constantAt: #darkBorderColor ]
			source: [ :aTheme | aTheme default darkBorderColor ].
	newsBackgroundColor := self
			color: [ :aTheme | aTheme default constantAt: #newsBackgroundColor ]
			source: [ :aTheme | aTheme default newsBackgroundColor ].
	lightBorderColor := self
			color: [ :aTheme | aTheme default constantAt: #lightBorderColor ]
			source: [ :aTheme | aTheme default lightBorderColor ].
	expandCollapseTriangleBackgroundColor := self
			color: [ :aTheme | aTheme default constantAt: #expandCollapseTriangleBackgroundColor ]
			source: [ :aTheme | aTheme default expandCollapseTriangleBackgroundColor ].
	shadowColor := self
			color: [ :aTheme | aTheme default constantAt: #shadowColor ]
			source: [ :aTheme | aTheme default shadowColor ].
	distinctTenStrongColors := (self constantAt: #distinctTenStrongColors)
			withIndexCollect: [ :aColor :anIndex | 
				self
					color: [ :aTheme | (aTheme default constantAt: #distinctTenStrongColors) at: anIndex ]
					source: [ :aTheme | aTheme default distinctTenStrongColors at: anIndex ] ].
	distinctTenLightColors := (self constantAt: #distinctTenLightColors)
			withIndexCollect: [ :aColor :anIndex | 
				self
					color: [ :aTheme | (aTheme default constantAt: #distinctTenLightColors) at: anIndex ]
					source: [ :aTheme | aTheme default distinctTenLightColors at: anIndex ] ]
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> lightBorderColor [
	^ lightBorderColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> lightBorderColor: aColor [
	self
		constantAt: #lightBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> navigationBackground [
	^ navigationBackground
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> newsBackgroundColor [
	^ newsBackgroundColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> newsBackgroundColor: aColor [
	self
		constantAt: #newsBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> primaryBorderColor [
	^ primaryBorderColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> primaryBorderColor: aColor [
	self
		constantAt: #primaryBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> primaryShadowColor [
	^ primaryShadowColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> primaryShadowColor: aColor [
	self
		constantAt: #primaryShadowColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> shadowColor [
	^ shadowColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> shadowColor: aColor [
	self
		constantAt: #shadowColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]
