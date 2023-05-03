Class {
	#name : #BrGlamorousButtonExteriorAptitude,
	#superclass : #BrLazyStyleCommonAptitude,
	#instVars : [
		'backgroundPaint',
		'borderWidth',
		'borderPaint'
	],
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> backgroundPaint [
	^ backgroundPaint ifNil: [ self theme button defaultBackgroundColor ]
]

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> backgroundPaint: aPaint [
	backgroundPaint := aPaint
]

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> borderPaint [
	^ borderPaint ifNil: [ self theme button defaultBorderColor ]
]

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> borderPaint: aColor [
	borderPaint := aColor
]

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> borderWidth [
	^ borderWidth ifNil: [ 1 ]
]

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> borderWidth: anInteger [
	borderWidth := anInteger
]

{ #category : #initialization }
BrGlamorousButtonExteriorAptitude >> initialize [
	super initialize.

	self default: [ :aStyle |
		aStyle
			background: self backgroundPaint;
			border: (BlBorder paint: self borderPaint width: self borderWidth) ].

	self focused: [ :aStyle |
		aStyle border:
			(BlBorder
				paint: self theme button hoveredBorderColor
				width: self borderWidth) ].
	
	self hovered: [ :aStyle |
		aStyle border:
			(BlBorder
				paint: self theme button hoveredBorderColor
				width: self borderWidth) ].

	self pressed: [ :aStyle |
		aStyle border:
			(BlBorder
				paint: self theme button pressedBorderColor
				width: self borderWidth) ].

	self disabled: [ :aSyle |
		aSyle
			background: self theme button disabledBackgroundColor;
			border:
				(BlBorder
					paint: self theme button disabledBorderColor
					width: self borderWidth) ]
]
