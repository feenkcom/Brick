Class {
	#name : #BrGlamorousButtonWithLabelAptitude,
	#superclass : #BrAptitude,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'labelAptitude'
	],
	#category : #'Brick-Glamorous-Buttons'
}

{ #category : #accessing }
BrGlamorousButtonWithLabelAptitude >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ labelAptitude attributesBuilder
]

{ #category : #accessing }
BrGlamorousButtonWithLabelAptitude >> defaultColor: aColor [
	labelAptitude defaultColor: aColor
]

{ #category : #accessing }
BrGlamorousButtonWithLabelAptitude >> foreground: aColor [
	labelAptitude defaultColor: aColor
]

{ #category : #accessing }
BrGlamorousButtonWithLabelAptitude >> hoveredColor: aColor [
	labelAptitude hoveredColor: aColor
]

{ #category : #initialization }
BrGlamorousButtonWithLabelAptitude >> initialize [
	super initialize.
	
	self addAll: {
		BrGlamorousButtonExteriorAptitude new.
		BrGlamorousButtonRectangularAptitude new.
		labelAptitude := BrGlamorousButtonLabelAptitude new.
	}
]

{ #category : #accessing }
BrGlamorousButtonWithLabelAptitude >> pressedColor: aColor [
	labelAptitude pressedColor: aColor
]

{ #category : #accessing }
BrGlamorousButtonWithLabelAptitude >> selectedColor: aColor [
	labelAptitude selectedColor: aColor
]
