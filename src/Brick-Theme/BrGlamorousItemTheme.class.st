Class {
	#name : #BrGlamorousItemTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'selectedColor',
		'deselectedColor',
		'hoveredColor',
		'defaultColor',
		'focusedBorderColor',
		'pressedColor'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousItemTheme >> defaultColor [
	^ defaultColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> defaultColor: aColor [
	self
		constantAt: #defaultColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousItemTheme >> deselectedColor [
	^ deselectedColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> deselectedColor: aColor [
	self
		constantAt: #deselectedColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousItemTheme >> focusedBorderColor [
	^ focusedBorderColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> focusedBorderColor: aColor [
	self
		constantAt: #focusedBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousItemTheme >> hoveredColor [
	^ hoveredColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> hoveredColor: aColor [
	self
		constantAt: #hoveredColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #initialization }
BrGlamorousItemTheme >> initializeThemeable [
	super initializeThemeable.
	selectedColor := self
			color: [ :aTheme | aTheme item constantAt: #selectedColor ]
			source: [ :aTheme | aTheme item selectedColor ].
	deselectedColor := self
			color: [ :aTheme | aTheme item constantAt: #deselectedColor ]
			source: [ :aTheme | aTheme item deselectedColor ].
	hoveredColor := self
			color: [ :aTheme | aTheme item constantAt: #hoveredColor ]
			source: [ :aTheme | aTheme item hoveredColor ].
	defaultColor := self
			color: [ :aTheme | aTheme item constantAt: #defaultColor ]
			source: [ :aTheme | aTheme item defaultColor ].
	focusedBorderColor := self
			color: [ :aTheme | aTheme item constantAt: #focusedBorderColor ]
			source: [ :aTheme | aTheme item focusedBorderColor ].
	pressedColor := self
			color: [ :aTheme | aTheme item constantAt: #pressedColor ]
			source: [ :aTheme | aTheme item pressedColor ]
]

{ #category : #accessing }
BrGlamorousItemTheme >> pressedColor [
	^ pressedColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> pressedColor: aColor [
	self
		constantAt: #pressedColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousItemTheme >> selectedColor [
	^ selectedColor
]

{ #category : #accessing }
BrGlamorousItemTheme >> selectedColor: aColor [
	self
		constantAt: #selectedColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]
