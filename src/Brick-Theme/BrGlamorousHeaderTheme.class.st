Class {
	#name : #BrGlamorousHeaderTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'textMarkupColor',
		'defaultBackgroundColor',
		'disabledTextColor',
		'defaultTextColor',
		'secondaryBackgroundColor',
		'defaultBackground'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousHeaderTheme >> defaultBackground [
	^ defaultBackground ifNil: [ self defaultBackgroundColor ]
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> defaultBackgroundColor: aColor [
	self
		constantAt: #defaultBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> defaultTextColor [
	^ defaultTextColor
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> defaultTextColor: aColor [
	self
		constantAt: #defaultTextColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> disabledTextColor [
	^ disabledTextColor
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> disabledTextColor: aColor [
	self
		constantAt: #disabledTextColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #initialization }
BrGlamorousHeaderTheme >> initializeConstants [
	super initializeConstants.
	self constantAt: #textMarkupColor put: BrGlamorousColors textMarkupColor.
	self
		constantAt: #defaultBackgroundColor
		put: BrGlamorousColors defaultHeaderBackgroundColor.
	self
		constantAt: #disabledTextColor
		put: BrGlamorousColors disabledHeaderTextColor.
	self
		constantAt: #defaultTextColor
		put: BrGlamorousColors defaultHeaderTextColor.
	self
		constantAt: #secondaryBackgroundColor
		put: BrGlamorousColors secondaryHeaderBackgroundColor
]

{ #category : #initialization }
BrGlamorousHeaderTheme >> initializeThemeable [
	super initializeThemeable.

	defaultBackground := self
			background: [ :aTheme | aTheme header constantAt: #defaultBackgroundColor ]
			source: [ :aTheme | aTheme header defaultBackground ].
	textMarkupColor := self
			color: [ :aTheme | aTheme header constantAt: #textMarkupColor ]
			source: [ :aTheme | aTheme header textMarkupColor ].
	defaultBackgroundColor := self
			color: [ :aTheme | aTheme header constantAt: #defaultBackgroundColor ]
			source: [ :aTheme | aTheme header defaultBackgroundColor ].
	disabledTextColor := self
			color: [ :aTheme | aTheme header constantAt: #disabledTextColor ]
			source: [ :aTheme | aTheme header disabledTextColor ].
	defaultTextColor := self
			color: [ :aTheme | aTheme header constantAt: #defaultTextColor ]
			source: [ :aTheme | aTheme header defaultTextColor ].
	secondaryBackgroundColor := self
			color: [ :aTheme | aTheme header constantAt: #secondaryBackgroundColor ]
			source: [ :aTheme | aTheme header secondaryBackgroundColor ]
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> secondaryBackgroundColor [
	^ secondaryBackgroundColor
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> secondaryBackgroundColor: aColor [
	self
		constantAt: #secondaryBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> textMarkupColor [
	^ textMarkupColor
]

{ #category : #accessing }
BrGlamorousHeaderTheme >> textMarkupColor: aColor [
	self
		constantAt: #textMarkupColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]
