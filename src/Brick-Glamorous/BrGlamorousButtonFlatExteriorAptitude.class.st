Class {
	#name : #BrGlamorousButtonFlatExteriorAptitude,
	#superclass : #BrLazyStyleCommonAptitude,
	#instVars : [
		'backgroundPaint',
		'hoveredBackgroundPaint'
	],
	#category : #'Brick-Glamorous-Buttons - Support'
}

{ #category : #accessing }
BrGlamorousButtonFlatExteriorAptitude >> backgroundPaint [
	^ backgroundPaint ifNil: [ Color transparent ]
]

{ #category : #accessing }
BrGlamorousButtonFlatExteriorAptitude >> backgroundPaint: aPaint [
	backgroundPaint := aPaint
]

{ #category : #accessing }
BrGlamorousButtonFlatExteriorAptitude >> disabledBackgroundPaint [
	^ self theme button disabledBackgroundColor
]

{ #category : #accessing }
BrGlamorousButtonFlatExteriorAptitude >> hoveredBackgroundPaint [
	^ hoveredBackgroundPaint ifNil: [ Color gray alpha: 0.15 ]
]

{ #category : #accessing }
BrGlamorousButtonFlatExteriorAptitude >> hoveredBackgroundPaint: aPaint [
	hoveredBackgroundPaint := aPaint
]

{ #category : #initialization }
BrGlamorousButtonFlatExteriorAptitude >> initialize [
	super initialize.

	self
		default: [ :aStyle | 
			aStyle
				background: self backgroundPaint;
				border: BlBorder empty ];
		focused: [ :aStyle | 
			aStyle
				border: (BlBorder paint: self theme button hoveredBorderColor width: 1) ];
		hovered: [ :aStyle | aStyle background: self hoveredBackgroundPaint ];
		pressed: [ :aStyle | aStyle background: self pressedBackgroundPaint ];
		disabled: [ :aStyle | aStyle background: self disabledBackgroundPaint ]
]

{ #category : #accessing }
BrGlamorousButtonFlatExteriorAptitude >> pressedBackgroundPaint [
	^ Color gray alpha: 0.3
]
