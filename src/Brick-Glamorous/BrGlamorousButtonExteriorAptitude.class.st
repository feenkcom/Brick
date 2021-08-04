Class {
	#name : #BrGlamorousButtonExteriorAptitude,
	#superclass : #BrStyleCommonAptitude,
	#instVars : [
		'backgroundPaint',
		'borderWidth',
		'borderPaint'
	],
	#category : 'Brick-Glamorous-Buttons - Support'
}

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> backgroundPaint [
	^ backgroundPaint
]

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> backgroundPaint: aPaint [
	backgroundPaint := aPaint.
	
	self default
		background: self backgroundPaint
]

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> borderPaint [
	^ borderPaint
]

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> borderPaint: aColor [
	borderPaint := aColor.
	
	self default
		border: (BlBorder paint: self borderPaint width: self borderWidth)
]

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
BrGlamorousButtonExteriorAptitude >> borderWidth: anInteger [
	borderWidth := anInteger
]

{ #category : #initialization }
BrGlamorousButtonExteriorAptitude >> initialize [
	super initialize.
	backgroundPaint := self theme button defaultBackgroundColor.
	borderPaint := self theme button defaultBorderColor.
	borderWidth := 1.
	self default
		background: self backgroundPaint;
		border: (BlBorder paint: self borderPaint width: self borderWidth).
	self focused
		border:
			(BlBorder
				paint: self theme button hoveredBorderColor
				width: self borderWidth).
	self hovered
		border:
			(BlBorder
				paint: self theme button hoveredBorderColor
				width: self borderWidth).
	self pressed
		border:
			(BlBorder
				paint: self theme button pressedBorderColor
				width: self borderWidth).
	self disabled
		background: self theme button disabledBackgroundColor;
		border:
			(BlBorder
				paint: self theme button disabledBorderColor
				width: self borderWidth)
]
