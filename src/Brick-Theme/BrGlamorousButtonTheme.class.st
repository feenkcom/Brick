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

{ #category : #initialization }
BrGlamorousButtonTheme >> initializeColors [
	super initializeColors.

	pressedBorderColor := BrGlamorousColors pressedButtonBorderColor.

	defaultBorderColor := Color gray.

	defaultTextColor := Color white.

	hoveredBorderColor := BrGlamorousColors hoveredButtonBorderColor.

	pressedTextColor := BrGlamorousColors pressedButtonTextColor.

	hoveredTextColor := BrGlamorousColors hoveredButtonTextColor.

	textHighlightColor := BrGlamorousColors textHighlightColor.

	fadedBackgroundColor := BrGlamorousColors fadedButtonBackgroundColor.

	focusedFadedBackgroundColor := BrGlamorousColors hoveredButtonBorderColor
]

{ #category : #initialization }
BrGlamorousButtonTheme >> initializeConstants [
	super initializeConstants
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
