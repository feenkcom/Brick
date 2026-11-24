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
	^ self strongBorderColor
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
BrGlamorousDefaultTheme >> initializeThemeable [
	super initializeThemeable.

	contentBackground := self
			color: [ :aTheme | aTheme default constantAt: #contentBackground ]
			source: [ :aTheme | aTheme default contentBackground ].

	backdropBackground := self
			color: [ :aTheme | aTheme default constantAt: #backdropBackground ]
			source: [ :aTheme | aTheme default backdropBackground ].

	backdropEmphasisBackground := self
			color: [ :aTheme | aTheme default constantAt: #backdropEmphasisBackground ]
			source: [ :aTheme | aTheme default backdropEmphasisBackground ].

	navigationBackground := self
			color: [ :aTheme | aTheme default constantAt: #navigationBackground ]
			source: [ :aTheme | aTheme default navigationBackground ].

	appBackground := self
			color: [ :aTheme | aTheme default constantAt: #appBackground ]
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
			color: [ :aTheme | aTheme default constantAt: #strongBorderColor ]
			source: [ :aTheme | aTheme default strongBorderColor ].
	newsBackgroundColor := self
			color: [ :aTheme | aTheme default constantAt: #newsBackgroundColor ]
			source: [ :aTheme | aTheme default newsBackgroundColor ].
	lightBorderColor := self
			color: [ :aTheme | aTheme default constantAt: #subtleBorderColor ]
			source: [ :aTheme | aTheme default subtleBorderColor ].
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
	^ self subtleBorderColor
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

{ #category : #accessing }
BrGlamorousDefaultTheme >> strongBorderColor [
	^ darkBorderColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> strongBorderColor: aColor [
	self
		constantAt: #strongBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> subtleBorderColor [
	^ lightBorderColor
]

{ #category : #accessing }
BrGlamorousDefaultTheme >> subtleBorderColor: aColor [
	self
		constantAt: #subtleBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]
