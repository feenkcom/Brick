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
		'pressedColor'
	],
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> defaultColor [
	^ defaultColor
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> defaultColor: aPaint [
	defaultColor := aPaint
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> hoveredColor [
	^ hoveredColor
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> hoveredColor: aPaint [
	hoveredColor := aPaint
]

{ #category : #initialization }
BrGlamorousButtonLabelAptitude >> initialize [
	super initialize.

	self
		weight: 400;
		fontName: 'Source Sans Pro'.

	defaultColor := self theme button defaultTextColor.
	selectedColor := self theme button hoveredTextColor.
	hoveredColor := self theme button hoveredTextColor.
	pressedColor := self theme button pressedTextColor.

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
			(BrLazyStyleCommonAptitude new
				@ labelElement;
				default: [ :aStyle | aStyle foreground: defaultColor ];
				hovered: [ :aStyle | aStyle foreground: hoveredColor ];
				pressed: [ :aStyle | aStyle foreground: pressedColor ];
				disabled: [ :aStyle | aStyle foreground: self theme button disabledTextColor ];
				selected: [ :aStyle | aStyle foreground: selectedColor ])
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> pressedColor [
	^ pressedColor
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> pressedColor: aPaint [
	pressedColor := aPaint
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> selectedColor [
	^ selectedColor
]

{ #category : #accessing }
BrGlamorousButtonLabelAptitude >> selectedColor: aPaint [
	selectedColor := aPaint
]
