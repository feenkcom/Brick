Class {
	#name : #BrGlamorousButtonWithIconAndLabelAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'labelAptitude'
	],
	#category : #'Brick-Glamorous-Buttons'
}

{ #category : #accessing }
BrGlamorousButtonWithIconAndLabelAptitude >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ labelAptitude attributesBuilder
]

{ #category : #accessing }
BrGlamorousButtonWithIconAndLabelAptitude >> defaultColor: aColor [
	labelAptitude defaultColor: aColor
]

{ #category : #accessing }
BrGlamorousButtonWithIconAndLabelAptitude >> foreground: aColor [
	labelAptitude defaultColor: aColor
]

{ #category : #accessing }
BrGlamorousButtonWithIconAndLabelAptitude >> hoveredColor: aColor [
	labelAptitude hoveredColor: aColor
]

{ #category : #initialization }
BrGlamorousButtonWithIconAndLabelAptitude >> initialize [
	super initialize.
	
	self addAll: {
		BrGlamorousButtonExteriorAptitude new.
		BrGlamorousButtonRectangularAptitude new.
		BrGlamorousButtonIconAptitude new.
		labelAptitude := BrGlamorousButtonLabelAptitude new.
	}
]

{ #category : #accessing }
BrGlamorousButtonWithIconAndLabelAptitude >> pressedColor: aColor [
	labelAptitude pressedColor: aColor
]

{ #category : #accessing }
BrGlamorousButtonWithIconAndLabelAptitude >> selectedColor: aColor [
	labelAptitude selectedColor: aColor
]
