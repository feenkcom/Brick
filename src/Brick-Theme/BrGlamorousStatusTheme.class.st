Class {
	#name : #BrGlamorousStatusTheme,
	#superclass : #BlSubTheme,
	#instVars : [
		'successBackgroundColor',
		'successBorderColor',
		'neutralBackgroundColor',
		'errorBorderColor',
		'errorBackgroundColor',
		'failureBorderColor',
		'paleErrorBackgroundColor',
		'failureBackgroundColor',
		'changesBackgroundColor'
	],
	#category : #'Brick-Theme-Glamorous'
}

{ #category : #accessing }
BrGlamorousStatusTheme >> changesBackgroundColor [
	^ changesBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> changesBackgroundColor: aColor [
	self
		constantAt: #changesBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousStatusTheme >> errorBackgroundColor [
	^ errorBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> errorBackgroundColor: aColor [
	self
		constantAt: #errorBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousStatusTheme >> errorBorderColor [
	^ errorBorderColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> errorBorderColor: aColor [
	self
		constantAt: #errorBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousStatusTheme >> failureBackgroundColor [
	^ failureBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> failureBackgroundColor: aColor [
	self
		constantAt: #failureBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousStatusTheme >> failureBorderColor [
	^ failureBorderColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> failureBorderColor: aColor [
	self
		constantAt: #failureBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #initialization }
BrGlamorousStatusTheme >> initializeConstants [
	super initializeConstants.
	self
		constantAt: #successBackgroundColor
		put: BrGlamorousColors successBackgroundColor.
	self constantAt: #successBorderColor put: BrGlamorousColors successBorderColor.
	self
		constantAt: #neutralBackgroundColor
		put: BrGlamorousColors neutralBackgroundColor.
	self constantAt: #errorBorderColor put: BrGlamorousColors errorBorderColor.
	self
		constantAt: #errorBackgroundColor
		put: BrGlamorousColors errorBackgroundColor.
	self constantAt: #failureBorderColor put: BrGlamorousColors failureBorderColor.
	self
		constantAt: #paleErrorBackgroundColor
		put: BrGlamorousColors paleErrorBackgroundColor.
	self
		constantAt: #failureBackgroundColor
		put: BrGlamorousColors failureBackgroundColor.
	self
		constantAt: #changesBackgroundColor
		put: BrGlamorousColors failureBackgroundColor
]

{ #category : #initialization }
BrGlamorousStatusTheme >> initializeThemeable [
	super initializeThemeable.
	successBackgroundColor := self
			color: [ :aTheme | aTheme status constantAt: #successBackgroundColor ]
			source: [ :aTheme | aTheme status successBackgroundColor ].
	successBorderColor := self
			color: [ :aTheme | aTheme status constantAt: #successBorderColor ]
			source: [ :aTheme | aTheme status successBorderColor ].
	neutralBackgroundColor := self
			color: [ :aTheme | aTheme status constantAt: #neutralBackgroundColor ]
			source: [ :aTheme | aTheme status neutralBackgroundColor ].
	errorBorderColor := self
			color: [ :aTheme | aTheme status constantAt: #errorBorderColor ]
			source: [ :aTheme | aTheme status errorBorderColor ].
	errorBackgroundColor := self
			color: [ :aTheme | aTheme status constantAt: #errorBackgroundColor ]
			source: [ :aTheme | aTheme status errorBackgroundColor ].
	failureBorderColor := self
			color: [ :aTheme | aTheme status constantAt: #failureBorderColor ]
			source: [ :aTheme | aTheme status failureBorderColor ].
	paleErrorBackgroundColor := self
			color: [ :aTheme | aTheme status constantAt: #paleErrorBackgroundColor ]
			source: [ :aTheme | aTheme status paleErrorBackgroundColor ].
	failureBackgroundColor := self
			color: [ :aTheme | aTheme status constantAt: #failureBackgroundColor ]
			source: [ :aTheme | aTheme status failureBackgroundColor ].
	changesBackgroundColor := self
			color: [ :aTheme | aTheme status constantAt: #changesBackgroundColor ]
			source: [ :aTheme | aTheme status changesBackgroundColor ]
]

{ #category : #accessing }
BrGlamorousStatusTheme >> neutralBackgroundColor [
	^ neutralBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> neutralBackgroundColor: aColor [
	self
		constantAt: #neutralBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousStatusTheme >> paleErrorBackgroundColor [
	^ paleErrorBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> paleErrorBackgroundColor: aColor [
	self
		constantAt: #paleErrorBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousStatusTheme >> successBackgroundColor [
	^ successBackgroundColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> successBackgroundColor: aColor [
	self
		constantAt: #successBackgroundColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]

{ #category : #accessing }
BrGlamorousStatusTheme >> successBorderColor [
	^ successBorderColor
]

{ #category : #accessing }
BrGlamorousStatusTheme >> successBorderColor: aColor [
	self
		constantAt: #successBorderColor
		put: (aColor blocResolveColorForTheme: self theme).
	self initializeThemeable
]
