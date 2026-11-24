Class {
	#name : #BrGlamorousButtonTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'disabledBackgroundColor',
		'disabledTextColor',
		'disabledBorderColor',
		'pressedBorderColor',
		'defaultBorderColor',
		'defaultTextColor',
		'hoveredBorderColor',
		'pressedTextColor',
		'hoveredTextColor',
		'textHighlightColor',
		'fadedBackgroundColor',
		'focusedFadedBackgroundColor',
		'defaultBackground',
		'defaultTextForeground'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultBackground [
	^ defaultBackground
]

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultBorderColor [
	^ defaultBorderColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultBorderColor: aColor [
	self
		constantAt: #defaultBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultTextColor [
	^ defaultTextColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultTextColor: aColor [
	self
		constantAt: #defaultTextColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultTextForeground [
	^ defaultTextForeground
]

{ #category : #accessing }
BrGlamorousButtonTheme >> disabledBackgroundColor [
	^ disabledBackgroundColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> disabledBackgroundColor: aColor [
	self
		constantAt: #disabledBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousButtonTheme >> disabledBorderColor [
	^ disabledBorderColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> disabledBorderColor: aColor [
	self
		constantAt: #disabledBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousButtonTheme >> disabledTextColor [
	^ disabledTextColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> disabledTextColor: aColor [
	self
		constantAt: #disabledTextColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousButtonTheme >> fadedBackgroundColor [
	^ fadedBackgroundColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> fadedBackgroundColor: aColor [
	self
		constantAt: #fadedBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousButtonTheme >> focusedFadedBackgroundColor [
	^ focusedFadedBackgroundColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> focusedFadedBackgroundColor: aColor [
	self
		constantAt: #focusedFadedBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousButtonTheme >> hoveredBorderColor [
	^ hoveredBorderColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> hoveredBorderColor: aColor [
	self
		constantAt: #hoveredBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousButtonTheme >> hoveredTextColor [
	^ hoveredTextColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> hoveredTextColor: aColor [
	self
		constantAt: #hoveredTextColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #initialization }
BrGlamorousButtonTheme >> initializeThemeable [
	super initializeThemeable.

	disabledBackgroundColor := self
			color: [ :aTheme | aTheme button constantAt: #disabledBackgroundColor ]
			source: [ :aTheme | aTheme button disabledBackgroundColor ].

	defaultBackground := self
			color: [ :aTheme | aTheme button constantAt: #defaultBackground ]
			source: [ :aTheme | aTheme button defaultBackground ].

	defaultTextForeground := self
			color: [ :aTheme | aTheme colors primaryTextColor ]
			source: [ :aTheme | aTheme button defaultTextForeground ].
	disabledTextColor := self
			color: [ :aTheme | aTheme button constantAt: #disabledTextColor ]
			source: [ :aTheme | aTheme button disabledTextColor ].
	pressedBorderColor := self
			color: [ :aTheme | aTheme button constantAt: #pressedBorderColor ]
			source: [ :aTheme | aTheme button pressedBorderColor ].
	defaultBorderColor := self
			color: [ :aTheme | aTheme button constantAt: #defaultBorderColor ]
			source: [ :aTheme | aTheme button defaultBorderColor ].
	defaultTextColor := self
			color: [ :aTheme | aTheme button constantAt: #defaultTextColor ]
			source: [ :aTheme | aTheme button defaultTextColor ].
	hoveredBorderColor := self
			color: [ :aTheme | aTheme button constantAt: #hoveredBorderColor ]
			source: [ :aTheme | aTheme button hoveredBorderColor ].
	pressedTextColor := self
			color: [ :aTheme | aTheme button constantAt: #pressedTextColor ]
			source: [ :aTheme | aTheme button pressedTextColor ].
	hoveredTextColor := self
			color: [ :aTheme | aTheme button constantAt: #hoveredTextColor ]
			source: [ :aTheme | aTheme button hoveredTextColor ].
	textHighlightColor := self
			color: [ :aTheme | aTheme button constantAt: #textHighlightColor ]
			source: [ :aTheme | aTheme button textHighlightColor ].
	fadedBackgroundColor := self
			color: [ :aTheme | aTheme button constantAt: #fadedBackgroundColor ]
			source: [ :aTheme | aTheme button fadedBackgroundColor ].
	focusedFadedBackgroundColor := self
			color: [ :aTheme | aTheme button constantAt: #focusedFadedBackgroundColor ]
			source: [ :aTheme | aTheme button focusedFadedBackgroundColor ].
	disabledBorderColor := self
			color: [ :aTheme | aTheme button constantAt: #disabledBorderColor ]
			source: [ :aTheme | aTheme button disabledBorderColor ]
]

{ #category : #accessing }
BrGlamorousButtonTheme >> pressedBorderColor [
	^ pressedBorderColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> pressedBorderColor: aColor [
	self
		constantAt: #pressedBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousButtonTheme >> pressedTextColor [
	^ pressedTextColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> pressedTextColor: aColor [
	self
		constantAt: #pressedTextColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousButtonTheme >> textHighlightColor [
	^ textHighlightColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> textHighlightColor: aColor [
	self
		constantAt: #textHighlightColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]
