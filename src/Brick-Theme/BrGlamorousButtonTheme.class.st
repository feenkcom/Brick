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
		'defaultBackgroundColor',
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
	^ defaultBackground ifNil: [ self defaultBackgroundColor ]
]

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultBackgroundColor [
	^ defaultBackgroundColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultBackgroundColor: anObject [
	defaultBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultBorderColor [
	^ defaultBorderColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultBorderColor: anObject [
	defaultBorderColor := anObject
]

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultTextColor [
	^ defaultTextColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> defaultTextColor: anObject [
	defaultTextColor := anObject
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
BrGlamorousButtonTheme >> disabledBackgroundColor: anObject [
	disabledBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousButtonTheme >> disabledBorderColor [
	^ disabledBorderColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> disabledBorderColor: anObject [
	disabledBorderColor := anObject
]

{ #category : #accessing }
BrGlamorousButtonTheme >> disabledTextColor [
	^ disabledTextColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> disabledTextColor: anObject [
	disabledTextColor := anObject
]

{ #category : #accessing }
BrGlamorousButtonTheme >> fadedBackgroundColor [
	^ fadedBackgroundColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> fadedBackgroundColor: anObject [
	fadedBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousButtonTheme >> focusedFadedBackgroundColor [
	^ focusedFadedBackgroundColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> focusedFadedBackgroundColor: anObject [
	focusedFadedBackgroundColor := anObject
]

{ #category : #accessing }
BrGlamorousButtonTheme >> hoveredBorderColor [
	^ hoveredBorderColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> hoveredBorderColor: anObject [
	hoveredBorderColor := anObject
]

{ #category : #accessing }
BrGlamorousButtonTheme >> hoveredTextColor [
	^ hoveredTextColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> hoveredTextColor: anObject [
	hoveredTextColor := anObject
]

{ #category : #'as yet unclassified' }
BrGlamorousButtonTheme >> initializeColors [
	"default state"
	defaultBackgroundColor := Color black.
	defaultTextColor := Color white.
	defaultBorderColor := Color gray.
	
	"disabled state"
	disabledBackgroundColor := Color black.
	disabledTextColor := Color gray.
	disabledBorderColor := Color gray.
	
	"pressed state"
	pressedBorderColor := BrGlamorousColors pressedButtonBorderColor.
	pressedTextColor := BrGlamorousColors pressedButtonTextColor.
	
	"hovered state"
	hoveredBorderColor := BrGlamorousColors hoveredButtonBorderColor.
	hoveredTextColor := BrGlamorousColors hoveredButtonTextColor.
	
	"faded button"
	fadedBackgroundColor := BrGlamorousColors fadedButtonBackgroundColor.
	focusedFadedBackgroundColor := BrGlamorousColors hoveredButtonBorderColor.
	
	textHighlightColor := BrGlamorousColors textHighlightColor
]

{ #category : #'as yet unclassified' }
BrGlamorousButtonTheme >> initializeThemeable [
	"default state"
	defaultBackground := self
		background: [ :aTheme | aTheme button defaultBackgroundColor ]
		source: [ :aTheme | aTheme button defaultBackground ].

	defaultTextForeground := self
		color: [ :aTheme | aTheme colors primaryTextColor ]
		source: [ :aTheme | aTheme button defaultTextForeground ]
]

{ #category : #accessing }
BrGlamorousButtonTheme >> pressedBorderColor [
	^ pressedBorderColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> pressedBorderColor: anObject [
	pressedBorderColor := anObject
]

{ #category : #accessing }
BrGlamorousButtonTheme >> pressedTextColor [
	^ pressedTextColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> pressedTextColor: anObject [
	pressedTextColor := anObject
]

{ #category : #accessing }
BrGlamorousButtonTheme >> textHighlightColor [
	^ textHighlightColor
]

{ #category : #accessing }
BrGlamorousButtonTheme >> textHighlightColor: anObject [
	textHighlightColor := anObject
]
