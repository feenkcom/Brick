"
I define how a label looks inside of the glamorous button, for example font size, family name, weight etc
"
Class {
	#name : #BrGlamorousButtonLabelAptitude,
	#superclass : #BrTextLabelAptitude,
	#instVars : [
		'selectedColor',
		'hoveredColor',
		'defaultColor',
		'pressedColor',
		'foregroundAptitude'
	],
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> defaultColor [
	^ defaultColor ifNil: [ self theme button defaultTextColor ]
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> defaultColor: aPaint [
	foregroundAptitude updateWith: [ defaultColor := aPaint ]
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> disabledTextColor [
	^ self theme button disabledTextColor
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> hoveredColor [
	^ hoveredColor ifNil: [ self theme button hoveredTextColor ]
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> hoveredColor: aPaint [
	foregroundAptitude updateWith: [ hoveredColor := aPaint ]
]

{ #category : #initialization }
BrGlamorousButtonLabelAptitude >> initialize [
	super initialize.

	self
		weight: 400;
		fontName: 'Source Sans Pro'.

	labelElement
		addAptitude:
			(BrSizeAdjustmentAptitude new
				mini: [ :aStyle | aStyle fontSizeEm: 0.55 ];
				tiny: [ :aStyle | aStyle fontSizeEm: 0.7 ];
				small: [ :aStyle | aStyle fontSizeEm: 0.85 ];
				normal: [ :aStyle | aStyle fontSizeEm: 1.0 ];
				large: [ :aStyle | aStyle fontSizeEm: 1.15 ];
				huge: [ :aStyle | aStyle fontSizeEm: 1.55 ]).
	self
		add:
			(foregroundAptitude := BrLazyStyleCommonAptitude new
				@ labelElement;
				default: [ :aStyle | aStyle foreground: self defaultColor ];
				hovered: [ :aStyle | aStyle foreground: self hoveredColor ];
				pressed: [ :aStyle | aStyle foreground: self pressedColor ];
				disabled: [ :aStyle | aStyle foreground: self disabledTextColor ];
				selected: [ :aStyle | aStyle foreground: self selectedColor ])
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> pressedColor [
	^ pressedColor ifNil: [ self theme button pressedTextColor ]
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> pressedColor: aPaint [
	foregroundAptitude updateWith: [ pressedColor := aPaint ]
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> selectedColor [
	^ selectedColor ifNil: [ self theme button hoveredTextColor ]
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> selectedColor: aPaint [
	foregroundAptitude updateWith: [ selectedColor := aPaint ]
]
